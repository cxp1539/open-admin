import { mergeI18nFromRoutes } from "@/utils/i18n";
import { constantRouterComponents, defaultSettingRoutes } from "@/router/config";

//应用配置
let appOptions = {
  router: undefined,
  i18n: undefined,
  store: undefined,
};

/**
 * 设置应用配置
 * @param options
 */
function setAppOptions(options) {
  const { router, store, i18n } = options;
  appOptions.router = router;
  appOptions.store = store;
  appOptions.i18n = i18n;
}

function translateRouter(routes, parent) {
  return routes.map((item) => {
    const { invisible, icon, cacheAble } = item;
    let path = "";
    if (!item.path.startsWith("/") && item.path !== "*") {
      if (parent && parent.path && parent.path != "/") {
        path = `${parent.path}/${item.path}`;
      } else {
        path = `/${item.path}`;
      }
    }
    const currentRouter = {
      path: path,
      name: item.name,
      component: constantRouterComponents[item.component],
      meta: { page: {} },
    };

    item.component = constantRouterComponents[item.component];

    if (icon) {
      currentRouter.meta.icon = icon;
    }
    if (cacheAble == 1) {
      currentRouter.meta.page.cacheAble = true;
    }
    if (invisible == 1) {
      currentRouter.meta.invisible = true;
    }
    // 是否有子菜单，并递归处理
    if (item.children && item.children.length > 0) {
      if (item.redirect) {
        currentRouter.redirect = item.path == "/" ? `/${item.redirect}` : `${item.path}/${item.redirect}`;
      }
      currentRouter.children = translateRouter(item.children, item);
    } else {
      delete item.children;
    }
    return currentRouter;
  });
}

function loadRoutes() {
  // 应用配置
  const { router, store, i18n } = appOptions;
  // 提取路由国际化数据
  mergeI18nFromRoutes(i18n, router.options.routes);
  // 初始化Admin后台菜单数据
  const rootRoute = router.options.routes.find((item) => item.path === "/");
  const menuRoutes = rootRoute && rootRoute.children;
  if (menuRoutes) {
    store.commit("setting/setMenuData", menuRoutes);
  }
}

/**
 * 格式化路由
 * @param routes 路由配置
 */
function formatRoutes(routes) {
  routes.forEach((route) => {
    const { path } = route;
    if (!path.startsWith("/") && path !== "*") {
      route.path = "/" + path;
    }
  });
  formatAuthority(routes);
}

/**
 * 格式化路由的权限配置
 * @param routes 路由
 * @param pAuthorities 父级路由权限配置集合
 */
function formatAuthority(routes, pAuthorities = []) {
  routes.forEach((route) => {
    const meta = route.meta;
    const defaultAuthority = pAuthorities[pAuthorities.length - 1] || {
      role: "*",
    };
    if (meta) {
      let authority = {};
      if (!meta.authority) {
        authority = defaultAuthority;
      } else if (typeof meta.authority === "string") {
        authority.role = meta.authority;
      } else if (typeof meta.authority === "object") {
        authority = meta.authority;
        const { role } = authority;
        if (typeof role === "string") {
          authority.role = [role];
        }
        if (!authority.role && !authority.role) {
          authority = defaultAuthority;
        }
      }
      meta.authority = authority;
    } else {
      const authority = defaultAuthority;
      route.meta = { authority };
    }
    route.meta.pAuthorities = pAuthorities;
    if (route.children) {
      formatAuthority(route.children, [...pAuthorities, route.meta.authority]);
    }
  });
}

/**
 * 从路由 path 解析 i18n key
 * @param path
 * @returns {*}
 */
function getI18nKey(path) {
  const keys = path
    .split("/")
    .filter((item) => !item.startsWith(":") && item != "");
  keys.push("name");
  return keys.join(".");
}

/**
 * 加载导航守卫
 * @param guards
 * @param options
 */
function loadGuards(guards, options) {
  const { beforeEach, afterEach } = guards;
  const { router } = options;
  beforeEach.forEach((guard) => {
    if (guard && typeof guard === "function") {
      router.beforeEach((to, from, next) => guard(to, from, next, options));
    }
  });
  afterEach.forEach((guard) => {
    if (guard && typeof guard === "function") {
      router.afterEach((to, from) => guard(to, from, options));
    }
  });
}

function getRouters() {
  let menus = localStorage.getItem(process.env.VUE_APP_MENUS_KEY);
  menus = JSON.parse(menus);
  let routes = [
    {
      path: "/",
      component: "TabsView",
      redirect: menus[0]["path"],
      children: JSON.parse(JSON.stringify(menus)),
    },
  ];
  routes = translateRouter(routes);
  routes[0].children = routes[0].children.concat(defaultSettingRoutes)
  return routes;
}

export {
  loadRoutes,
  getRouters,
  formatAuthority,
  getI18nKey,
  loadGuards,
  formatRoutes,
  setAppOptions,
};
