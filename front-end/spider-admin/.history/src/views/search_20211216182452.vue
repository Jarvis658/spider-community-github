<template>
  <div div class="all">
    <div class="mainSearch">
      <div class="left"></div>
      <div class="contentSearch">
        <div class="row" v-for="item in resultList">
          <div class="image">
            <a href="#">
              <img
                :src="item.avatar"
                onerror="errorHandler(this)"
                style="width: 85px; border-radius: 200px; margin-left: 20px;margin-top:8px;"
              >
            </a>
          </div>
          <div class="rightContent">
            <div class="title">
              <h2 style="margin-top:20px">
                <a
                  href="#"
                  @click.prevent="loadPost(item.post_id)"
                  style="color: black;"
                >{{item.post_title}}</a>
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
import { reactive, ref, defineComponent } from "vue";
import { post, tip } from "@/common";
import { DownOutlined } from "@ant-design/icons-vue";
import { useRouter, useRoute } from "vue-router";
import { removeLocalToken } from "@/common/token.js";

const router = useRouter();
const route = useRoute();
var resultList = ref([]);
var userInfo = ref({});
var key = ref(route.query.key);
const SearchDto = reactive({
  msg: "",
  key: ""
});

// var user = function(){
//   router.push({ path: "/user/info",query: { userId:route.query.userId} });
// };

var otherUser = function(id) {
  if (id == route.query.userId) {
    router.push({ path: "/user/info", query: { userId: route.query.userId } });
  } else {
    router.push({
      path: "/user/othersInfo",
      query: { userId: route.query.userId, newUserId: id }
    });
  }
};

var recommend = function() {
  router.push({
    path: "/recommend",
    query: { userId: route.query.userId }
  });
};

post("/admin/post/search", { msg: route.query.msg, key: route.query.key }).then(
  res => {
    resultList.value = res.data;
  }
);

var loadPost = function(post_id) {
  router.push({
    path: "/load_post",
    query: { post_id: post_id, userId: route.query.userId }
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
