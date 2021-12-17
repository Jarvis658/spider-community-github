package com.example.spidercommunity.funs.user.info;

import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.funs.admin.info.Admin;
import com.example.spidercommunity.funs.admin.info.AdminInfoDto;
import com.example.spidercommunity.funs.admin.info.AdminInfoService;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;


@RestController
@RequestMapping("/user/info")
public class UserInfoAPI {
    @Resource
    private UserInfoService userInfoService;


    @RequestMapping("/view")
    public Result getUserInfo(@RequestBody UserInfoDto userInfoDto){
        User user = userInfoService.getUserInfo(userInfoDto);
        return Result.success(user);
    }

    @RequestMapping("/update")
    public Result updateUserInfo(@RequestBody User user){
        userInfoService.updateUserInfo(user);

        return Result.success();
    }
    @RequestMapping("/update_password")
    public Result updateUserInfoPwd(@RequestBody User user){
        userInfoService.updateUserInfoPwd(user);
        return Result.success();
    }


}
