<template>
  <div class="home">
     <h3>标题</h3>
    <div style="height: 80px"><input ref="titleInput" id="titleInputId"/></div>
    
    <h3>内容</h3>
    <div id="demo1"></div>
    <button type="button" class="btn" @click="getEditorData">获取当前内容</button>
    <h3>内容预览</h3>
    <textarea name="" id="" cols="170" rows="20" readonly v-model="editorData"></textarea>
    
  </div>
</template>


<script>

// 引入 wangEditor
import { useRouter, useRoute } from "vue-router";
import { reactive, ref } from "vue";
import { get, post, setLocalToken, tip } from "@/common";
import { removeLocalToken } from "@/common/token.js";
import wangEditor from "wangeditor";


export default {
  data() {
    return {
      uploadToken: "",
      imageUrl: "",
      editor: null,
      editorData: "",
      ii: "ui",
      imgData: {
              'token': '',
              'fileKey': "admin/"+Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1//每次调用都会重新计算
      }
    }
  },
  
  beforeUpload(file) {
    
    return new Promise((resolve) => {
     
  },
  handleCoverChange(file) {
    if (file.status === "done") {
      const imageKey = file.response.key;
      const uploadUrl = "http://r31xm6gn5.hd-bkt.clouddn.com/" + imageKey;
      console.log(uploadUrl);

      this.imgData.fileKey=Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1;
      // //将图片插入编辑器
      // this.editor.cmd.do('insertHTML','<span>'+value+'</span>')
    }
  },
  mounted() {
    const editor = new wangEditor(`#demo1`); //绑定到id=demo1上

    //先配置再创建！！！
    // 配置 onchange 回调函数，将数据同步到 vue 中
    editor.config.onchange = (newHtml) => {
      this.editorData = newHtml;
    };
    // 设置编辑区域高度为 500px
    editor.config.height = 300;
    editor.config.customUploadImg = function (resultFiles, insertImgFn) {
      // resultFiles 是 input 中选中的文件列表
      // insertImgFn 是获取图片 url 后，插入到编辑器的方法
      console.log(resultFiles[0])
      let img = new FormData()
      let imgUrl = ''
      img.append("image",resultFiles[0])
      post("/user/post/image", img).then((res) => {
      console.log(res);
      imgUrl = res.message;
      console.log(imgUrl)
    });
      // 上传图片，返回结果，将图片插入到编辑器中
      insertImgFn(imgUrl)
    }

    // 创建编辑器
    editor.create();
    this.editor = editor;

    get("/upload/token/get", {}).then((res) => {
      console.log(res);
      this.imgData.token = res.message;
      console.log(this.imgData)
    }); //获得上传至七牛云的token
  },

  methods: {
    getEditorData() {
      // 通过代码获取编辑器内容
      let data = this.editor.txt.html(); //直接生成html
      alert(data);
    },
  },
  beforeDestroy() {
    // 调用销毁 API 对当前编辑器实例进行销毁
    this.editor.destroy();
    this.editor = null;
  },

};
</script>

<style>
.home {
  width: 1200px;
  margin: auto;
  position: relative;
}

#titleInputId {
  border-radius: 20px;
  outline: none;
  width: 50%;
  height: 40px;
  border: none;
  border: 0.5px solid #bebebe;
  padding-left: 20px;
}
</style>