package com.example.spidercommunity.funs.admin.info;

import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/info/update_c")
public class UpdateInfoCAPI {
    @Resource
    private UpdateInfoCService updateInfoCService;

    @RequestMapping("")
    public Result UpdateCInfo(@RequestBody UpdateInfoCDto dto){

        String result= updateInfoCService.UpdateInfoC(dto);
        return Result.success(result);
    }




}