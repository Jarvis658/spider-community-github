import axios from 'axios'
import qs from 'qs'
import url from './url'
import { getLocalToken } from './token';

axios.defaults.headers['Content-Type'] = 'application/json'; // 设置默认的请求头的Content-Type


/**
 * @description 封装的get请求的方法
 * @param {*} url 请求的地址
 * @param {*} data  请求的数据
 * @returns 数据请求的promise对象
 */
 function get(url_, data) {
	return axios.get(url.baseUrl + url_, {
		params: data
	})
}

/**
 * @description 封装post请求的方法
 * @param {*} url 请求的地址
 * @param {*} data 请求的数据
 * @returns 数据请求的promise对象
 */
 function post(url_, data) {
	return axios.post(url.baseUrl + url_, data)
}

// 请求拦截器
axios.interceptors.request.use(config => {
	console.log(getLocalToken())
    config.headers.token = getLocalToken()
    return config
})

// 响应拦截器
axios.interceptors.response.use(response => response.data)


export default {
    ...url,
    post,
    get
}




