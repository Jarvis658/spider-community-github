package com.example.spidercommunity.funs.admin.label;

import com.example.spidercommunity.common.Result;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


@RestController // 说明这是一个受 spring 管理的对象，即 Bean 组件
@RequestMapping("/admin/label")
public class LabelAPI {
    @Resource
    private DeleteLableService  deleteLableService;

    @RequestMapping("/search")
    public Result LabelSearch(@RequestBody SearchLabelDto dto){
        String msg=dto.getMsg();
        ArrayList list = Split.split(msg);
        System.out.println(msg);
        String a="%" ;
        for (int i=0;i<list.size();i++) {
            a = a+list.get(i)+"%";
        }
        msg=a;

        List<String> result=deleteLableService.searchLabel(msg);

        return Result.success(result);
    }



    @RequestMapping("/delete")
    public Result LabelDelete(@RequestBody DeleteLabelDto dto){
        System.out.println(dto.getName());
        String result=deleteLableService.delete(dto);

        return Result.success(result);
    }

}
