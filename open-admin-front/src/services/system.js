import { axios, removeAuthorization } from "@/utils/request";

export async function login(data) {
  return axios({
    url: "/backed/system/login",
    method: "post",
    data,
  });
}

export function addMenu(data) {
  return axios({
    url: "/backed/system/add-menu",
    method: "post",
    data,
  });
}

export function editMenu(data) {
  return axios({
    url: "/backed/system/edit-menu",
    method: "post",
    data,
  });
}

export function deleteMenu(params) {
  return axios({
    url: "/backed/system/delete-menu",
    method: "post",
    params,
  });
}

export function setSysUserPassword(data) {
  return axios({
    url: "/backed/system/set-sysuser-password",
    method: "post",
    data,
  });
}

export function setSysUserInfo(data) {
  return axios({
    url: "/backed/system/set-sysuser-info",
    method: "post",
    data,
  });
}

export function updateSysUser(data) {
  return axios({
    url: "/backed/system/update-sysuser",
    method: "post",
    data,
  });
}

export function createSysUser(data) {
  return axios({
    url: "/backed/system/create-sysuser",
    method: "post",
    data,
  });
}

export function editRole(data) {
  return axios({
    url: "/backed/system/editRole",
    method: "post",
    data,
  });
}

export function deleteRole(params) {
  return axios({
    url: "/backed/system/delete-role",
    method: "post",
    params,
  });
}

export function saveRoleMenus(data) {
  return axios({
    url: "/backed/system/save-role-menus",
    method: "post",
    data,
  });
}

export function saveRoleMenuPermissons(data) {
  return axios({
    url: "/backed/system/save-role-menu-permissons",
    method: "post",
    data,
  });
}

export function getMenuAndMenuPermissions(params) {
  return axios({
    url: "/backed/system/menu-and-menu-permissions",
    method: "get",
    params,
  });
}

export async function getRoles(params) {
  return axios({
    url: "/backed/system/roles",
    method: "get",
    params,
  });
}

export function getMenuPermissions(params) {
  return axios({
    url: "/backed/system/menu-permissions",
    method: "get",
    params,
  });
}

export function getMenus(params) {
  return axios({
    url: "/backed/system/menus",
    method: "get",
    params,
  });
}

export async function getLogList(params) {
  return axios({
    url: "/backed/system/log-list",
    method: "get",
    params,
  });
}

export function logout() {
  return axios({
    url: "/backed/system/logout",
    method: "post",
  }).then(() => {
    sessionStorage.removeItem(process.env.VUE_APP_TBAS_KEY);
    localStorage.removeItem(process.env.VUE_APP_ROUTE_KEY);
    localStorage.removeItem(process.env.VUE_APP_PERMISSIONS_KEY);
    localStorage.removeItem(process.env.VUE_APP_ROLE_KEY);
    localStorage.removeItem(process.env.VUE_APP_MENUS_KEY);
    removeAuthorization();
  });
}

export function getSysUserList(params) {
  return axios({
    url: "/backed/system/sysuser-list",
    method: "get",
    params,
  });
}
