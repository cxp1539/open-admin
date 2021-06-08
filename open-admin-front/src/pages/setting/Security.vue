<template>

  <div>
    <a-list
      itemLayout="horizontal"
      :dataSource="data"
    >
      <a-list-item slot="renderItem" slot-scope="item, index" :key="index">
        <a-list-item-meta>
          <a slot="title">{{ item.title }}</a>
          <span slot="description">
            <span class="security-list-description">{{ item.description }}</span>
            <span v-if="item.value"> : </span>
            <span class="security-list-value">{{ item.value }}</span>
          </span>
        </a-list-item-meta>
        <template v-if="item.actions">
          <a slot="actions" @click="item.actions.callback">{{ item.actions.title }}</a>
        </template>

      </a-list-item>

    </a-list>

    <a-modal title="修改密码" :width="800" @cancel="cancel" v-model="visible" @ok="handleOk">

      <a-form ref="ruleForm" :form="form" :labelCol="labelCol" :wrapperCol="wrapperCol">
        <a-form-item
          label="用户名"
        >
          <a-input
            disabled="disabled"
            :value="currUser.username"
          />
        </a-form-item>

        <a-form-item
          label="密码"
        >
          <a-input
            placeholder="请输入原密码!"
            v-decorator="['sourcePassword', { rules: [{ required: true, message: '请输入原密码!' }] }]"
          />
        </a-form-item>

        <a-form-item
          label="新密码"
        >
          <a-input
            placeholder="请输入新密码!"
            v-decorator="['password', { rules: [{ required: true, validator: checkPassword }] }]"
          />
        </a-form-item>

        <a-form-item
          label="确认新密码"
        >
          <a-input
            placeholder="请输入确认新密码!"
            v-decorator="['confirmPassword', { rules: [{ required: true, validator: checkConfirmPassword }] }]"
          />
        </a-form-item>


      </a-form>
    </a-modal>

  </div>

</template>

<script>
import { setSysUserPassword } from '@/services/system'
import {mapState} from 'vuex'
export default {
  name: 'Security',
  data () {
    let pwdRegex = new RegExp('(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,30}');
    let checkPassword = (rule, value, callback) => {

      if(!value){
        callback(new Error('请输入新密码!'));  
      }

      if (value) {
        if(!pwdRegex.test(value)){
          callback(new Error('设置密码复杂度太低，必须包含大小写，数字，特殊字符，不少于8位'));
        }
      }
       callback();
    };
    let checkConfirmPassword = (rule, value, callback) => {

      if(!value){
        callback(new Error('请输入新密码!'));  
      }

      if (value) {
        if(!pwdRegex.test(value)){
          callback(new Error('设置密码复杂度太低，必须包含大小写，数字，特殊字符，不少于8位'));
        }

        if(value != this.$refs['ruleForm'].form.getFieldValue("password")){
          callback(new Error('两次输入密码不一致！'));
        }

      }
       callback();
    };
    return {
      data: [
        { title: '账户密码', actions: { title: '修改', callback: () => { this.showDialog()} } },
      ],
      visible: false,
      checkPassword: checkPassword,
      checkConfirmPassword: checkConfirmPassword,
      form: this.$form.createForm(this),
      labelCol: {
        xs: { span: 24 },
        sm: { span: 5 }
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 16 }
      },
    }
  },
  computed: {
    ...mapState("account", { currUser: "user" }),
  },
  methods: {
    showDialog(){
      this.visible = true
    },
    cancel(){
      this.$refs['ruleForm'].form.resetFields();
    },
    handleOk(e) {
      e.preventDefault();
      this.$refs['ruleForm'].form.validateFields((err, values) => {
        if (!err) {
          setSysUserPassword(values).then(res => {
            if(res.code == 200){
              this.$message.success('修改密码成功!');
              this.visible = false;
            }else{
              this.$message.error(res.message);
            }
          });
        }
      });
    }

  }
}
</script>

<style scoped>

</style>
