<template>
  <div class="all">
    <div class="top-menu">

      <div class="font" style="text-align:center; margin-left: 250px">
        <a href="#" @click.prevent="home" style="color: black; font-size: 15px;">首页</a>
      </div>
       <div class="font" style="text-align:center; margin-left: 70px">
        <a href="#" @click.prevent="user" style="color: black; font-size: 15px">个人中心</a>
      </div> 
      <div class="font" style="text-align:center; margin-left: 60px">
        <a href="#" @click.prevent="post1" style="color: black; font-size: 15px">我要发帖</a>
      </div>

      <div> 
        <input
          type="text"
          v-model="SearchDto.msg"
          style="height:30px;width:200px; margin-left:100px;border:none;border-radius:200px;padding:12px"
          placeholder="请输入关键词"
        >
        <a-dropdown>
          <template #overlay>
            <a-menu>
              <a-menu-item key="1" @click="Search1">按内容</a-menu-item>
              <a-menu-item key="2" @click="Search2">按标题</a-menu-item>
              <a-menu-item key="3" @click="Search3">按作者ID</a-menu-item>
              <a-menu-item key="4" @click="Search4">按文章ID</a-menu-item>
            </a-menu>
          </template>
          <button
            class="btn btn-primary"
            style="margin-left: 5px;width: 37px;background-color: pink;border: none;border-radius:200px;"
          >
            <i class="fa fa-search" style="color: #fff"></i>
          </button>
        </a-dropdown>
      </div>
      <div style="margin-left: 530px;">
        <a-dropdown>
          <template #overlay>
            <a-menu>
              <a-menu-item key="3" @click="info"> </a-menu-item>
              <a-menu-item key="4" @click="logout">退出</a-menu-item>
            </a-menu>
          </template>
          <button
            class="btn btn-primary"
            style="margin-left: -20px;width: 110px;background-color: rgb(184, 202, 235);border: none;border-radius:200px;"
          >
            <i class="fa fa-user-circle">&nbsp;&nbsp;{{adminInfo.name}}</i>
          </button>
        </a-dropdown>
      </div>
    </div>

    <div class="main">
      <div class="nav">
        <ul class="ul1">
          <li class="navh">功能导航</li>

          <li class="navi">
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
var adminInfo = ref({});

const SearchDto = reactive({
  msg: "",
  key: ""
});

const post_audit = () => {
  router.push({ path: "/post_audit" , query: { userId: route.query.userId } });
};

const user_manage = () => {
  router.push({ path: "/user_manage" , query: { userId: route.query.userId } });
};

const label_manage = () => {
  router.push({ path: "/label_manage" , query: { userId: route.query.userId } });
};

const info = () => {
  router.push({ path: "/info", query: { userId: route.query.userId } });
};

const post_ = () => {
  router.push({ path: "/post", query: { userId: route.query.userId } });
};

const logout = () => {
  removeLocalToken();
  router.push({ path: "/login" });
  // location.reload();
};




const userInfo = ;
post("/admin/getAname", { A_id: route.query.userId }).then((res) => {
  if(res.message=='非法加载'){
    router.back();
  }
  else{
    userInfo.value = res.data;
  }
});

const Search1 = function() {
  if (SearchDto.msg == "") {
    tip.error("请输入内容");
  } else {
    SearchDto.key = "1";
    router.push({
      path: "/search",
      query: {
        msg: SearchDto.msg,
        key: SearchDto.key,
        userId: route.query.userId
      }
    });
  }
};

const Search2 = function() {
  if (SearchDto.msg == "") {
    tip.error("请输入内容");
  } else {
    SearchDto.key = "2";
    router.push({
      path: "/search",
      query: {
        msg: SearchDto.msg,
        key: SearchDto.key,
               userId: route.query.userId
      }
    });
  }
};


const Search3 = function() {
  if (SearchDto.msg == "") {
    tip.error("请输入内容");
  } else {
    SearchDto.key = "3";
    router.push({
      path: "/search",
      query: {
        msg: SearchDto.msg,
        key: SearchDto.key,
               userId: route.query.userId
      }
    });
  }
};

const Search4 = function() {
  if (SearchDto.msg == "") {
    tip.error("请输入内容");
  } else {
    SearchDto.key = "4";
    router.push({
      path: "/search",
      query: {
        msg: SearchDto.msg,
        key: SearchDto.key,
        userId: route.query.userId
      }
    });
  }
};

var home = function(){
   router.push({
    path: "/home",
    query: { userId: route.query.userId }
  });
}
var user = function(){
   router.push({
    path: "/info",
    query: { userId: route.query.userId }
  });
}
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
  background-color: rgb(226, 220, 226);
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
  background-color: rgb(233, 220, 225);
}

.navh {
  height: 60px;
  font-family: "黑体";
  font-size: 20px;
  font-weight: bold;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.navi {
  margin-top: 10px;
  height: 50px;
  width: 200px;
  font-family: "宋体";
  font-size: 15px;
  font-weight: bold;
  display: flex;
  flex-direction: column;
  justify-content: center;
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
  background-color: rgb(255, 239, 239);
}
</style>