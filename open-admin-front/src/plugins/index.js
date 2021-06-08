import VueI18nPlugin from './i18n-extend'
import TabsPagePlugin from './tabs-page-plugin'
import AuthorityPlugin from './authority-plugin'

const Plugins = {
  install: function (Vue) {
    Vue.use(VueI18nPlugin)
    Vue.use(TabsPagePlugin)
    Vue.use(AuthorityPlugin)
  }
}
export default Plugins
