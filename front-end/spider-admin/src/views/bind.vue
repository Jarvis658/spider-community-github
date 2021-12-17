<template>
  <div>
    <div style="margin-top :16px ;margin-left :16px ; margin-bottom: 16px ">
      <button disabled>账号</button>
      <input v-model="dto.u_id">
    </div>
    <div style="margin-left :16px ;margin-bottom: 16px">
      <button disabled>密码</button>
      <input v-model="dto.u_pwd">
    </div>
    <button style="margin-left :16px ;margin-bottom: 16px" @click="bind">绑定</button>
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

const dto = reactive({
  u_id: "",
  u_pwd: ""
});

var bind = () => {
  var str = route.query.userId;
  console.log(str);
  post("/admin/info/bind", {
    a_id: route.query.userId,
    u_id: dto.u_id,

    u_pwd: dto.u_pwd
  }).then(res => {
    if (res.message == "该用户账号已被绑定") tip.error("该用户账号已被绑定");
    if (res.message == "用户账号或密码输入错误")
      tip.error("用户账号或密码输入错误");
    if (res.message == "该管理员账号已绑定，请先接绑")
      tip.error("该管理员账号已绑定，请先接绑");
    if (res.message == "绑定成功") tip.success("绑定成功");
  });
};
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
