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