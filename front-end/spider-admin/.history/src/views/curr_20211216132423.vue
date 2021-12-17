<template>
  <div>
    <div>
      <div style="margin-bottom: 16px; margin-top: 10px; margin-left: 10px">
        <img v-if="current.avatar" :src="current.avatar" style="width: 40px; height: 40px; border-radius: 20px">
         <a-button @click="uploadAvatar">修改头像</a-button>
          <input type="file" ref="avatarRef" v-show="false" @change="handleFile" />
      </div>
    
      <div style="margin-bottom: 16px">
        <button>昵称</button>
        <input v-if="current.name" v-model="current.name">
      </div>
      <div style="margin-bottom: 16px">
        <button>性别</button>
        <input v-if="current.sex" v-model="current.sex">
      </div>
      <div style="margin-bottom: 16px">
        <button>生日</button>
        <input v-if="current.birthday2" v-model="current.birthday2" disabled>
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
import { reactive, ref,getCurrentInstance } from "vue";
import { post, tip } from "@/common";
import { DownOutlined } from "@ant-design/icons-vue";
import { useRouter, useRoute } from "vue-router";
import { removeLocalToken } from "@/common/token.js";
const router = useRouter();
const route = useRoute();
const { proxy } = getCurrentInstance();//proxy = this
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

post("/admin/info/view_current", { uid: route.query.userId }).then(res => {
  current.name = res.data.admin_name;
  current.sex = res.data.admin_sex;
  current.birthday = res.data.admin_birthday;
  current.birthday2 = res.data.admin_birthday;
  current.avatar = res.data.admin_avatar;
  console.log(current);
});

var c = ref();
var birthday1 = ref();
var loadcurr = function(userId) {
  console.log("curr", current);
};
var avatarFile = null;
const uploadAvatar = function(){
  proxy.$refs.avatarRef.click();
}

const handleFile = function() {
    avatarFile = proxy.$refs.avatarRef.files[0];
    let avatarForm = new FormData();
    avatarForm.append("avatar", avatarFile);
    avatarForm.append("admin_id", route.query.userId);
    post("admin/info/update_avatar", avatarForm).then((res) => {
      alert(res.message);
      location.reload();
    });
}

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
