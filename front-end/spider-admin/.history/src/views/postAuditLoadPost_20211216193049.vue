<template>
  <div>
    <div class="loadPostTitle">{{ Title }}</div>
    <div v-html="Post" />
    <div><button @click="pass" class="btn1">pass</button></div>
    <div><button @click="reject" class="btn2">reject</button></div>
    <i
      class="fa fa-trash-o"
      @click="removePost(route.query.post_id)"
      style="fontsize: 20px; cursor: pointer"
    ></i>
  </div>
</template>

<script setup>
import { reactive, ref } from "@vue/reactivity";
import { post, setLocalToken, tip } from "@/common";
import { useRouter, useRoute } from "vue-router";

const router = useRouter();
const route = useRoute();

const Dto = reactive({
  audit_status: "",
  post_id: "",
});

var Post = ref();
var Title = ref();
var sure = ref("0");
post("/admin/audit/loadcontent", {
  audit_status: Dto.audit_status,
  post_id: route.query.post_id,
}).then((res) => {
  Post.value = res.message;
});

post("/admin/audit/loadtitle", {
  audit_status: Dto.audit_status,
  post_id: route.query.post_id,
}).then((res) => {
  Title.value = res.message;
});

var removePost = function (postId) {
  console.log(sure);
  if (sure == 0) tip.success("确定要删帖吗？是则再点击一次");

  if (sure == 1) {
    post("/user/post/delete", {
      post_id: route.query.post_id,
      user_id: route.query.user_id,
    }).then((res) => {
      tip.success("删帖成功！");
      router.push({ path: "/home", query: { userId: route.query.userId } });
    });
  }

  sure = 1;
};

const pass = function () {
  post("/admin/audit/setstatus", {
    audit_status: 1,
    post_id: route.query.post_id,
  }).then((res) => {
     router.push({ path: "/post_audit" , query: { userId: route.query.userId } });
  });
};

const reject = function () {
  post("/admin/audit/setstatus", {
    audit_status: 2,
    post_id: route.query.post_id,
  }).then((res) => {
      tip.success(res.message)
     router.push({ path: "/post_audit" , query: { userId: route.query.userId } });
  });
};
</script>

<style>
.loadPostTitle {
  font-size: xx-large;
  text-align: center;
  border-bottom: 2px;
}
.btn1 {
  /* display: inline; */
  float: left;
}
btn2 {
  /* display: inline; */
  float: left;
}
</style>