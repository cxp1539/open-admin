import Vue from "vue";
import Router from "vue-router";
import {
  formatRoutes,
  getRouters
} from "@/utils/routerUtil";
import {
  commonRoutes
} from "./config";

const originalPush = Router.prototype.push;
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch((err) => err);
};

Vue.use(Router);

// 不需要登录拦截的路由配置
const loginIgnore = {
  names: ["404"], //根据路由名称匹配
  paths: ["/login", "/403"], //根据路由fullPath匹配
  /**
   * 判断路由是否包含在该配置中
   * @param route vue-router 的 route 对象
   * @returns {boolean}
   */
  includes(route) {
    return (
      (this.names.includes(route.name) && route.path != "/") ||
      this.paths.includes(route.path)
    );
  },
};


/**
 * 初始化路由实例
 * @returns {VueRouter}
 */
function initRouter(isSync, isAuth) {
  const options = {
    routes: isSync ? require('./sync.config').default.routes : isAuth ? commonRoutes.concat(getRouters()) : commonRoutes,
  };
  formatRoutes(options.routes);
  return new Router(options);
}
export {
  loginIgnore,
  initRouter
};