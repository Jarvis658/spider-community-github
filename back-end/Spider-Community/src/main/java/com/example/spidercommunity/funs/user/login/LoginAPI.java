package com.example.spidercommunity.funs.user.login;

import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.common.TokenUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;


@RestController // 说明这是一个受 spring 管理的对象，即 Bean 组件
@RequestMapping("/user/login")
public class LoginAPI {

    @Resource
    private LoginService loginService;

    @RequestMapping("")
    public Result login(@RequestBody LoginDto dto){
        String back = "";
        boolean withName = loginService.checkLoginWithIdOrName(dto);
        if(withName) {
            back = loginService.getUid(dto);
            dto.setU_id(back);
        } else back = dto.getU_id();

        boolean ok = loginService.checkLogin(dto);

        if(ok){
            // 生成登录令牌 token
            String token = TokenUtils.loginSign(dto.getU_id(), dto.getU_pwd());
            System.out.println(token);
            // 向客户端发送成功响应 并发送令牌
            return Result.success(back, token);
        }

        return Result.fail(Result.ERR_CODE_BUSINESS, "账号或密码错误！");
    }

    @RequestMapping("/checkPhone")
    public Result checkPhone(@RequestBody LoginDto dto){
        boolean phoneExist = loginService.checkPhoneExist(dto);
        if (phoneExist){
            int u_id = loginService.getUidByPhone(dto);
            return Result.success(u_id);
        }
        return Result.fail(Result.ERR_CODE_BUSINESS, "手机号未注册！");
    }

    @RequestMapping("/getUid")
    public Result getUidByPhone(@RequestBody LoginDto dto){
            int u_id = loginService.getUidByPhone(dto);
            return Result.success(u_id);
    }



}
