<template>
  <div>
    <div
      style="
        text-align: center;
        display: inline-block;
        padding: 0 10px;
        color: #fff;
        line-height: 2;
        font-weight: 420;
        background: #4178b0;
        font-size: 30px;
        width: 100%;
      "
    >
      {{ postContent.post_title }}<br />
    </div>
    <br />

    <div
      style="
        text-align: center;
        height: 20px;
        font-weight: 400;
        font-size: 16px;
      "
    >
      作者：<a href="#" @click.prevent="uesrInfo(postContent.user_id)">{{
        postContent.user_name
      }}</a
      >&nbsp;&nbsp;&nbsp;&nbsp;发表时间：{{
        postContent.post_time
      }}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </div>
    <br />
    <hr style="margin-left: 50px; margin-right: 50px" />
    <div v-html="postContent.post_content" />
    <hr style="margin-left: 50px; margin-right: 50px" />

    <div style="padding-right: 20px">
      <div style="margin-left: 300px, margin-top: 50px"><a-button @click="pass" class="btn1">pass</a-button></div>
      <div><a-button @click="reject" class="btn2">reject</a-button></div>
      <a-popconfirm
    title="确认删除？"
        ok-text="确认"
    cancel-text="取消"
    @confirm="confirm"
    @cancel="cancel"
  >
  <i
      class="fa fa-trash-o"
      style="font-size: 30px; cursor: pointer"
    ></i>
  </a-popconfirm>
    </div>
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
const postContent = ref({});
var Post = ref();
var Title = ref();
var sure = ref("0");

post("/user/load_post/loadPost", {
  pno: route.query.post_id,
  uid: route.query.user_id,
}).then((res) => {
  if (res.data == null) {
    router.push({ path: "/404" });
  }
  if (res.message == "非法加载") {
    router.back();
  }
  postContent.value = res.data;
  console.log(postContent);
});

const confirm = function () {
      post("/user/post/delete", {
      post_id: route.query.post_id,
      user_id: route.query.user_id,
    }).then((res) => {
      tip.success("删帖成功！");
      router.push({ path: "/post_audit",query:{userId:route.query.userId}});
    });
    };
const cancel = function() {
      console.log("取消删帖")
    }

const pass = function () {
  post("/admin/audit/setstatus", {
    audit_status: 1,
    post_id: route.query.post_id,
  }).then((res) => {
    tip.success(res.message);
    router.push({ path: "/post_audit", query: { userId: route.query.userId } });
  });
};

const reject = function () {
  post("/admin/audit/setstatus", {
    audit_status: 2,
    post_id: route.query.post_id,
  }).then((res) => {
    tip.success(res.message);
    router.push({ path: "/post_audit", query: { userId: route.query.userId } });
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