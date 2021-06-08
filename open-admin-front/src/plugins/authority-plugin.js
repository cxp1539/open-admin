/**
 * 判断是否已为方法注入权限认证
 * @param method
 * @returns {boolean}
 */
const hasInjected = (method) =>
  method.toString().indexOf("//--auth-inject") !== -1;

const auth = function(check, component, permissions) {
  return checkFromPermission(check, component, permissions);
};

/**
 * 检查权限是否有操作权限
 * @param check 需要检查的操作权限
 * @param permissions 权限
 * @returns {boolean}
 */
const checkFromPermission = function(check, component, permissions) {
  let index = permissions && permissions.findIndex((item) => item.component == component);
  if(index == -1){
    return false;
  }
  let operation = permissions[index].operation;
  return operation.findIndex((item) => item.action == check) != -1;

};

const checkInject = function(el, binding, vnode, component) {
  const check = binding.value;
  const instance = vnode.context;
  const $auth = instance.$auth;
  if (!$auth || !$auth(check, component)) {
    addDisabled(el);
  } else {
    removeDisabled(el);
  }
};

const addDisabled = function(el) {
  if (el.tagName === "BUTTON") {
    el.disabled = true;
  } else {
    el.classList.add("disabled");
  }
  el.setAttribute("title", "无此权限");
};

const removeDisabled = function(el) {
  el.disabled = false;
  el.classList.remove("disabled");
  el.removeAttribute("title");
};

const getComponentName = function(vnode){
  let tag = vnode.context.$vnode.tag;
  var index = tag.lastIndexOf("-");
  return tag.substr(index+1);
}

const AuthorityPlugin = {
  install(Vue) {
    Vue.directive("auth", {
      bind(el, binding, vnode) {
        const component = getComponentName(vnode);
        setTimeout(() => checkInject(el, binding, vnode, component), 10);
      },
      componentUpdated(el, binding, vnode) {
        const component = getComponentName(vnode);
        setTimeout(() => checkInject(el, binding, vnode, component), 10);
      },
      unbind(el) {
        removeDisabled(el);
      },
    });
    Vue.mixin({
      beforeCreate() {
        if (this.$options.authorize) {
          const authorize = this.$options.authorize;
          const component = this.$options.name;
          Object.keys(authorize).forEach((key) => {
            if (this.$options.methods[key]) {
              const method = this.$options.methods[key];
              if (!hasInjected(method)) {
                let check = authorize[key];
                this.$options.methods[key] = function() {
                  //--auth-inject
                  if (this.$auth(check, component)) {
                    return method.apply(this, arguments);
                  } else {
                    this.$message.error(`对不起，您没有操作权限：${check}`);
                    return 0;
                  }
                };
              }
            }
          });
        }
      },
      methods: {
        $auth(check, component) {
          const permissions = this.$store.getters["account/permissions"];
          return auth.apply(this, [check, component, permissions]);
        },
      },
    });
  },
};

export default AuthorityPlugin;
