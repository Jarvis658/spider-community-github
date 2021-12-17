<template>
  <div class="all">
  
    <div class="top-menu">
      <div>
        管理后台
      </div>
      <div style="margin-left: 530px;">
          <button class="btn btn-primary" style="margin-left: -20px;width: 110px;background-color: rgb(184, 202, 235);border: none;border-radius:200px;" @click="logout">
            退出
          </button>
      </div>
    </div>

    <div class="main">
      <div class="nav">
        <ul class="ul1">
          <li class="navh">功能导航</li>
          <li class="navi" >
            <a href="#" @click.prevent="post_audit" style="color: gray">文章管理</a>
          </li>
          <li class="navi">
            <a href="#" @click.prevent="user_manage" style="color: gray">用户管理</a>
          </li>
          <li class="navi">
            <a href="#" @click.prevent="label_manage" style="color: gray">标签管理</a>
          </li>
          <li class="navi">
            <a href="#" @click.prevent="post_" style="color: gray">发布文章</a>
          </li>
          <li class="navi">
            <a href="#" @click.prevent="info" style="color: gray">个人信息</a>
          </li>
        </ul>
      </div>

      <div class="content">
        <router-view></router-view>
      </div>
    </div>


  </div>
</template>

<script setup>
import { useRouter, useRoute } from "vue-router";
import { reactive, ref } from "vue";
import { get, post, setLocalToken, tip } from "@/common";
import { removeLocalToken } from "@/common/token.js";

const router = useRouter();
const route = useRoute();
var userInfo = ref({});
const SearchDto = reactive({
  msg: "",
  key: ""
});

const post_audit = () => {
  router.push({ path: "/post_audit"});
};

const user_manage = () => {
  router.push({ path: "/user_manage"});
};

const label_manage = () => {
  router.push({ path: "/label_manage"});
};

const info = () => {
  router.push({ path: "/info" ,query:{adminId:route.query.adminId}});
};

const post_ = () => {
  router.push({ path: "/post" ,query:{adminId:"100"}});
};

const logout = () => {
  removeLocalToken();
  router.push({ path: "/login" });
  location.reload();
};


</script>

<style>
.all {
  height: 100%;
  width: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden;

}

.top-menu {
  height: 60px;
  width: 100%;
  display: flex;
  flex-direction: row;
  align-items: center;
}

.main {
  width: 100%;
  height: 0px;
  flex: 1;
  display: flex;
  flex-direction: row;
}

.nav {
  height: 100%;
  width: 200px;
  background-color:rgb(247, 226, 234);
}

.navh {
  height: 60px;
  font-family: "黑体";
  font-size: 20px;
  font-weight: bold;
  display: flex;
  flex-direction:column;
  justify-content:center ;
}

.navi {
  margin-top: 10px;
  height: 50px;
  width: 200px;
  font-family: "宋体";
  font-size: 15px;
  font-weight: bold;
  display: flex;
  flex-direction:column;
  justify-content:center ;
    
}

.navi:hover {
  background: rgb(204, 201, 201);
}

.ul1 {
  text-align: center;
  list-style: none;

}
.content {
  width: 0px;
  overflow-y: auto;
  overflow-x: hidden;
  flex: 1;
  background-color: rgb(206, 203, 203);
}
</style>