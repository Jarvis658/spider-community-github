<template>
  <div class="containerLogin">
    <div class="login-wrapper">
      <div class="header">Login</div>
      <div class="form-wrapper">
        <input type="text" name="username" placeholder="用户名/学工号" class="input-item" id="u_id" v-model="userLogin.u_id">
        <input type="password" name="password" placeholder="密码" class="input-item" id="u_pwd" v-model="userLogin.u_pwd">
        <div class="btn" @click="login">登录</div>
      </div>
      <div class="msg">
        没有账号？ <a href="#" @click.prevent="toRegister">点击注册</a>
      </div>
      <div class="forget">
        <a href="#" @click="toReset">忘记密码</a>
      </div>
    </div>
  </div>
</template>



<script setup>
import { reactive,ref } from "vue";
import { post, setLocalToken, tip } from "@/common";
import { useRouter } from "vue-router";
//reactive是双向绑定的响应式变量(这个变那个变,那个变这个变)

const router = useRouter();
var uid = ""
const userLogin = reactive({
  u_id: "",
  u_pwd: "",
});
var info = ref({})

const login = () => {
        router.push({ path: "/home", query: { userId: userLogin.u_id }});              
        // post("/security/login", userLogin).then((res) => {

        //     console.log(res);
        //     if(res.message != ""){
        //       userLogin.u_id = res.message;
        //     }
            
        //     console.log(userLogin.u_id);
            
        //     tip.success("登录成功！");

        //     //获取服务端返回的令牌
        //     const token = res.data;

        //     //将令牌存储于本地
        //     setLocalToken(token);

        //     //跳转至home路由
        //     router.push({ path: "/recommend", query: { userId: userLogin.u_id }});
        //   });
};

const toRegister = () => {
  router.push({ path: "/security/register"});//跳转至
}

const toReset = () => {
  router.push({ path: "/reset"});
}
</script>


<style>

.containerLogin{
  height: 100%;
  width: 100%;
  background-image: linear-gradient(to right,#fbc2eb,#a6c1ee);
  font-family: 'Open Sans Light';
  letter-spacing: .05em;
}

.login-wrapper{
  background-color: #fff;
  width: 400px;
  height: 500px;
  border-radius: 15px;
  padding: 0 50px;
  position: relative;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
}

.login-wrapper .header {
  font-size: 30px;
  font-weight: bold;
  text-align: center;
  line-height: 200px;
}

.login-wrapper .form-wrapper .input-item {
  display: block;
  width: 100%;
  margin-bottom: 20px;
  border: 0;
  padding: 10px;
  border-bottom: 1px solid rgb(128, 125, 125);
  font-size: 15px;
  outline: none;
}

.login-wrapper .form-wrapper .input-item::placeholder {
  text-transform: uppercase;
}

.login-wrapper .form-wrapper .btn {
  text-align: center;
  padding: 10px;
  width: 100%;
  margin-top: 40px;
  background-image: linear-gradient(to right,#a6c1ee,#fbc2eb);
  color: #fff;
}

.login-wrapper .msg {
  text-align: center;
  line-height: 60px;
}

.login-wrapper .msg a {
  text-decoration-line: none;
  color: #a6c1ee;
}


.login-wrapper .forget {
  text-align: center;
  margin-top: -10px;
}

.login-wrapper .forget a {
  text-decoration-line: none;
  color: #a6c1ee;
}

</style>
