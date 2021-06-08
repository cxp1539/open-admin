import TabsView from "@/layouts/tabs/TabsView";
import BlankView from "@/layouts/BlankView";
import PageView from "@/layouts/PageView";

// 通用路由配置
export const commonRoutes = [
  {
    path: "/login",
    name: "登录页",
    component: () => import("@/pages/login"),
  },
  {
    path: "*",
    name: "404",
    component: () => import("@/pages/exception/404"),
  },
  {
    path: "/403",
    name: "403",
    component: () => import("@/pages/exception/403"),
  },
];

export const defaultSettingRoutes = [
  {
    path: 'setting',
    name: '个人设置',
    meta: {
      invisible: true,
    },
    component: () => import("@/pages/setting/Index"),
    redirect: "/setting/base",
    children: [
      {
        path: 'base',
        name: '基本设置',
        component: () => import("@/pages/setting/BaseSetting"),
      },
      {
        path: 'security',
        name: '安全设置',
        component: () => import("@/pages/setting/Security"),
      },
      {
        path: 'custom',
        name: '个人性化',
        component: () => import("@/pages/setting/Custom"),
      },
    ]
  }
];

// 前端路由表
export const constantRouterComponents = {
  TabsView: TabsView,
  PageView: PageView,
  BlankView: BlankView,
  Login: () => import("@/pages/login"),
  "403": () => import(/* webpackChunkName: "error" */ "@/pages/exception/403"),
  "404": () => import(/* webpackChunkName: "error" */ "@/pages/exception/404"),
  Workplace: () => import("@/pages/workplace"),
  UserList: () => import("@/pages/user/UserList"),
  SystemUserList: () => import("@/pages/system/UserList"),
  MenuList: () => import("@/pages/system/MenuList"),
  RoleList: () => import("@/pages/system/RoleList"),
  LogList: () => import("@/pages/system/LogList"),
  FormBasic: () => import("@/pages/form/basic"),
  FormStep: () => import("@/pages/form/step"),
  FormAdvance: () => import("@/pages/form/advance"),
  QueryList: () => import("@/pages/list/QueryList"),
  StandardList: () => import("@/pages/list/StandardList"),
  CardList: () => import("@/pages/list/CardList"),
  AdvancedDetail: () => import("@/pages/detail/AdvancedDetail"),
  Success: () => import("@/pages/result/Success"),
  Error: () => import("@/pages/result/Error"),
  SeniorTable: () => import("@/pages/components/table"),
  AuthForm: () => import("@/pages/form/basic"),
};