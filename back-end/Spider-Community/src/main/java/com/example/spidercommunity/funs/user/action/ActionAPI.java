package com.example.spidercommunity.funs.user.action;

import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/user/action")
public class ActionAPI {

    @Resource
    private ActionService actionService;

    @RequestMapping("/view")
    public Result recordView(@RequestBody ActionDto dto){
        actionService.addViewRecord(dto);
        return Result.success("view record refreshed");
    }



}
