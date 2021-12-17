package com.example.spidercommunity.funs.admin.info;


import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/info")
public class BindAPI {
    @Resource
    private BindService bindService;

    @RequestMapping("/bind")
    public Result Bind(@RequestBody BindDto dto) {


        String result = bindService.Bind(dto);
        return Result.success(result);
    }
    @RequestMapping("/unbind")
    public Result UnBind(@RequestBody UnBindDto dto) {


        String result = bindService.UnBind(dto);
        return Result.success(result);
    }
}



