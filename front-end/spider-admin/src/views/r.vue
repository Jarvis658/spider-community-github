<template>
  <div class="containerLogin_">
    <div class="login-wrapper_">
      <div class="header">注册</div>
      <div class="form-wrapper">
        <input
          type="text"
          name="username"
          placeholder="工号"
          class="input-item"
          v-model="adminR.w_id"
        >
        <input
          type="text"
          name="username"
          placeholder="姓名"
          class="input-item"
          v-model="adminR.w_name"
        >
        <input
          type="text"
          name="username"
          placeholder="请输入0~300内账号ID"
          class="input-item"
          v-model="adminR.a_id"
        >
        <input
          type="text"
          name="username"
          placeholder="昵称"
          class="input-item"
          v-model="adminR.name"
        >
        <input
          type="password"
          name="password"
          placeholder="密码"
          class="input-item"
          v-model="adminR.a_pwd"
        >
        <input
          type="password"
          name="password"
          placeholder="请确认密码"
          class="input-item"
          v-model="adminR.a_pwd2"
        >
        <div class="btn" @click="R">注册</div>
      </div>
      <div class="msg">
        <!-- 没有账号？ <a href="#" @click.prevent="toRegister">点击注册</a> -->
      </div>
    </div>
  </div>
</template>



<script setup>
import { reactive, ref } from "vue";
import { post, setLocalToken, tip } from "@/common";
import { useRouter } from "vue-router";
//reactive是双向绑定的响应式变量(这个变那个变,那个变这个变)

const router = useRouter();
var uid = "";
const adminR = reactive({
  w_id: "",
  w_name: "",
  a_id: "",
  name: "",
  a_pwd: "",
  a_pwd2: ""
});
var info = ref({});

const R = () => {
  // router.push({ path: "/home", query: { userId: adminLogin.a_id }});
  post("admin/register", adminR).then(res => {
    console.log(res);

    if (res.message != "注册成功") tip.error(res.message);
    else {
      tip.success(res.message);
    }

    //跳转至home路由
    router.push({ path: "/login" });
  });
};
</script>


<style>
.containerLogin_ {
  height: 100%;
  width: 100%;
  background-image: linear-gradient(to right, #fbc2eb, #a6c1ee);
  font-family: "Open Sans Light";
  letter-spacing: 0.05em;
}

.login-wrapper_ {
  background-color: #fff;
  width: 400px;
  height: 600px;
  border-radius: 15px;
  padding: 0 50px;
  position: relative;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

.login-wrapper_ .header {
  font-size: 30px;
  font-weight: bold;
  text-align: center;
  line-height: 100px;
}

.login-wrapper_ .form-wrapper .input-item {
  display: block;
  width: 100%;
  margin-bottom: 20px;
  border: 0;
  padding: 10px;
  border-bottom: 1px solid rgb(128, 125, 125);
  font-size: 15px;
  outline: none;
}

.login-wrapper_ .form-wrapper .input-item::placeholder {
  text-transform: uppercase;
}

.login-wrapper_ .form-wrapper .btn {
  text-align: center;
  padding: 10px;
  width: 100%;
  margin-top: 40px;
  background-image: linear-gradient(to right, #a6c1ee, #fbc2eb);
  color: #fff;
}

.login-wrapper_ .msg {
  text-align: center;
  line-height: 60px;
}

.login-wrapper_ .msg a {
  text-decoration-line: none;
  color: #a6c1ee;
}
</style>
