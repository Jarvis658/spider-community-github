<template>
  <div>
    <div>
      <div style="margin-bottom: 16px; margin-top: 10px; margin-left: 10px">
        <img :src="current.avatar" style="width: 40px; height: 40px; border-radius: 20px">
         <a-button @click="uploadAvatar">修改头像</a-button>
          <input type="file" ref="avatarRef" v-show="false" @change="handleFile" />
      </div>
    
      <div style="margin-bottom: 16px">
        <button>昵称</button>
        <input v-model="current.name">
      </div>
      <div style="margin-bottom: 16px">
        <button>性别</button>
        <input v-model="current.sex">
      </div>
      <div style="margin-bottom: 16px">
        <button>生日</button>
        <input v-model="current.birthday2" disabled>
      </div>

      <div style="margin-bottom: 16px">
        <button disabled>年份</button>
        <input v-model="b.y">
        <button disabled>月份</button>
        <input v-model="b.m">
        <button disabled>日期</button>
        <input v-model="b.d">
      </div>
      <div>
        <button @click="change">修改</button>
      </div>
    </div>
  </div>
</template>


<script>
import { reactive, ref, defineComponent , defineComponent,  onMount} from "vue";
import { post, tip } from "@/common";
import { DownOutlined } from "@ant-design/icons-vue";
import { useRouter, useRoute } from "vue-router";
import { removeLocalToken } from "@/common/token.js";
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

};
const router = useRouter();
const route = useRoute();
const b = reactive({
  y: "",
  m: "",
  d: ""
});

const current = reactive({
  name: "",
  avatar: "",
  sex: "",
  birthday: "",
  birthday2: ""
});
var c = ref();
var birthday1 = ref();
var loadcurr = function(userId) {
  console.log("curr", current);
};
var avatarFile = null;
const that = this;
const uploadAvatar = function(){
  this.$refs.avatarRef.click();
}

const handleFile = function() {
    avatarFile = document.getElementById("avatarRef").files[0];
    let avatarForm = new FormData();
    avatarForm.append("avatar", this.avatarFile);
    avatarForm.append("admin_id", route.query.userId);
    post("admin/info/update_avatar", avatarForm).then((res) => {
      alert(res.message);
    });
}

const change = function() {
  var n = b.y + "-" + b.m + "-" + b.d;
  // console.log("!!",current.name);
  if (n != null) {
    post("/admin/info/update_current", {
      name: current.name,
      sex: current.sex,
      avatar: current.avatar,
      birthday: n,
      id: route.query.userId
    });
  } else {
    post("/admin/info/update_current", {
      name: current.name,
      sex: current.sex,
      avatar: current.avatar,
      birthday: current.birthday,
      id: route.query.userId
    });
  }
};

post("/admin/info/view_current", { uid: route.query.userId }).then(res => {
  current.name = res.data.admin_name;
  current.sex = res.data.admin_sex;
  current.birthday = res.data.admin_birthday;
  current.birthday2 = res.data.admin_birthday;
  current.avatar = res.data.admin_avatar;
  console.log(current);
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
