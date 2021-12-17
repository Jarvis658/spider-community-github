<template>
  <div>
    <div style="margin-top :16px ;margin-left :16px ; margin-bottom: 16px ">
      <button style="margin-left:55px" disabled>旧密码</button>
      <input type="password" v-model="dto.op">
    </div>
    <div style="margin-left :16px ;margin-bottom: 16px">
      <button style="margin-left:55px" disabled>新密码</button>
      <input type="password" v-model="dto.np1">
    </div>
    <div style="margin-left :16px ;margin-bottom: 16px">
      <button disabled>再次输入新密码</button>
      <input type="password" v-model="dto.np2">
    </div>
    <button style="margin-left :16px ;margin-bottom: 16px" @click="change">修改</button>
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
  op: "",
  np1: "",
  np2: ""
});

var change = () => {
  var str = route.query.userId;
  post("/admin/info/update_password", {
    a_id: route.query.userId,
    oldP: dto.op,
    newP: dto.np1,
    newPre: dto.np2
  }).then(res => {
      if(res.message=="原密码错误")tip.error(res.message);
      else{
        tip.success(res.message);
        
      } 
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
