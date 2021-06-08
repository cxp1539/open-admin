export default {
  namespaced: true,
  state: {
    user: undefined,
    permissions: null,
    menus: null,
    role: null,
  },
  getters: {
    user: (state) => {
      if (!state.user) {
        try {
          const user = localStorage.getItem(process.env.VUE_APP_USER_KEY);
          state.user = JSON.parse(user);
        } catch (e) {
          console.error(e);
        }
      }
      return state.user;
    },
    menus: (state) => {
      if (!state.menus) {
        try {
          const menus = localStorage.getItem(
            process.env.VUE_APP_MENUS_KEY
          );
          state.menus = JSON.parse(menus);
          state.menus = state.menus ? state.menus : [];
        } catch (e) {
          console.error(e.message);
        }
      }
      return state.permissions;
    },
    permissions: (state) => {
      if (!state.permissions) {
        try {
          const permissions = localStorage.getItem(
            process.env.VUE_APP_PERMISSIONS_KEY
          );
          state.permissions = JSON.parse(permissions);
          state.permissions = state.permissions ? state.permissions : [];
        } catch (e) {
          console.error(e.message);
        }
      }
      return state.permissions;
    },
    role: (state) => {
      if (!state.role) {
        try {
          const role = localStorage.getItem(process.env.VUE_APP_ROLE_KEY);
          state.role = role;
        } catch (e) {
          console.error(e.message);
        }
      }
      return state.role;
    },
  },
  mutations: {
    setUser(state, user) {
      state.user = user;
      localStorage.setItem(process.env.VUE_APP_USER_KEY, JSON.stringify(user));
    },
    setPermissions(state, permissions) {
      state.permissions = permissions;
      localStorage.setItem(
        process.env.VUE_APP_PERMISSIONS_KEY,
        JSON.stringify(permissions)
      );
    },
    setMenus(state, menus) {
      state.menus = menus;
      localStorage.setItem(
        process.env.VUE_APP_MENUS_KEY,
        JSON.stringify(menus)
      );
    },
    setRole(state, role) {
      state.role = role;
      localStorage.setItem(process.env.VUE_APP_ROLE_KEY, role);
    },
  },
};
