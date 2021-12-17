<template>

<div class="all">
  <div class="top-menu">
      <div class="font" style="text-align:center; margin-left: 250px">
        <a href="#" @click.prevent="home" style="color: black; font-size: 15px;">首页</a>
      </div>
      <div class="font" style="text-align:center; margin-left: 70px">
        <a href="#" @click.prevent="user" style="color: black; font-size: 15px">个人中心</a>
      </div>
      <div class="font" style="text-align:center; margin-left: 60px">
        <a href="#" @click.prevent="post1" style="color: black; font-size: 15px">我要发帖</a>
      </div>
      <div>           
        <input type="text" v-model="SearchDto.msg" style="height:30px;width:200px; margin-left:100px;border:none;border-radius:200px;padding:12px" placeholder="请输入关键词"/>
          <a-dropdown>
            <template #overlay>
              <a-menu>
                 <a-menu-item key="1" @click="Search1">按内容</a-menu-item>
              <a-menu-item key="2" @click="Search2">按标题</a-menu-item>
              <a-menu-item key="3" @click="Search3">按作者ID</a-menu-item>
              <a-menu-item key="4" @click="Search4">按文章ID</a-menu-item>
              </a-menu>
            </template>
            <button class="btn btn-primary" style="margin-left: 5px;width: 37px;background-color: pink;border: none;border-radius:200px;">
              <i class="fa fa-search" style="color: #fff"></i>
            </button>
          </a-dropdown>
      </div>
      <div style="margin-left:530px">
        <a-dropdown>
          <template #overlay>
            <a-menu> 
              <a-menu-item key="3" @click="info_update">个人信息修改</a-menu-item>
              <a-menu-item key="4" @click="logout">退出</a-menu-item>
            </a-menu>
          </template>
          <button class="btn btn-primary" style="margin-left: -20px;width: 110px;background-color: rgb(184, 202, 235);border: none;border-radius:200px;">
            <i class="fa fa-user-circle">&nbsp;&nbsp;{{currentUser.uname}}</i>
          </button>
        </a-dropdown>
      </div>
  </div>

  <div class="main">        
    <div class="left"></div>
    
    <div class="container"><br/>
      
      <div class="titleLP" style="text-align: center;display: inline-block;padding: 0 10px;color: #fff;line-height: 2;font-weight: 420;background: #4178B0;font-size:30px">
        {{postContent.post_title}}<br/>
      </div><br/>

      <div class="infoLP" style="text-align: center;font-weight: 400;font-size:16px">
        作者：<a href="#" @click.prevent='uesrInfo(postContent.user_id)'>{{postContent.user_name}}</a>&nbsp;&nbsp;&nbsp;&nbsp;发表时间：{{postContent.post_time}}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
      </div><br/><hr style="margin-left:50px;margin-right:50px">

      <div class="postContent" v-html="postContent.post_content"  style="margin-left:50px;margin-right:50px;font-size:22px">
        {{postContent.post_content}}<br>
        <p style="text-align:center" v-if="postContent.pimage_file!=null"><img :src="postContent.pimage_file" alt="图片" style="height:400px;"/></p>
        </div><br/><hr style="margin-left:50px;margin-right:50px"><br/>
      
      <div class="toolBox" style="margin-left:900px">
        <i class="fa fa-thumbs-o-up" aria-hidden="true" @click="postLike" :style="{fontSize:'30px',cursor:'pointer',color:colorThumb}"></i>
        <i style="font-size:21px">&nbsp;{{countLike}}</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <i class="fa fa-trash-o"  @click="removePost(postContent.post_id)" style="fontSize:20px;cursor:pointer"></i>

      </div>


    </div>

    <div class="right"></div>
  </div>
  

</div>
  


  
</template>

<script setup>
import {useRoute,useRouter} from 'vue-router'
import {reactive,ref} from "vue";
import {get,post,setLocalToken,tip} from '@/common'
import { removeLocalToken } from "@/common/token.js";

const route = useRoute();
const router = useRouter();
const postContent = ref({});
var commentOneList = ref([]);
var commentTwoList = ref([]);
var currentUser = ref({});
var countLike = ref('')
var countCollection = ref('')
var userID = ref(route.query.userId)
var commentNo = ref(0)
var colorThumb = ref('')
var colorStar = ref('')
var placeholder = ref('发一条友善的评论吧！')
var sure = ref("0")

const postCommentInfo = reactive({
  ccontent:'',
  pno:route.query.postId,
  uid:route.query.userId,
  ctime:'',
  cstate:1,
  ctags:0,
  cfno:'',
  cno:'',
})

const SearchDto = reactive({
  msg: "",
  key: "",
});

var formatDate = function (value) {
  let date = new Date(value);
  let y = date.getFullYear();
  let MM = date.getMonth() + 1;
  MM = MM < 10 ? ('0' + MM) : MM;
  let d = date.getDate();
  d = d < 10 ? ('0' + d) : d;
  let h = date.getHours();
  h = h < 10 ? ('0' + h) : h;
  let m = date.getMinutes();
  m = m < 10 ? ('0' + m) : m;
  let s = date.getSeconds();
  s = s < 10 ? ('0' + s) : s;
  return y + '-' + MM + '-' + d + ' ' + h + ':' + m + ':' + s;
  }

post('/user/load_post/loadPost',{pno:route.query.post_id,uid:route.query.user_id}).then(res=>{
  if(res.data==null){
    router.push({path:'/404'})
  }
  if(res.message=='非法加载'){
    router.back();
  }
  postContent.value = res.data
  console.log(postContent);
  

})

post('/admin/post/recommend/check',{p_id:route.query.post_id,}).then(res=>{
  countLike.value =res.data 
sure=0

})



var postLike = function(){
    if(countLike.value=="已推荐") {
    post("/admin/post/delete_recommend",{p_id:route.query.post_id});
    } 
    else {
    post("/admin/post/recommend",{p_id:route.query.post_id});
    } 
  location.reload()
}


var uesrInfo = function(uid){
  if(uid==route.query.userId){
    router.push({
    path:'/user/info', query: { userId: uid}})
  }
  else{
     router.push({
    path:'/user/othersInfo', query: { userId: route.query.userId,newUserId:uid }})
  }
 
}



var removePost = function(postId){
    console.log(sure)
    if(sure==0)tip.success("确定要删帖吗？是则再点击一次");

    if (sure==1){
        tip.success("删帖成功！")
    post("/user/post/delete",{pno:route.query.post_id,uid:route.query.user_id}).then(res=>{
    tip.success("删帖成功！")
    router.push({path:'/home', query: { userId: route.query.userId}});
  })
    }

    sure=1
}

const Search1 = function() {
  if (SearchDto.msg == "") {
    tip.error("请输入内容");
  } else {
    SearchDto.key = "1";
    router.push({
      path: "/blank",
      query: {
        msg: SearchDto.msg,
        key: SearchDto.key,
              userId: route.query.userId
      }
    });
  }
};

const Search2 = function() {
  if (SearchDto.msg == "") {
    tip.error("请输入内容");
  } else {
    SearchDto.key = "2";
    router.push({
      path: "/blank",
      query: {
        msg: SearchDto.msg,
        key: SearchDto.key,
               userId: route.query.userId
      }
    });
  }
};


const Search3 = function() {
  if (SearchDto.msg == "") {
    tip.error("请输入内容");
  } else {
    SearchDto.key = "3";
    router.push({
      path: "/blank",
      query: {
        msg: SearchDto.msg,
        key: SearchDto.key,
               userId: route.query.userId
      }
    });
  }
};

const Search4 = function() {
  if (SearchDto.msg == "") {
    tip.error("请输入内容");
  } else {
    SearchDto.key = "4";
    router.push({
      path: "/blank",
      query: {
        msg: SearchDto.msg,
        key: SearchDto.key,
        userId: route.query.userId
      }
    });
  }
};

var user = function(){
  router.push({ path: "/user/info",query: { userId: route.query.userId } });
};

var home = function(){
   router.push({
    path: "/home",
    query: { userId: route.query.userId }
  });
}

const post1 = () => {
  router.push({ path: "/run/post" ,query:{userId:route.query.userId}});
};

const logout = () => {
  removeLocalToken();
  router.push({ path: "/login" });
  location.reload();
};

const info_update = () => {
  router.push({ path: "/user/info-update" ,query:{userId:route.query.userId}});
}
</script>

<style>
.all{
  height: 100%;
  width: 100%;
  display:flex;
  flex-direction: column;
  font-family: "Microsoft YaHei";
}

.top-menu {
  height: 60px;
  width: 100%;
  display: flex;
  flex-direction: row;
  align-items: center;
  background-color:rgb(226, 220, 226);
  flex-shrink:0;
}

.main{
  width: 100%;
  display: flex;
  flex-direction: row;
  flex: 1;
}

.left{
  width: 200px;
  height: 100%;
  box-shadow: 1px 0px 0px 0px rgba(207, 206, 206, 0.5);
}

.container{
  height: 100%;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.right{
  width: 200px;
  height: 100%;
  box-shadow: 0px 0px 2px 0px rgba(207, 206, 206, 0.5);
}

#ul{
  align-self: auto;
}

fieldset{
  width: 500px;
  display: flex;
  flex-direction: column;
}

#textarea{
  margin-left:50px;font-size: 12px;
  display: inline-block;
  box-sizing: border-box;
  background-color: #f4f5f7;
  border: 1px solid #e5e9ef;
  overflow: auto;
  border-radius: 4px;
  color: #555;
  padding: 5px 10px;
  line-height: normal;
}

#textarea:hover{
  background-color: white;
}

#div{
  margin-left:50px;
  margin-right:50px;
  display: flex;
  flex-direction: column;
}

#commentDiv{
  width: 100%;
  margin-top: 5px;
  display: flex;
  flex-direction: row
}

#oneImg{
  height: 100%;
  width: 60px;
}

#oneAndTwo{
  
  flex:1;
  display: flex;
  flex-direction: column;
}

#one{
  width: 100%;
  display: flex;
  flex-direction: column;
}

#oneHeader{
  width: 100%;
}

#oneContent{
  width: 100%;
}

#oneFooter{
  width: 100%;
  display: flex;
  flex-direction: row;
}

#oneTime{
  height: 100%;
  width: 150px;
}

#oneToolBar{

  margin-left: 680px;
}

#twoFooter{
  width: 100%;
  display: flex;
  flex-direction: row;
}

#twoTime{
  height: 100%;
  width: 150px;
}

#twoToolBar{

  margin-left: 630px;
}

#twoList{
  flex:1;
}

#two{
  width: 100%;
  display: flex;
  flex-direction: row;
}

#twoImg{
  height: 100%;
  width: 47px;
}

#twoComment{
  flex:1;
  display: flex;
  flex-direction: column;
}

#twoHeader{
  width: 100%;
}

#twoContent{
  width: 100%;
}

#twoFooter{
  width: 100%;
}
</style>