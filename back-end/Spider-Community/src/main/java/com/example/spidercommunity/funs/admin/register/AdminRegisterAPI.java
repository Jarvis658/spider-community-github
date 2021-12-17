package com.example.spidercommunity.funs.admin.register;

import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController // 说明这是一个受 spring 管理的对象，即 Bean 组件
@RequestMapping("/admin/register")
public class AdminRegisterAPI {
    @Resource
    private RService rService;

    @RequestMapping("")
    public Result register(@RequestBody RDto dto){
        String result=rService.R(dto);
        return Result.success(result);
    }


}
