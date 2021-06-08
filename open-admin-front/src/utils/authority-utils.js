/**
 * 判断是否有路由需要的角色
 * @param authority 路由权限配置
 * @param role 用户角色
 */
function hasRole(authority, role) {
  let required = undefined;
  if (typeof authority === "object") {
    required = authority.role;
  }

  return required[0] == "*" || authority === "*" || hasAnyRole(required, role);
}

/**
 * 判断是否有需要的任意一个角色
 * @param required {String | Array[String]} 需要的角色，可以是单个角色或者一个角色数组
 * @param role 拥有的角色
 * @returns {boolean}
 */
function hasAnyRole(required, role) {
  if (!required) {
    return false;
  } else if (Array.isArray(required)) {
    let requiredArr = [];
    required.forEach((item) => {
      requiredArr = requiredArr.concat(item.split(","));
    });
    return requiredArr.includes(role);
  } else {
    if(required == '*'){
      return true;
    }else{
      required = required.split(",");
      return required.includes(role);
    }

  }
}

/**
 * 路由权限校验
 * @param route 路由
 * @param role 用户角色
 * @returns {boolean}
 */
function hasAuthority(route, role) {
  const authorities = [...route.meta.pAuthorities, route.meta.authority];
  for (let authority of authorities) {
    if (!hasRole(authority, role)) {
      return false;
    }
  }
  return true;
}

/**
 * 根据权限配置过滤菜单数据
 * @param menuData
 * @param role
 */
function filterMenu(menuData, role) {
  return menuData.filter((menu) => {
    if (menu.meta && menu.meta.invisible === undefined) {
      if (!hasAuthority(menu, role)) {
        return false;
      }
    }
    if (menu.children && menu.children.length > 0) {
      menu.children = filterMenu(menu.children, role);
    }
    return true;
  });
}

export { filterMenu, hasAuthority };
