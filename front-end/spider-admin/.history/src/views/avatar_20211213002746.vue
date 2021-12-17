<template>
     <a-upload
      name="file"
      action='http://upload.qiniu.com'
      :data= "imgData"
      :before-upload="beforeUpload"
      @change="handleCoverChange"
      showUploadList="false"
    >
     <a-button ref="uploadImg" > <a-icon type="upload" /> upload </a-button>
     <div>{{imgData}}</div>
  </a-upload>
</template>

<script>
export default {
    data() {
    return {
      uploadToken: "",
      imgData: {
              'token': '',
              'fileKey': Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1//每次调用都会重新计算
      }
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

      this.imgData.fileKey=Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1;
      // //将图片插入编辑器
      // this.editor.cmd.do('insertHTML','<span>'+value+'</span>')
    }
  },
}
</script>