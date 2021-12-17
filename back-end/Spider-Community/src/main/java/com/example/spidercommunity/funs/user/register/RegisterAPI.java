package com.example.spidercommunity.funs.user.register;

import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.common.TokenUtils;
import org.apache.ibatis.mapping.ResultFlag;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController //说明这是一个收spring管理的控制器组件(Bean)
@RequestMapping("/user/register") //本控制器的路径
public class RegisterAPI {

    //引入依赖对象 接口不是实现类，但仍要将他放在容器中
    @Resource
    private RegisterService registerService;


    @RequestMapping("")
    public Result register(@RequestBody RegisterDto dto) {
        boolean ok = registerService.register(dto);
        if (ok) {
            String token = TokenUtils.loginSign(dto.getU_id()+"", dto.getU_pwd());
            return Result.success(dto.getU_id()+"", token);
        }
        return Result.fail(Result.ERR_CODE_SYS, "注册失败！系统升级中...！");

    }

    @RequestMapping("/check")
    public Result check(@RequestBody RegisterDto dto) {

        boolean notBlankName = registerService.checkBlankName(dto);

        if (notBlankName) {
            boolean NoRepeatName = registerService.checkRepeat(dto); //检查用户名是否已被占用

            if (NoRepeatName) {
                boolean notBlankPwd = registerService.checkBlankPwd(dto);

                if (notBlankPwd){
                    boolean notBlankPhone = registerService.checkBlankPhone(dto);

                    if (notBlankPhone){
                        boolean noRepeatPhone = registerService.checkRepeatPhone(dto);

                        if (noRepeatPhone){
                            return Result.success("输入符合要求");
                        }
                        return Result.fail(Result.ERR_CODE_BUSINESS, "该手机号已被用于注册！");
                    }
                    return Result.fail(Result.ERR_CODE_BUSINESS, "请输入手机号并进行验证！");
                }
                return Result.fail(Result.ERR_CODE_BUSINESS, "密码不能为空！");
            }
            return Result.fail(Result.ERR_CODE_BUSINESS, "用户名已被占用！");
        }
        return Result.fail(Result.ERR_CODE_BUSINESS, "用户名不能为空！");

    }

}
