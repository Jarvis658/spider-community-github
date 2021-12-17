<template>
  <div class="home">
     <h3>标题</h3>
    <div style="height: 80px"><input ref="titleInput" id="titleInputId"/></div>
    
    <h3>内容</h3>
    <div id="demo1"></div>
    <button type="button" class="btn" @click="getEditorData">获取当前内容</button>
    <h3>内容预览</h3>
    <textarea name="" id="" cols="170" rows="20" readonly v-model="editorData"></textarea>

<!-- :show-upload-list="false" -->
     <a-upload
      name="avatar"
      list-type="picture-card"
      class="avatar-uploader"
      action='http://upload.qiniu.com'
      :data= "imgData"
      :before-upload="beforeUpload"
      @change="handleCoverChange"
      
    >
    <img v-if="imageUrl" :src="imageUrl" alt="avatar" />
    <div v-else>
      <a-icon :type="loading ? 'loading' : 'plus'" />
      <div class="ant-upload-text">
        Upload
      </div>
    </div>
     <div>{{ii}}</div>
    
  </a-upload>
  
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
      ii : "ui",
      imgData:{
              'token': '',
              'fileKey': ''
      }
  },
  
  beforeUpload(file) {
    return new Promise((resolve) => {
      // 图片压缩
      let reader = new FileReader(),
        img = new Image();
      reader.readAsDataURL(file);
      let imgFile = null;
      //reader读完之后执行onload
      reader.onload = function (e) {
        img.src = e.target.result;
      };
      //img加载完成之后
      img.onload = function () {
        let canvas = document.createElement("canvas");
        let context = canvas.getContext("2d");

        if (img.width <= 350) {
          resolve(file);
        } else {
          //若上传图片宽度超过屏幕宽度
          console.log("图片尺寸" + this.width + "," + this.height);
          let originWidth = 350;
          let originHeight = (350 / this.width) * this.height; //等比例缩放高度

          //将图片利用canvas.drawImage进行绘制
          canvas.width = originWidth;
          canvas.height = originHeight;
          context.clearRect(0, 0, originWidth, originHeight);
          context.drawImage(img, 0, 0, originWidth, originHeight);

          //绘制后调用toBlob方法转化为blob对象并压缩，最后通过new File()将blob对象转化为文件对象并上传
          canvas.toBlob(
            (blob) => {
              //此处的blob就是压缩后的blob对象
              imgFile = new File([blob], file.name, { type: file.type }); // 将blob对象转化为图片文件
              console.log("压缩后的图片尺寸" + imgFile.size);
              resolve(imgFile);
            },file.type,1
          ); // file压缩的图片类型
        }
      };
    });
  },
  handleCoverChange(file) {
    if (file.status === "done") {
      const imageKey = file.response.key;
      const uploadUrl = "http://r31xm6gn5.hd-bkt.clouddn.com/" + imageKey;
      console.log(uploadUrl);

      // //将图片插入编辑器
      // this.editor.cmd.do('insertHTML','<span>'+value+'</span>')
    }
  },
  getImgData(){
    console.log(imgData);
    return imgData;
  },
  mounted() {
    const editor = new wangEditor(`#demo1`); //绑定到id=demo1上
    // 配置 onchange 回调函数，将数据同步到 vue 中
    editor.config.onchange = (newHtml) => {
      this.editorData = newHtml;
    };

    // 设置编辑区域高度为 500px
    editor.config.height = 300;

    // 注意，先配置 height ，再执行 create()
    // 创建编辑器
    editor.create();
    this.editor = editor;

    get("/upload/token/get", {}).then((res) => {
      console.log(res);
      imgData.token = res.message;
      console.log(imgData)
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