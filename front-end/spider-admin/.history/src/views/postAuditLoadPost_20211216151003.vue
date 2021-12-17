<template>
  <div>

    <div class="title">{{ Title }}</div>
    <div v-html="Post" />
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

const pass = function () {
  post("/admin/audit/setstatus", {
    audit_status: 1,
    post_id: route.query.post_id,
  }).then((res) => {
    console.log("/");
  });
};

const reject = function () {
  post("/admin/audit/setstatus", {
    audit_status: 0,
    post_id: route.query.post_id,
  }).then((res) => {
    console.log("!");
  });
};
</script>

<style>
.title {
  font-size: xx-large;
  background: #ca5e5e;
  text-align: center;
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