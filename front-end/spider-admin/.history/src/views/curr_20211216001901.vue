<template>
  <div>
    <div>
      <img src="current.avatar">
      <div style="margin-bottom: 16px">
        <button>昵称</button>
        <input v-model="current.name">
      </div>
      <div style="margin-bottom: 16px">
        <button>性别</button>
        <input v-model="current.sex">
      </div>
      <div style="margin-bottom: 16px">
        <button>生日</button>
        <input v-model="current.birthday2" disabled>
      </div>

      <div style="margin-bottom: 16px">
        <button disabled>年份</button>
        <input v-model="b.y">
        <button disabled>月份</button>
        <input v-model="b.m">
        <button disabled>日期</button>
        <input v-model="b.d">
      </div>
      <div>
        <button @click="change">修改</button>
      </div>
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
const b = reactive({
  y: "",
  m: "",
  d: ""
});

const current = reactive({
  name: "",
  avatar: "",
  sex: "",
  birthday: "",
  birthday2: ""
});
var c = ref();
var birthday1 = ref();
var loadcurr = function(userId) {
  console.log("curr", current);
};

const change = function() {
  var n = b.y + "-" + b.m + "-" + b.d;
  // console.log("!!",current.name);
  if (n != null) {
    post("/admin/info/update_current", {
      name: current.name,
      sex: current.sex,
      avatar: current.avatar,
      birthday: n,
      id: route.query.userId
    });
  } else {
    post("/admin/info/update_current", {
      name: current.name,
      sex: current.sex,
      avatar: current.avatar,
      birthday: current.birthday,
      id: route.query.userId
    });
  }
};

post("/admin/info/view_current", { uid: route.query.userId }).then(res => {
  current.name = res.data.admin_name;
  current.sex = res.data.admin_sex;
  current.birthday = res.data.admin_birthday;
  current.birthday2 = res.data.admin_birthday;
  current.avatar = res.data.admin_avatar;
  console.log(current);
});
</script>

<style>
.all {
  height: 100%;
  width: 100%;
  display: flex;
  flex-direction: column;
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
