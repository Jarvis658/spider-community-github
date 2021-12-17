const children1 = [//children1是home的子路由集合
    //访问路由“/home”,自动重定向到"/recommend",即设定首页
    {
        path: '/home',
        redirect: '/post_audit'
    },

    {
        path: '/post_audit',
        name: "post_audit",
        component: () => import('@/views/postAudit.vue')
    },

    {
        path: '/label_manage',
        name: "label_manage",
        component: () => import('@/views/labelManage.vue')
    },
    {
        path: '/info',
        name: "info",
        component: () => import('@/views/info.vue')
    },
    {
        path: '/user_manage',
        name: "user_manage",
        component: () => import('@/views/userManage.vue')
    },
    {
        path: '/post',
        name: "post",
        component: () => import('@/views/post.vue')
    },
];

const routes = [

    //访问路由“/”,自动重定向到"/login"
    {
        path: '/',
        redirect: '/login'
    },

    {
        path: '/404',
        name: "NotFound",
        component: () => import('@/views/404.vue')
    },

    {
        path: '/login',
        name: 'Login',
        component: () => import('@/views/login.vue')
    },
    {
        path: '/home',
        name: 'Home',
        component: () => import('@/views/Home.vue'),
        children:children1
    },
    
];

export const existsRoute = (path) => {
    for (let i = 0; i < routes.length; i++) {
        const r = routes[i];
        if (r.path == path) {
            return true;
        }
        if (r.children && r.children.length) {
            for (let k = 0; k < r.children.length; k++) {
                const sr = r.children[k];
                if (sr.path == path) {
                    return true;
                }
            }
        }
    }
    return false;
};

export default routes;