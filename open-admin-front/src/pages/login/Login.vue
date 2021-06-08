<template>
  <common-layout>
    <div class="top">
      <div class="header">
        <img alt="logo" class="logo" src="@/assets/img/logo.png" />
        <span class="title">{{ systemName }}</span>
      </div>
      <div class="desc">Open Admin 致力于为用户生成定制的前后端脚手架框架</div>
    </div>
    <div class="login">
      <a-form @submit="onSubmit" :form="form">
        <a-alert
          type="error"
          :closable="true"
          v-show="error"
          :message="error"
          showIcon
          style="margin-bottom: 24px;"
        />
        <a-form-item>
          <a-input
            autocomplete="autocomplete"
            size="large"
            placeholder="请输入账户名"
            v-decorator="[
              'username',
              {
                rules: [
                  { required: true, message: '请输入账户名', whitespace: true },
                ],
              },
            ]"
          >
            <a-icon slot="prefix" type="user" />
          </a-input>
        </a-form-item>
        <a-form-item>
          <a-input
            size="large"
            placeholder="请输入密码"
            autocomplete="autocomplete"
            type="password"
            v-decorator="[
              'password',
              {
                rules: [
                  { required: true, message: '请输入密码', whitespace: true },
                ],
              },
            ]"
          >
            <a-icon slot="prefix" type="lock" />
          </a-input>
        </a-form-item>

        <a-form-item>
          <a-input
            style="width:230px;margin-right:20px;cursor:pointer;"
            size="large"
            autocomplete="false"
            placeholder="请输入验证码"
            v-decorator="['code', { rules: [{ required: true, message: '请输入验证码' }], validateTrigger: 'blur' }]"
          />
          <img style="display: inline-block;" :src="verCode" class="verCode" @click="newVerCode" />
        </a-form-item>

        <div>
          <a-checkbox :checked="true">自动登录</a-checkbox>
        </div>
        <a-form-item>
          <a-button
            :loading="logging"
            style="width: 100%;margin-top: 24px"
            size="large"
            htmlType="submit"
            type="primary"
          >登录</a-button>
        </a-form-item>

        <!-- <div>
          其他登录方式
          <a-icon class="icon" type="alipay-circle" />
          <a-icon class="icon" type="taobao-circle" />
        </div>-->
      </a-form>
    </div>
  </common-layout>
</template>

<script>
import CommonLayout from "@/layouts/CommonLayout";
import { login } from "@/services/system";
import { setAuthorization } from "@/utils/request";
import { mapMutations } from "vuex";
import { mapState } from "vuex";
import { againBootstrap } from "@/utils/util";
export default {
  name: "Login",
  components: { CommonLayout },
  data() {
    return {
      logging: false,
      error: "",
      form: this.$form.createForm(this),
      verCode: ""
    };
  },
  computed: {
    systemName() {
      return this.$store.state.setting.systemName;
    }
  },
  created() {
    this.newVerCode();
  },
  methods: {
    ...mapMutations("account", ["setUser", "setPermissions", "setRole", "setMenus"]),
    newVerCode() {
      this.verCode =
        process.env.VUE_APP_API_BASE_URL +
        "/backed/captcha" +
        "?m=" +
        Math.random();
    },
    onSubmit(e) {
      e.preventDefault();
      this.form.validateFields(err => {
        if (!err) {
          this.logging = true;
          const username = this.form.getFieldValue("username");
          const password = this.form.getFieldValue("password");
          const code = this.form.getFieldValue("code");
          login({ username, password, code }).then(this.afterLogin);
        }
      });
    },
    translatePermission(permissions){
      return permissions.map(item => {
        return {
          operation: JSON.parse(item.operation),
          component: item.component
        };
      });
    },
    afterLogin(loginRes) {
      this.logging = false;
      if (loginRes.code == 200) {
        let { user, permissions, menus } = loginRes.data;
        permissions = this.translatePermission(permissions);
        this.setUser(user);
        this.setPermissions(permissions);
        this.setMenus(menus);
        this.setRole(user.role);
        setAuthorization({
          token: loginRes.data.token,
          expireAt: new Date(loginRes.data.tokenExpireAt)
        });
        againBootstrap(true);
        // 获取路由配置
        this.$router.push("/workplace");
      } else {
        this.error = loginRes.message;
      }
    }
  }
};
</script>

<style lang="less" scoped>
.common-layout {
  .top {
    text-align: center;
    .header {
      height: 44px;
      line-height: 44px;
      a {
        text-decoration: none;
      }
      .logo {
        height: 44px;
        vertical-align: top;
        margin-right: 16px;
      }
      .title {
        font-size: 33px;
        color: @title-color;
        font-family: "Myriad Pro", "Helvetica Neue", Arial, Helvetica,
          sans-serif;
        font-weight: 600;
        position: relative;
        top: 2px;
      }
    }
    .desc {
      font-size: 14px;
      color: @text-color-second;
      margin-top: 12px;
      margin-bottom: 40px;
    }
  }
  .login {
    width: 368px;
    margin: 0 auto;
    @media screen and (max-width: 576px) {
      width: 95%;
    }
    @media screen and (max-width: 320px) {
      .captcha-button {
        font-size: 14px;
      }
    }
    .icon {
      font-size: 24px;
      color: @text-color-second;
      margin-left: 16px;
      vertical-align: middle;
      cursor: pointer;
      transition: color 0.3s;

      &:hover {
        color: @primary-color;
      }
    }
  }
}
</style>
