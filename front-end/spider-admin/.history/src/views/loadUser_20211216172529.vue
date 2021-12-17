<template>
  <div>
    <div style="margin-left:60px;margin-top:30px;font-size:30px">
      <div>
        <img v-if="current.avatar" :src="current.avatar" style="width: 60px; height: 60px; border-radius: 30px; padding-bottom: 10px">
        <div style="margin-bottom: 16px">
          <button disabled>昵称</button>
          <input v-model="current.name" disabled>
        </div>
        <div style="margin-bottom: 16px">
          <button disabled>学校</button>
          <input v-model="current.school" disabled>
        </div>
        <div style="margin-bottom: 16px">
          <button disabled>签名</button>
          <input v-model="current.signature" disabled>
        </div>
        <div style="margin-bottom: 16px">
          <button disabled>性别</button>
          <input v-model="current.sex " disabled>
        </div>
        <div style="margin-bottom: 16px">
          <button disabled>生日</button>
          <input v-model="current.birthday" disabled>
        </div>
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

const current = reactive({
  name: "",
  avatar: "",
  sex: "",
  birthday: undefined,
  school: "",
  signature: ""
});

post("/user/info/view", { uid: route.query.userId }).then(res => {
  current.name = res.data.user_name;
  current.sex = res.data.user_sex;
  current.birthday = res.data.user_birthday;
  current.signature = res.data.user_signature;
  current.avatar = res.data.user_avatar;
  current.school = res.data.user_school;
  current.id = res.data.user_id;
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
