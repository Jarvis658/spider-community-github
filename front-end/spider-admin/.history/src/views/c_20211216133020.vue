<template>
  <div>
    <div>
      <div style="margin-bottom: 16px; margin-top: 10px; margin-left: 10px">
        <img v-if="current.avatar" :src="current.avatar" style="width: 40px; height: 40px; border-radius: 20px">
        <!-- v-if数据加载出来后再渲染 -->
         <a-button @click="uploadAvatar">修改头像</a-button>
          <input type="file" ref="avatarRef" v-show="false" @change="handleFile" />
      </div>
      <div style="margin-bottom: 16px">
        <button disabled>昵称</button>
        <input v-model="current.name">
      </div>
      <div style="margin-bottom: 16px">
        <button disabled>学校</button>
        <input v-model="current.school">
      </div>
      <div style="margin-bottom: 16px">
        <button disabled>签名</button>
        <input v-model="current.signature">
      </div>
      <div style="margin-bottom: 16px">
        <button disabled>性别</button>
        <input v-model="current.sex">
      </div>
      <div style="margin-bottom: 16px">
        <button disabled>当前生日</button>
        <input v-model="current.birthday" disabled>
      </div>
      <div style="margin-bottom: 16px">
        <button disabled>年份</button>
        <input v-model="b.y" >
        <button disabled>月份</button>
        <input v-model="b.m" >
        <button disabled>日期</button>
        <input v-model="b.d" >
      </div>

      
      <div>
        <button @click="change">修改</button>
      </div>
    </div>
  </div>
</template>




<script setup>
import { reactive, ref, defineComponent, getCurrentInstance } from "vue";
import { post, tip } from "@/common";
import { DownOutlined } from "@ant-design/icons-vue";
import { useRouter, useRoute } from "vue-router";
import { removeLocalToken } from "@/common/token.js";
const router = useRouter();
const route = useRoute();
const { proxy } = getCurrentInstance();//proxy = this
const b = reactive({
  y:"",
  m:"",
  d:""
});

const current = reactive({
  name: "",
  avatar: "",
  sex: "",
  birthday: undefined,
  school: "",
  signature: ""
});
var c = ref();
var birthday1 = ref();
var loadcurr = function(userId) {
  console.log("curr", current);
};
//x
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
  // console.log("!!",current.name);

  var n=b.y+"-"+b.m+"-"+b.d
  // var date =new Date(str) 
  // var n=date.toJSON()
console.log(n)

  if(n!=null){
      post("/admin/info/update_c", {
    name: current.name,
    sex: current.sex,
    signature: current.signature,
    avatar: current.avatar,
    birthday: n,
    id: current.id,
    school: current.school
  });
  }else{
  post("/admin/info/update_c", {
    name: current.name,
    sex: current.sex,
    signature: current.signature,
    avatar: current.avatar,
    birthday: current.birthday,
    id: current.id,
    school: current.school
  });
  }
};

post("/admin/info/view_c", { uid: route.query.userId }).then(res => {
  if (res.message == "No Bind") tip.error("未绑定");

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
