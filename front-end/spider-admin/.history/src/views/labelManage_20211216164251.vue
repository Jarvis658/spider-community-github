<template>
  <div div class="all">
    <div class="mainSearch">
      <div class="left"></div>
      <div class="contentSearch">
        <div class="row" v-for="item in labelList">
          <div class="rightContent">
            <div class="title">
              <h2 style="margin-top: 20px; padding-left: 15px">
                {{ item }}
              </h2>
            </div>
          </div>
          <div class="deleteLabel" @click.prevent="labelDelete(item)">删除</div>
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

const newPost = reactive({
  audit_status: "",
  post_id: "",
});

var labelList = ref({});

function labelDelete(label) {
  console.log(label);
  post("/admin/label/delete", {
    :msg: label
  }).then((res) => {
    console.log(res);
  });
}

post("/admin/label/search", {
  msg: " ",
}).then((res) => {
  console.log(res.data);
  labelList.value = res.data;
  console.log(labelList);
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
  height: 60px;
  display: flex;
  flex-direction: row;
  align-content: center;
  position: relative;
  margin-bottom: 10px;
  margin-left: 10px;
  margin-top: 10px;
  border-radius: 200px;
}

.row:hover {
  background: rgb(204, 201, 201);
  transform: scale(1.01);
}

.rightContent {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.title {
  width: 100%;
}

.deleteLabel {
  right: 15px;
  color: cornflowerblue;
  position: absolute;
  top: 30%;
}
</style>
