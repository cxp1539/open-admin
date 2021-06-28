import TabsView from '@/layouts/tabs/TabsView'
import BlankView from '@/layouts/BlankView'
import PageView from '@/layouts/PageView'

// 路由配置
const options = {
    routes: [{
            path: '/login',
            name: '登录页',
            component: () => import('@/pages/login')
        },
        {
            path: '*',
            name: '404',
            component: () => import('@/pages/exception/404'),
        },
        {
            path: '/403',
            name: '403',
            component: () => import('@/pages/exception/403'),
        },
        {
            path: '/',
            name: '首页',
            component: TabsView,
            redirect: '/workplace',
            children: [{
                    path: 'workplace',
                    name: '工作台',
                    meta: {
                        icon: 'dashboard'
                    },
                    component: () => import('@/pages/workplace/WorkPlace'),
                },
                {
                    path: 'form',
                    name: '表单页',
                    meta: {
                        icon: 'form',
                        page: {
                            cacheAble: false
                        }
                    },
                    component: PageView,
                    children: [{
                            path: 'basic',
                            name: '基础表单',
                            component: () => import('@/pages/form/basic'),
                        },
                        {
                            path: 'step',
                            name: '分步表单',
                            component: () => import('@/pages/form/step'),
                        },
                        {
                            path: 'advance',
                            name: '高级表单',
                            component: () => import('@/pages/form/advance'),
                        }
                    ]
                },
                {
                    path: 'list',
                    name: '列表页',
                    meta: {
                        icon: 'table'
                    },
                    component: PageView,
                    children: [{
                            path: 'query',
                            name: '查询表格',
                            meta: {
                                authority: 'queryForm',
                            },
                            component: () => import('@/pages/list/QueryList'),
                        },
                        {
                            path: 'primary',
                            name: '标准列表',
                            component: () => import('@/pages/list/StandardList'),
                        },
                        {
                            path: 'card',
                            name: '卡片列表',
                            component: () => import('@/pages/list/CardList'),
                        }
                    ]
                },
                {
                    path: 'details',
                    name: '详情页',
                    meta: {
                        icon: 'profile'
                    },
                    component: BlankView,
                    children: [{
                        path: 'advance',
                        name: '高级详情页',
                        component: () => import('@/pages/detail/AdvancedDetail')
                    }]
                },
                {
                    path: 'result',
                    name: '结果页',
                    meta: {
                        icon: 'check-circle-o',
                    },
                    component: PageView,
                    children: [{
                            path: 'success',
                            name: '成功',
                            component: () => import('@/pages/result/Success')
                        },
                        {
                            path: 'error',
                            name: '失败',
                            component: () => import('@/pages/result/Error')
                        }
                    ]
                },
                {
                    path: 'exception',
                    name: '异常页',
                    meta: {
                        icon: 'warning',
                    },
                    component: BlankView,
                    children: [{
                            path: '404',
                            name: 'Exp404',
                            component: () => import('@/pages/exception/404')
                        },
                        {
                            path: '403',
                            name: 'Exp403',
                            component: () => import('@/pages/exception/403')
                        }
                    ]
                },
                {
                    path: 'components',
                    name: '内置组件',
                    meta: {
                        icon: 'appstore-o'
                    },
                    component: PageView,
                    children: [{
                        path: 'table',
                        name: '高级表格',
                        component: () => import('@/pages/components/table')
                    }]
                },
                {
                    name: '验权表单',
                    path: 'auth/form',
                    meta: {
                        icon: 'file-excel',
                        authority: {
                            permission: 'form'
                        }
                    },
                    component: () => import('@/pages/form/basic')
                }
            ]
        },
    ]
}

export default options