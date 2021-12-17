<template>
  <div div class="all">
    <div class="mainSearch">
      <div class="contentSearch">
        <div class="row" v-for="item in resultList">
          <div class="image">
            <a href="#">
              <img
                :src="item.cover_image"
                style="
                  width: 85px;
                  heigh
                  border-radius: 200px;
                  margin-left: 20px;
                  margin-top: 8px;
                "
              />
            </a>
          </div>
          <div class="rightContent">
            <div class="title">
              <h2 style="margin-top: 20px">
                <a
                  href="#"
                  @click.prevent="loadPost(item.post_id)"
                  style="color: black"
                  >{{ item.post_title }}</a
                >
              </h2>
            </div>
          </div>
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

var resultList = ref({});

function loadPost(index) {
  router.push({ path: "/post_audit_loadContent", query: { post_id: index } });
}
 post("/admin/audit/loadpost", {
    audit_status: newPost.audit_status,
    post_id: newPost.post_id,
  }).then((res) => {
    console.log(res.data);
    resultList.value = res.data;
    console.log(resultList);
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
