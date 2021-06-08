<template>
  <a-card :bordered="false" :style="{minHeight: '592px'}">
    <a-drawer
      title="配置角色权限"
      :width="720"
      :visible="powerVisible"
      :body-style="{ paddingBottom: '80px' }"
      @close="onClose"
    >
      <a-tabs :default-active-key="currentTab" @change="changeTab">
        <a-tab-pane key="1">
          <span slot="tab">
            <a-icon type="menu" />配置菜单
          </span>

          <div class="table-operator">
            <a-button type="primary" @click="saveRoleMenus">保存</a-button>
          </div>

          <a-tree
            v-model="checkedKeys"
            checkable
            :expanded-keys="expandedKeys"
            :auto-expand-parent="autoExpandParent"
            :tree-data="menuList"
            @expand="onExpand"
            :replaceFields="{title: 'name', key: 'id', children: 'children'}"
          />
        </a-tab-pane>
        <a-tab-pane key="2">
          <span slot="tab">
            <a-icon type="control" />配置页面按钮权限
          </span>
          <div class="table-operator">
            <a-button type="primary" @click="saveRoleMenuPermissons">保存</a-button>
          </div>
          <a-row :gutter="16" v-for="(permission, index) in permissions" :key="index">
            <a-col :xl="4" :lg="24">{{ permission.name }}：</a-col>
            <a-col :xl="20" :lg="24">
              <a-checkbox
                v-if="permission.actionsOptions.length > 0"
                :indeterminate="permission.indeterminate"
                :checked="permission.checkedAll"
                @change="onChangeCheckAll($event, permission)"
              >全选</a-checkbox>
              <a-checkbox-group
                :options="permission.actionsOptions"
                v-model="permission.selected"
                @change="onChangeCheck(permission)"
              />
            </a-col>
          </a-row>
        </a-tab-pane>
      </a-tabs>
    </a-drawer>

    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="handleCreate()">新建角色</a-button>
    </div>

    <s-table
      ref="list"
      rowKey="id"
      size="default"
      :columns="columns"
      :data="loadData"
      :pagination="false"
    >
      <span slot="action" slot-scope="text, record">
        <template>
          <a @click="showDrawer(record)">
            <a-icon type="tool" />配置权限
          </a>
          <a-divider type="vertical" />
          <a @click="handleEdit(record)">
            <a-icon type="edit" />编辑
          </a>
          <a-divider type="vertical" />
          <a @click="handleDelete(record)">
            <a-icon type="delete" />删除
          </a>
        </template>
      </span>

      <span slot="uniqueKey" slot-scope="uniqueKey">
        <a-tag>{{ uniqueKey }}</a-tag>
      </span>
    </s-table>

    <a-modal
      :title="formFlag == 1 ? '创建角色' : '修改角色'"
      style="top: 20px;"
      :width="800"
      @cancel="cancel"
      v-model="visible"
      @ok="handleOk"
    >
      <a-form :form="form" :labelCol="labelCol" :wrapperCol="wrapperCol">
        <a-form-item label="权限唯一键">
          <a-input
            placeholder="请输入权限唯一键!"
            v-decorator="['uniqueKey', { rules: [{ required: true, message: '请输入权限唯一键!' }] }]"
          />
        </a-form-item>

        <a-form-item label="角色名称">
          <a-input
            placeholder="请输入角色名称!"
            v-decorator="['name', { rules: [{ required: true, message: '请输入角色名称!' }] }]"
          />
        </a-form-item>

        <a-form-item label="角色备注">
          <a-textarea :rows="3" placeholder="请输入角色备注!" v-decorator="['remark']" />
        </a-form-item>
      </a-form>
    </a-modal>
  </a-card>
</template>

<script>
import STable from "@/components/table";
import {
  getMenus,
  getRoles,
  getMenuPermissions,
  editRole,
  deleteRole,
  saveRoleMenus,
  saveRoleMenuPermissons,
  getMenuAndMenuPermissions
} from "@/services/system";
import { actionToObject } from "@/utils/util";
import pick from "lodash.pick";
export default {
  name: "RoleList",
  components: {
    STable
  },
  data() {
    return {
      expandedKeys: [],
      autoExpandParent: true,
      checkedKeys: [],
      permissions: [],
      initPermissions: [],
      layout: {
        labelCol: { span: 4 },
        wrapperCol: { span: 14 }
      },
      powerVisible: false,
      currentTab: 1,
      currentRoleId: 0,
      menuList: [],
      visible: false,
      rolesMap: [],
      form: this.$form.createForm(this),
      formFlag: 1,
      labelCol: {
        xs: { span: 24 },
        sm: { span: 5 }
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 16 }
      },
      mdl: {},
      // 表头
      columns: [
        {
          title: "Id",
          dataIndex: "id",
          key: "id"
        },
        {
          title: "唯一键",
          dataIndex: "uniqueKey",
          key: "uniqueKey",
          scopedSlots: { customRender: "uniqueKey" }
        },
        {
          title: "角色名称",
          dataIndex: "name",
          key: "name"
        },
        {
          title: "备注说明",
          dataIndex: "remark",
          key: "remark"
        },
        {
          title: "创建时间",
          dataIndex: "createdTime",
          key: "createdTime"
        },
        {
          title: "操作",
          dataIndex: "action",
          scopedSlots: { customRender: "action" },
          key: "action"
        }
      ],
      loadData: parameter => {
        return getRoles(parameter).then(res => {
          return res.data;
        });
      }
    };
  },
  created() {
    this.getMenus();
    this.loadPermissions();
  },
  methods: {
    changeTab(tab) {
      this.currentTab = tab;
    },
    saveRoleMenuPermissons() {
      let permissions = this.permissions.map(item => {
        let actions = item.actionsOptions;
        let operation = [];
        for (let i = 0; i < actions.length; i++) {
          for (let j = 0; j < item.selected.length; j++) {
            if (item.selected[j] == actions[i].value) {
              let index = actions[i].value.lastIndexOf("-");
              operation.push({
                action: actions[i].value.substr(index+1),
                describe: actions[i].label,
              });
              break;
            }
          }
        }
        return {
          menuId: item.id,
          operation: JSON.stringify(operation)
        };
      });

      saveRoleMenuPermissons({
        roleId: this.currentRoleId,
        permissions: permissions
      }).then(res => {
        if(res.code == 200){
          this.$message.success("配置配置页面按钮权限成功");
        }else{
          this.$message.error(res.message);
        }
      });
    },
    saveRoleMenus() {
      saveRoleMenus({
        roleId: this.currentRoleId,
        menuIds: this.checkedKeys.join(",")
      }).then(res => {
        if(res.code == 200){
          this.$message.success("配置菜单成功");
        }else{
          this.$message.error(res.message);
        }
      });
    },
    getMenus() {
      getMenus().then(res => {
        this.menuList = this.processMenuList(res.data);
        this.expandedKeys = this.menuList.map(item => {
          return item.id;
        });
      });
    },
    loadPermissions() {
      getMenuPermissions().then(res => {
        const result = res.data;
        this.permissions = result.map(item => {
          const options = actionToObject(item.permissions);
          item.checkedAll = false;
          item.selected = [];
          item.indeterminate = false;
          item.actionsOptions = options.map(option => {
            return {
              label: option.describe,
              value: `${item.id}-${option.action}`
            };
          });
          return item;
        });
        this.initPermissions = JSON.parse(JSON.stringify(this.permissions));
      });
    },
    onChangeCheck(permission) {
      permission.indeterminate =
        !!permission.selected.length &&
        permission.selected.length < permission.actionsOptions.length;
      permission.checkedAll =
        permission.selected.length === permission.actionsOptions.length;
    },
    onChangeCheckAll(e, permission) {
      Object.assign(permission, {
        selected: e.target.checked
          ? permission.actionsOptions.map(obj => obj.value)
          : [],
        indeterminate: false,
        checkedAll: e.target.checked
      });
    },
    processMenuList(menuList) {
      return menuList.map(item => {
        if (item.children && item.children.length > 0) {
          item.children = this.processMenuList(item.children);
        } else {
          delete item.children;
        }
        return item;
      });
    },
    onExpand(expandedKeys) {
      this.expandedKeys = expandedKeys;
      this.autoExpandParent = false;
    },
    showDrawer(record) {
      this.permissions = JSON.parse(JSON.stringify(this.initPermissions));
      this.currentRoleId = record.id;
      this.powerVisible = true;
      getMenuAndMenuPermissions({ roleId: record.id }).then(res => {
        let { menuIds, permissions: rolePermissions } = res.data;
        this.checkedKeys = menuIds.split(",").map(item => Number(item));
        // 有权限表，处理勾选
        if (this.permissions && rolePermissions && rolePermissions.length > 0) {
          // 先处理要勾选的权限结构
          const permissionsAction = {};
          rolePermissions.forEach(item => {
            let operation = JSON.parse(item.operation);
            permissionsAction[item.menuId] = operation.map(
              entity => `${item.menuId}-${entity.action}`
            );
          });
          this.permissions.forEach(permission => {
            const selected = permissionsAction[permission.id];
            permission.selected = selected || [];
            this.onChangeCheck(permission);
          });
        }
      });
    },
    onClose() {
      this.powerVisible = false;
      this.currentTab = 1;
    },
    handleEdit(record) {
      this.visible = true;
      this.formFlag = 2;
      this.$nextTick(() => {
        this.form.setFieldsValue(
          pick(
            record,
            "name",
            "remark",
            "uniqueKey"
          )
        );
      });
    },
    handleCreate() {
      this.visible = true;
      this.form.resetFields();
      this.formFlag = 1;
    },
    cancel() {
      this.form.resetFields();
    },
    handleDelete(record) {
      let model = this.$confirm({
        title: "提示",
        content: "确定要删除该角色吗?",
        onOk: () => {
          return deleteRole({ roleId: record.id }).then(res => {
            if(res.code == 200){
              this.$message.success("删除角色成功");
              this.$refs.list.refresh();
            }else{
              this.$message.error(res.message);
            }
            model.destroy();
          });
        },
        onCancel() {}
      });
    },
    handleOk(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          editRole(values).then(res => {
            if (res.code == 200) {
              this.$message.success(this.formFlag == 1 ? "创建" : "修改"+ "角色成功");
              this.visible = false;
              this.$refs.list.refresh();
            } else {
              this.$message.error(res.message);
            }
          });
        }
      });
    }
  }
};
</script>
<style scoped lang="less">
  /deep/ .ant-row {
    margin-bottom: 12px;
  }
</style>