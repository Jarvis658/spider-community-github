package com.example.spidercommunity.funs.admin.info;

import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/info/update_current")
public class UpdateInfoAPI {
    @Resource
    private UpdateInfoService updateInfoService;

    @RequestMapping("")
    public Result UpdateAdminInfo(@RequestBody UpdateInfoDto dto){

        String result= updateInfoService.UpdateInfo(dto);
        return Result.success(result);
    }




}
