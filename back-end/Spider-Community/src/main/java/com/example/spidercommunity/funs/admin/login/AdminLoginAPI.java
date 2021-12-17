package com.example.spidercommunity.funs.admin.login;

import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.common.TokenUtils;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController // 说明这是一个受 spring 管理的对象，即 Bean 组件
@RequestMapping("/admin")
public class AdminLoginAPI {
    @Resource
    private AdminLoginService adminLoginService;


    @RequestMapping("/login")
    public Result AdminLogin(@RequestBody AdminLoginDto dto){
        String back = "";
        boolean withName = adminLoginService.checkLoginWithIdOrName(dto);
        if(withName) {
            back = adminLoginService.getAid(dto);
            dto.setA_id(back);
        }

        boolean ok = adminLoginService.checkLogin(dto);

        if(ok){
            // 生成登录令牌 token
            String token = TokenUtils.loginSign(dto.getA_id(), dto.getA_pwd());
            // 向客户端发送成功响应 并发送令牌
            return Result.success(back, (Object)token);
        }

        return Result.fail(Result.ERR_CODE_BUSINESS, "账号或密码错误！");
    }

    @RequestMapping("/getAname")
    public Result getAname(@RequestBody A_id a_id){
        String name=adminLoginService.getAname(a_id);
        return Result.success(name);
    }


}
