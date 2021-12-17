<template>
  <div id="all">
    <div>
      <a-button type="primary" @click="loadcurr">个人信息</a-button>
    </div>
    <div style="margin-top:20px">
      <a-button @click="loadc">C端账号信息</a-button>
    </div>
    <div style="margin-top:20px">
      <a-button @click="bind">绑定C端</a-button>
    </div>
    <div style="margin-top:20px">
      <a-button @click="unbind">解除绑定</a-button>
    </div>
        <div style="margin-top:20px">
      <a-button @click="changePwd">修改密码</a-button>
    </div>
  </div>
</template>




<script setup>
import { reactive, ref, defineComponent } from "vue";
import { post, tip } from "@/common";
import { DownOutlined } from "@ant-design/icons-vue";
import { useRouter, useRoute } from "vue-router";
import { removeLocalToken } from "@/common/token.js";
const router = useRouter();
const route = useRoute();
var current = {};

var loadc = function(userId) {
  router.push({
    path: "/info/c",
    query: { userId: route.query.userId }
  });
};
var bind = function(userId) {
  router.push({
    path: "/info/bind",
    query: { userId: route.query.userId }
  });
};
var changePwd=function(){
  router.push({
    path: "/info/changePwd",
    query: { userId: route.query.userId }
  });
}

var unbind =()=>{

  post("/admin/info/unbind",{a_id:route.query.userId}).then((res)=>{tip.success(res.message)})
}

var loadcurr = function(userId) {
  router.push({
    path: "/info/curr",
    query: { userId: route.query.userId }
  });

  post("/admin/info/view_current", { uid: route.query.userId }).then(res => {
    current.value = res.data;
  });
  console.log("curr", current);
};
</script>

<style>
.all {
  height: 100%;
  width: 100%;
  display: flex;
  flex-direction: column;
}

.curr {
  height: 60px;
  width: 100%;
  display: flex;
  flex-direction: row;
  background-color: rgb(226, 220, 226);
  align-items: center;
  flex-shrink: 0;
}

.top-menu {
  height: 60px;
  width: 100%;
  display: flex;
  flex-direction: row;
  background-color: rgb(226, 220, 226);
  align-items: center;
  flex-shrink: 0;
}

.mainSearch {
  width: 100%;
  display: flex;
  flex-direction: row;
  flex: 1;
}

.right {
  width: 250px;
  height: 100%;
}

.left {
  width: 250px;
  height: 100%;
}

.contentSearch {
  width: 100%;
  display: flex;
  flex-direction: column;
}

.row {
  width: 1100px;
  height: 100px;
  display: flex;
  flex-direction: row;
  margin-bottom: 10px;
  margin-left: 10px;
  margin-top: 10px;
  border-radius: 200px;
}

.row:hover {
  background: rgb(204, 201, 201);
  transform: scale(1.01);
}

.image {
  width: 150px;
  height: 100%;
}

.rightContent {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.title {
  width: 100%;
}
</style>