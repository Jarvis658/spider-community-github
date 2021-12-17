package com.example.spidercommunity.funs.admin.info;


import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

import java.util.Objects;

@RestController
@RequestMapping("/admin/info/update_password")
public class Update_passwordAPI {
    @Resource
    private Update_passwordService update_passwordService;

    @RequestMapping("")
    public Result Update_password(@RequestBody Update_passwordDto dto){
        if (!Objects.equals(dto.getNewP(), dto.getNewPre()))return Result.fail(500,"重复的密码不一致");
        String result= update_passwordService.update_password(dto);
        return Result.success(result);
    }
}
