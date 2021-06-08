<template>
  <a-card :bordered="false" :style="{minHeight: '592px'}">
    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="handleCreate">新建根菜单</a-button>
    </div>
    <s-table
      ref="list"
      rowKey="id"
      size="default"
      :columns="columns"
      :data="loadData"
      :pagination="false"
      childrenColumnName="children"
    >
      <span slot="name" slot-scope="text, record">
        <a-icon v-if="record.icon" style="margin-left:6px;" :type="record.icon" />
        {{ record.name }}
      </span>

      <span slot="path" slot-scope="text, record">
        <a-tag>{{ record.path }}</a-tag>
      </span>

      <span slot="component" slot-scope="text, record">
        <a-tag>{{ record.component }}</a-tag>
      </span>

      <span slot="invisible" slot-scope="text, record">
        <a-badge
          :color="record.invisible | invisibleColor"
          :text="record.invisible | invisibleText"
        />
      </span>

      <span slot="cacheAble" slot-scope="text, record">
        <a-badge
          :color="record.cacheAble | cacheAbleColor"
          :text="record.cacheAble | cacheAbleText"
        />
      </span>

      <span slot="action" slot-scope="text, record">
        <a @click="handleAddSub(record)">
          <a-icon type="plus" />新增子菜单
        </a>
        <a-divider type="vertical" />
        <a @click="handleEdit(record)">
          <a-icon type="edit" />编辑
        </a>
        <a-divider type="vertical" />
        <a @click="handleDelete(record)">
          <a-icon type="delete" />删除
        </a>
      </span>
    </s-table>

    <a-modal
      class="edit-modal"
      :title="formFlag == 1 ? '创建系统根菜单' : formFlag == 2 ? '编辑系统菜单' : '创建系统菜单'"
      :width="800"
      v-model="visible"
      @cancel="cancel"
      @ok="handleOk"
    >
      <a-form labelWidth="260" :form="form" :labelCol="labelCol" :wrapperCol="wrapperCol">
        <a-row :gutter="24">
          <a-col :span="12">
            <a-form-item :required="true" label="路由">
              <a-input
                placeholder="请输入路由!"
                v-decorator="['path', { rules: [{ required: true, message: '请输入路由!' }] }]"
              />
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="菜单名称">
              <a-input
                placeholder="请输入菜单名称!"
                v-decorator="['name', { rules: [{ required: true, message: '请输入菜单名称!' }] }]"
              />
            </a-form-item>
          </a-col>
        </a-row>
        <a-row :gutter="24">
          <a-col :span="12">
            <a-form-item label="是否隐藏菜单">
              <a-select
                placeholder="请选择是否隐藏菜单!"
                v-decorator="['invisible', { rules: [{ required: true, message: '请选择是否隐藏菜单!' }] }]"
              >
                <a-select-option
                  :key="item.key"
                  v-for="item in invisibleMap"
                  :value="item.key"
                >{{ item.text }}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="是否缓存页面">
              <a-select
                placeholder="请选择是否缓存页面!"
                v-decorator="['cacheAble', { rules: [{ required: true, message: '请选择是否缓存页面!' }] }]"
              >
                <a-select-option
                  :key="item.key"
                  v-for="item in cacheAbleMap"
                  :value="item.key"
                >{{ item.text }}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
        </a-row>
        <a-row :gutter="24">
          <a-col :span="12">
            <a-form-item label="组件名称">
              <a-select
                placeholder="请选择组件名称!"
                v-decorator="['component', { rules: [{ required: true, message: '请选择组件名称!' }] }]"
              >
                <a-select-option
                  :key="index"
                  v-for="(item,index) in constantRouterComponents"
                  :value="index"
                >{{ index }}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="排序">
              <a-input
                placeholder="请输入排序!"
                v-decorator="['sort', { rules: [{ required: true, message: '请输入排序!' }] }]"
              />
            </a-form-item>
          </a-col>
        </a-row>
        <a-row :gutter="24">
          <a-col :span="12">
            <a-form-item label="父节点">
              <a-tree-select
                v-if="formFlag == 1"
                disabled="disabled"
                v-decorator="['parentId']"
                placeholder="根节点"
                defaultValue="0"
                style="width: 100%"
              ></a-tree-select>
              <a-tree-select
                v-else
                placeholder="请选择父节点!"
                v-decorator="['parentId', { rules: [{ required: true, message: '请选择父节点!' }] }]"
                style="width: 100%"
                :dropdown-style="{ maxHeight: '400px', overflow: 'auto' }"
                :tree-data="menuList"
                tree-default-expand-all
                :replaceFields="{title: 'name', key: 'id', value: 'id', children: 'children'}"
              ></a-tree-select>
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="图标">
              <a-select
                v-if="formFlag == 3"
                placeholder
                disabled="disabled"
                v-decorator="['icon',{initialValue: '' }]"
              >
                <a-select-option :key="index" v-for="(item,index) in iconList" :value="item">
                  <a-icon :type="item" style="margin-right:6px;" />
                  {{ item }}
                </a-select-option>
              </a-select>
              <a-select
                v-else
                placeholder="请选择图标!"
                v-decorator="['icon', { rules: [{ required: true, message: '请选择图标!' }] }]"
              >
                <a-select-option :key="index" v-for="(item,index) in iconList" :value="item">
                  <a-icon :type="item" style="margin-right:6px;" />
                  {{ item }}
                </a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
        </a-row>
        <a-row :gutter="24">
          <a-col :span="24">
            <a-button size="small" class="editable-add-btn" @click="handlePermissionAdd">增加页面菜单权限</a-button>
            <a-table
              :locale="{emptyText: '暂无数据'}"
              rowKey="index"
              :columns="permissionColumn"
              :data-source="permissionData"
              bordered
              :pagination="false"
            >
              <template v-for="col in ['action', 'describe']" :slot="col" slot-scope="text, record">
                <div :key="col">
                  <a-input
                    v-if="record.editable"
                    style="margin: -5px 0"
                    :value="text"
                    @change="e => handlePermissionChange(e.target.value, record.action, col)"
                  />
                  <template v-else>{{ text }}</template>
                </div>
              </template>
              <template slot="operation" slot-scope="text, record">
                <div class="editable-row-operations">
                  <a style="margin-left:6px;" @click="() => removePermission(record.action)">删除</a>
                </div>
              </template>
            </a-table>
          </a-col>
        </a-row>
      </a-form>
    </a-modal>
  </a-card>
</template>

<script>
const permissionColumn = [
  {
    title: "权限Action",
    dataIndex: "action",
    scopedSlots: { customRender: "action" }
  },
  {
    title: "权限Describe",
    dataIndex: "describe",
    scopedSlots: { customRender: "describe" }
  },
  {
    title: "操作",
    dataIndex: "operation",
    scopedSlots: { customRender: "operation" }
  }
];

import STable from "@/components/table";
import {
  getMenus,
  getMenuPermissions,
  addMenu,
  editMenu,
  deleteMenu
} from "@/services/system";
import { invisibleMap, cacheAbleMap, customIcon } from "@/enums/system";
import { constantRouterComponents } from "@/router/config";
import pick from "lodash.pick";
export default {
  name: "MenuList",
  components: {
    STable
  },
  data() {
    return {
      permissionData: [],
      permissionColumn: permissionColumn,
      editingKey: "",
      visible: false,
      formFlag: 1,
      editId: 0,
      labelCol: {
        xs: { span: 24 },
        sm: { span: 7 }
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 16 }
      },
      form: this.$form.createForm(this),
      invisibleMap: invisibleMap,
      cacheAbleMap: cacheAbleMap,
      constantRouterComponents: constantRouterComponents,
      iconList: customIcon,
      menuList: [],
      allMenuMap: [],
      columns: [
        {
          title: "Id",
          dataIndex: "id"
        },
        {
          title: "菜单名称",
          dataIndex: "name",
          scopedSlots: { customRender: "name" }
        },
        {
          title: "路径",
          dataIndex: "path",
          scopedSlots: { customRender: "path" }
        },
        {
          title: "组件名称",
          dataIndex: "component",
          scopedSlots: { customRender: "component" }
        },
        {
          title: "菜单是否隐藏",
          dataIndex: "invisible",
          scopedSlots: { customRender: "invisible" }
        },
        {
          title: "页面是否缓存",
          dataIndex: "cacheAble",
          scopedSlots: { customRender: "cacheAble" }
        },
        {
          title: "排序",
          dataIndex: "sort"
        },
        {
          title: "操作",
          width: "260px",
          dataIndex: "action",
          scopedSlots: { customRender: "action" }
        }
      ],
      loadData: parameter => {
        return getMenus(parameter).then(res => {
          this.menuList = this.processMenuList(res.data);
          return this.menuList;
        });
      }
    };
  },
  filters: {
    invisibleColor(val) {
      return invisibleMap.find(item => item.key == val)["color"];
    },
    cacheAbleColor(val) {
      return cacheAbleMap.find(item => item.key == val)["color"];
    },
    invisibleText(val) {
      return invisibleMap.find(item => item.key == val)["text"];
    },
    cacheAbleText(val) {
      return cacheAbleMap.find(item => item.key == val)["text"];
    }
  },
  methods: {
    processMenuList(menuList) {
      return menuList.map(item => {
        if (item.children.length > 0) {
          item.children = this.processMenuList(item.children);
        } else {
          delete item.children;
        }
        return item;
      });
    },
    handlePermissionAdd() {
      this.permissionData.push({
        index: new Date().getTime(),
        action: "",
        describe: "",
        editable: true
      });
    },
    handlePermissionChange(value, action, column) {
      const newData = [...this.permissionData];
      const target = newData.filter(item => action === item.action)[0];
      if (target) {
        target[column] = value;
        this.permissionData = newData;
      }
    },
    removePermission(action) {
      this.permissionData = this.permissionData.filter(
        item => action != item.action
      );
    },
    handleEdit(record) {
      this.visible = true;
      this.editId = record.id;
      this.formFlag = 2;
      if (record.permissions) {
        this.permissionData = JSON.parse(record.permissions).map(item => {
          return {
            index: item.action,
            action: item.action,
            describe: item.describe,
            editable: true
          };
        });
      } else {
        this.permissionData = [];
      }
      this.$nextTick(() => {
        this.form.setFieldsValue(
          pick(
            record,
            "id",
            "path",
            "invisible",
            "name",
            "icon",
            "cacheAble",
            "sort",
            "component",
            "parentId"
          )
        );
      });
    },
    handleAddSub(record) {
      this.visible = true;
      this.formFlag = 3;
      this.permissionData = [];
      this.$nextTick(() => {
        this.form.setFieldsValue({ parentId: record.id });
      });
    },
    handleCreate() {
      this.visible = true;
      this.form.resetFields();
      this.permissionData = [];
      this.formFlag = 1;
    },
    handleDelete(record) {
      let model = this.$confirm({
        title: "提示",
        content: "确定要删除该菜单吗?",
        onOk: () => {
          return deleteMenu({ menuId: record.id }).then(res => {
            if(res.code == 200){
              this.$message.success("删除菜单成功");
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
    cancel() {
      this.form.resetFields();
    },
    handleOk(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          let permissions = this.permissionData.map(item => {
            return {
              action: item.action,
              describe: item.describe
            };
          });
          values.permissions = JSON.stringify(permissions);
          if (this.formFlag == 1 || this.formFlag == 3) {
            addMenu(values).then(res => {
              if(res.code == 200){
                this.$message.success("创建菜单成功");
                this.visible = false;
                this.$refs.list.refresh();
              }else{
                this.$message.error(res.message);
              }
            });
          } else {
            values.id = this.editId;
            editMenu(values).then(res => {
              if(res.code == 200){
                this.$message.success("编辑菜单成功");
                this.visible = false;
                this.$refs.list.refresh();
              }else{
                this.$message.error(res.message);
              }
            });
          }
        }
      });
    }
  }
};
</script>
<style scoped lang="less">
.editable-add-btn {
  margin-bottom: 12px;
}
.edit-modal /deep/ .ant-table-thead > tr > th {
  padding: 6px 12px;
}
.edit-modal /deep/ .ant-table-tbody > tr > td {
  padding: 6px 12px;
}
</style>
