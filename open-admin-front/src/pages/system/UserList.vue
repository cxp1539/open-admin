<template>
  <a-card :bordered="false" :style="{ minHeight: '560px' }">
    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="handleCreate"
        >新建用户</a-button
      >
    </div>

    <s-table
      ref="list"
      rowKey="id"
      size="default"
      :columns="columns"
      :data="loadData"
    >
      <span slot="action" slot-scope="text, record">
        <template>
          <a @click="handleEdit(record)"> <a-icon type="edit" />编辑 </a>
        </template>
      </span>

      <span slot="username" slot-scope="imageUrl, record">
        <img
          style="width: 42px; height: 42px; border-radius: 50%"
          :src="record.avatar"
        />
        {{ record.username }}
      </span>

      <span slot="roleId" slot-scope="roleId">
        <a-tag>{{ roleId | roleFilter }}</a-tag>
      </span>

      <span slot="status" slot-scope="status">
        <a-badge
          :color="status | statusTypeFilter"
          :text="status | statusFilter"
        />
      </span>
    </s-table>

    <a-modal
      :title="formFlag == 1 ? '创建用户' : '修改用户'"
      style="top: 20px"
      :width="800"
      @cancel="cancel"
      v-model="visible"
      @ok="handleOk"
    >
      <a-form
        ref="ruleForm"
        :form="form"
        :labelCol="labelCol"
        :wrapperCol="wrapperCol"
      >
        <a-form-item label="用户名">
          <a-input
            placeholder="请输入用户名!"
            v-decorator="[
              'username',
              { rules: [{ required: true, message: '请输入用户名!' }] },
            ]"
          />
        </a-form-item>

        <a-form-item label="密码">
          <a-input
            placeholder="请输入密码,(编辑用户不填，则不更新密码)!"
            v-decorator="[
              'password',
              { rules: [{ validator: checkPassword }] },
            ]"
          />
        </a-form-item>

        <a-form-item label="姓名">
          <a-input
            placeholder="请输入姓名!"
            v-decorator="[
              'name',
              { rules: [{ required: true, message: '请输入姓名!' }] },
            ]"
          />
        </a-form-item>

        <a-form-item label="用户角色">
          <a-select
            v-decorator="[
              'roleId',
              { rules: [{ required: true, message: '请选择用户角色!' }] },
            ]"
          >
            <a-select-option
              :key="item.id"
              v-for="item in rolesMap"
              :value="item.id"
              >{{ item.name }}</a-select-option
            >
          </a-select>
        </a-form-item>

        <a-form-item label="用户状态">
          <a-select
            v-decorator="[
              'status',
              { rules: [{ required: true, message: '请选择用户状态!' }] },
            ]"
          >
            <a-select-option
              :key="item.id"
              v-for="item in statusMap"
              :value="item.id"
              >{{ item.name }}</a-select-option
            >
          </a-select>
        </a-form-item>
      </a-form>
    </a-modal>
  </a-card>
</template>

<script>
import STable from "@/components/table";
import {
  getRoles,
  getSysUserList,
  updateSysUser,
  createSysUser,
} from "@/services/system";
import { statusMap } from "@/enums/user";
import pick from "lodash.pick";
let that;
export default {
  name: "SysUserList",
  components: {
    STable,
  },
  data() {
    let pwdRegex = new RegExp(
      "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,30}"
    );
    let checkPassword = (rule, value, callback) => {
      if (value) {
        if (!pwdRegex.test(value)) {
          callback(
            new Error(
              "设置密码复杂度太低，必须包含大小写，数字，特殊字符，不少于8位"
            )
          );
        }
      }
      callback();
    };
    return {
      layout: {
        labelCol: { span: 4 },
        wrapperCol: { span: 14 },
      },
      visible: false,
      rolesMap: [],
      form: this.$form.createForm(this),
      formFlag: 1,
      editId: 0,
      checkPassword: checkPassword,
      statusMap: statusMap,
      labelCol: {
        xs: { span: 24 },
        sm: { span: 5 },
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 16 },
      },
      mdl: {},
      // 表头
      columns: [
        {
          title: "Id",
          dataIndex: "id",
          key: "id",
        },
        {
          title: "用户名",
          dataIndex: "username",
          key: "username",
          scopedSlots: { customRender: "username" },
        },
        {
          title: "姓名",
          dataIndex: "name",
          key: "name",
        },
        {
          title: "角色",
          dataIndex: "roleId",
          scopedSlots: { customRender: "roleId" },
          key: "roleId",
        },
        {
          title: "状态",
          dataIndex: "status",
          scopedSlots: { customRender: "status" },
          key: "status",
        },
        {
          title: "创建时间",
          dataIndex: "createdTime",
          key: "createdTime",
        },
        {
          title: "操作",
          width: "150px",
          dataIndex: "action",
          scopedSlots: { customRender: "action" },
          key: "action",
        },
      ],
      loadData: (parameter) => {
        return getSysUserList(parameter).then((res) => {
          return res.data;
        });
      },
    };
  },
  created() {
    that = this;
    getRoles().then((res) => {
      this.rolesMap = res.data.map((item) => {
        return { id: item.id, name: item.name };
      });
    });
  },
  filters: {
    roleFilter(roleId) {
      let res = that.rolesMap.find((item) => {
        return item.id == roleId;
      });
      if (res) {
        return res.name;
      }
    },
    statusFilter(status) {
      let res = that.statusMap.find((item) => {
        return item.id == status;
      });
      if (res) {
        return res.name;
      }
    },
    statusTypeFilter(type) {
      let res = that.statusMap.find((item) => {
        return item.id == type;
      });
      if (res) {
        return res.color;
      }
    },
  },
  methods: {
    handleEdit(record) {
      this.visible = true;
      this.formFlag = 2;
      this.editId = record.id;
      this.$nextTick(() => {
        this.$refs["ruleForm"].form.setFieldsValue(
          pick(record, "name", "roleId", "status", "username")
        );
      });
    },
    handleCreate() {
      this.visible = true;
      this.$refs["ruleForm"].form.resetFields();
      this.formFlag = 1;
    },
    cancel() {
      this.$refs["ruleForm"].form.resetFields();
    },
    handleOk(e) {
      e.preventDefault();
      this.$refs["ruleForm"].form.validateFields((err, values) => {
        if (!err) {
          if (this.formFlag == 1) {
            createSysUser(values).then((res) => {
              if (res.code == 200) {
                this.$message.success("创建用户成功");
                this.visible = false;
                this.$refs.list.refresh();
              } else {
                this.$message.error(res.message);
              }
            });
          } else {
            values.id = this.editId;
            updateSysUser(values).then((res) => {
              if (res.code == 200) {
                this.$message.success("修改用户信息成功");
                this.visible = false;
                this.$refs.list.refresh();
              } else {
                this.$message.error(res.message);
              }
            });
          }
        }
      });
    },
  },
};
</script>
