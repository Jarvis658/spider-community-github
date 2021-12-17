package com.example.spidercommunity.common;

import com.example.spidercommunity.common.Result;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

@RestController
@CrossOrigin
@RequestMapping("/upload")
public class ImageUploadController {
    private String accessKey = "3fInxNVfz6AcC2Nl1ElJqORBr9WcIb8JupJeW_Bo";

    private String secretKey = "L_WVatWmpboiZVFEz9Un4gjpPhnWg3Lm8zw-k-ET";

    private String bucket = "spider-community";

    @RequestMapping("/token/get")
    public Result getToken() {

        // 调用七牛云的接口获取token
        Auth auth = Auth.create(accessKey,secretKey);
        String upToken = auth.uploadToken(bucket);

        return Result.success(upToken);
    }


    //后端将图片上传至七牛云
    @RequestMapping(value = "/toQiniu",method = RequestMethod.POST)
    public Result uploadQiNiu(@RequestParam("image") MultipartFile myFileName,@RequestParam("token") String  token,@RequestParam("fileKey") String fileKey) throws Exception{

        InputStream stream = myFileName.getInputStream();
        //构造一个带指定Zone对象的配置类
        Configuration cfg = new Configuration(Zone.zone0());
        //...其他参数参考类注释
        UploadManager uploadManager = new UploadManager(cfg);
        Response response = uploadManager.put(stream,fileKey ,token,null, null);
//        //解析上传成功的结果
//        DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
        //图片路径
        String url = "http://r31xm6gn5.hd-bkt.clouddn.com/"+fileKey;
        System.out.println(url);
        return Result.success(url);
    }
}
