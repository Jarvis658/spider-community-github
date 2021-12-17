import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'
const path = require('path');

export default ({ command, mode }) => {
 
  const env = loadEnv(mode, process.cwd());//获取环境变量（在.env文件中配置的），

  return defineConfig({

    plugins: [vue()],

    base: env.VITE_BASE_URL, //项目的基础路径由环境变量VITE_BASE_URL指定

    //使用“@”表示项目的src目录
    resolve: {
      alias: { '@': path.resolve(__dirname, './src') } 
    },


    //vite开发服务器设置
    server: {
      host: 'localhost', //主机名
      port: 8888, //端口
      open: true, //启动项目时是自动打开浏览器
      strictPort: false, //如果port指定端口被占用，是否仍然使用此端口（而不自动使用其它可用端口）
      https: false,//是否使用https访问
      
      //服务端代理设置
      proxy: {
        //如果访问地址以"/api"开头，则自动代理到服务端地址http://localhost:8080,同时将"/api"替换为""
        '/api': {
          target: 'http://localhost:8080',
          changeOrigin: true,
          rewrite: path => path.replace(/^\/api/, '')
        }
      }
    },

    build: {
      //项目打包输出目录，由环境变量VITE_BASE_URL指定
      outDir: env.VITE_OUTPUT_DIR 
    }
  })

}


