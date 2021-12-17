//该文件用于拼接和初始化组件

import { createApp } from 'vue'

import 'font-awesome/css/font-awesome.min.css'

import constants from '@/common/constants'

import router from '@/common/router'

//导入已封装好的服务端访问对象
import request from "@/common/request"

//导入防抖函数
import debounce from "@/common/debounce"

//导入快捷提示对象
import tip from "@/common/tip"

//数据字典初始化
import "@/common/ddo"

//加载提示组件初始化
import "@/common/sureLoading/loading"
//导入加载提示
import loading from "@/common/sureLoading"

//
import Antd from 'ant-design-vue';
import App from './App.vue'
import 'ant-design-vue/dist/antd.css';

createApp(App).use(constants).use(router).use(request).use(debounce).use(tip).use(loading).use(Antd).mount('#app');



