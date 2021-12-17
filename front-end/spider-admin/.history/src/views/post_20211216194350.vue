<template>
  <div class="home">
    <h3>标题</h3>
    <div style="height: 80px"><input ref="titleInput" id="titleInputId" /></div>

    <h3>内容</h3>
    <div id="demo1"></div>
    <button @click="handleSubmit">发帖</button>

    <!-- <button type="button" class="btn" @click="getEditorData">
      获取当前内容
    </button>
    <h3>内容预览</h3>
    <textarea
      name=""
      id=""
      cols="170"
      rows="20"
      readonly
      v-model="editorData"
    ></textarea> -->
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
      imgupload: "",
    };
  },

  mounted() {
    const editor = new wangEditor(`#demo1`); //绑定到id=demo1上
    var that = this;
    //先配置再创建！！！
    // 配置 onchange 回调函数，将数据同步到 vue 中
    editor.config.onchange = (newHtml) => {
      this.editorData = newHtml;
    };
    editor.config.height = 300;// 设置编辑区域高度为 500px
    editor.config.customUploadImg = function (resultFiles, insertImgFn) {
      // resultFiles 是 input 中选中的文件列表
      // insertImgFn 是获取图片 url 后，插入到编辑器的方法

      // 图片压缩
      let reader = new FileReader(),
        img = new Image();
      reader.readAsDataURL(resultFiles[0]);
      //reader读完之后执行onload
      reader.onload = function (e) {
        img.src = e.target.result;
      };
      //img加载完成之后
      img.onload = function () {
        let canvas = document.createElement("canvas");
        let context = canvas.getContext("2d");

        let imgAfter;
        var imgUrl;
        var imgForm = new FormData();
        imgForm.append("token", that.uploadToken);
        imgForm.append(
          "fileKey",
          "admin/" + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1
        );
        if (img.width <= 350) {
          imgAfter = resultFiles[0];
          imgForm.append("image", imgAfter);
          //将图片发给后端，在后端上传至七牛云
          post("/upload/toQiniu", imgForm).then((res) => {
            console.log(res);
            imgUrl = res.message;
            console.log(imgUrl);
            // 上传图片，返回结果，将图片插入到编辑器中
            insertImgFn(imgUrl);
          });
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
              imgAfter = new File([blob], resultFiles[0].name, {
                type: resultFiles[0].type,
              }); // 将blob对象转化为图片文件
              console.log("压缩后的图片尺寸" + imgAfter.size);

              //将图片发给后端，在后端上传至七牛云
              imgForm.append("image", imgAfter);
              post("/upload/toQiniu", imgForm).then((res) => {
                console.log(res);
                imgUrl = res.message;
                console.log(imgUrl);
                // 将图片插入到编辑器中
                insertImgFn(imgUrl);
              });
            },
            resultFiles[0].type,
            1
          ); // file压缩的图片类型
        }
      };

      // var imgForm = new FormData()
      //   imgForm.append("token",that.imgData.token)
      //   imgForm.append("fileKey","admin/"+Math.floor(Math.random() * (999999 - 100000) + 100000) +1)
      //   imgForm.append("image",resultFiles[0])
      //   post("/user/post/toQiniu", imgForm).then((res) => {
      //   console.log(res);
      //   imgUrl = res.message;
      //   console.log(imgUrl)
      // });
      //   // 上传图片，返回结果，将图片插入到编辑器中
      //   insertImgFn(imgUrl)
    };
    editor.config.showLinkImg = false//隐藏网络图片上传

    // 创建编辑器
    editor.create();
    this.editor = editor;

    get("/upload/token/get", {}).then((res) => {
      console.log(res);
      this.uploadToken = res.message;
      console.log(this.uploadToken);
    }); //获得上传至七牛云的token
  },

  methods: {
    handleSubmit() {
      let title = document.getElementById("titleInputId").value;
      let content = this.editor.txt.html();
      let adminId = this.$route.query.userId;
      let json = {
        post_title: title,
        post_content: content,
        user_id: adminId,
        cover_url: "",
      };
      console.log(json);
      post("/admin/post/publish", json).then((res) => {
        if (res.code === 200)
          //帖子没有图片
          tip.success("发帖成功！");
        else tip.fail(res.message);
        router.push
      });
    },
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