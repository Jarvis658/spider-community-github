<template>
  <div div class="all">
    <div style="margin-left:50px">
      <input
        v-model="dto.msg"
        type="text"
        style="height:30px;width:200px; border:none;border-radius:200px;padding:12px"
        placeholder="请输入关键词"
      >
      <a-dropdown>
        <template #overlay>
          <a-menu>
            <a-menu-item key="1" @click="search1">搜ID</a-menu-item>
            <a-menu-item key="2" @click="search2">搜昵称（按注册时间排序）</a-menu-item>
            <a-menu-item key="3" @click="search3">搜昵称（按最近登录时间排序）</a-menu-item>
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
    <div class="mainSearch">
      <div class="contentSearch">
        <div class="row" v-for="item in resultList" @click.prevent="loadUser(item.user_id)">
          <div class="image">
            <a href="#">
              <img
                :src="item.user_avatar"
                style="
                  width: 85px;
                  height:85px;
                  border-radius: 200px;
                  margin-left: 20px;
                  margin-top: 8px;
                "
              >
            </a>
          </div>
          <div class="rightContent" href="#" >
            <div class="title">
              <h2 style="margin-top: 20px">昵称：{{item.user_name}}</h2>
              <h2 style="font-size:20px">ID：{{item.user_id}}</h2>
            </div>
          </div>
        </div>
      </div>
      <div class="right"></div>
    </div>
  </div>
</template>
<script setup>
import { reactive, ref } from "@vue/reactivity";
import { post, setLocalToken, tip } from "@/common";
import { useRouter, useRoute } from "vue-router";

const router = useRouter();
const route = useRoute();

const dto = reactive({
  key: "",
  msg: ""
});

var search1 = function() {
  dto.key = "1";
  post("/admin/users/search", {
    msg: dto.msg,
    key: dto.key
  }).then(res => {
    console.log(res.data);
    resultList.value = res.data;
    console.log(resultList);
  });
};

var search2 = function() {
  dto.key = "2";
  post("/admin/users/search", {
    msg: dto.msg,
    key: dto.key
  }).then(res => {
    console.log(res.data);
    resultList.value = res.data;
    console.log(resultList);
  });
};
var search3 = function() {
  dto.key = "3";
  post("/admin/users/search", {
    msg: dto.msg,
    key: dto.key
  }).then(res => {
    console.log(res.data);
    resultList.value = res.data;
    console.log(resultList);
  });
};

var resultList = ref({});

function loadPost(index) {
  router.push({ path: "/post_audit_loadContent", query: { post_id: index } });
}

function loadUser(user_id) {
  router.push({
    path: "/loadUser",
    query: {userId:route.query.userId, userId2: user_id }
  });
}

post("/admin/users/search", {
  msg: " ",
  key: "  "
}).then(res => {
  console.log(res.data);
  resultList.value = res.data;
  console.log(resultList);
});
</script>
    
<style>
.all {
  height: 100%;
  width: 100%;
  display: flex;
  flex-direction: column;
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
  cursor: pointer;
  
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
