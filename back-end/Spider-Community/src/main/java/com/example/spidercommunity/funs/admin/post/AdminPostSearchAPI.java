package com.example.spidercommunity.funs.admin.post;


import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/admin/post/search")
public class AdminPostSearchAPI {
    @Resource
    private APSearchService apSearchService;

    @RequestMapping("")
    public Result adminPostSearch(@RequestBody APSearchDto dto){
        if (dto.getKey().equals("3")||dto.getKey().equals("4")){
            List<APSearchResult> postList = apSearchService.searchPost(dto);
            return Result.success(postList);
        }

        ArrayList list = Split.split(dto.getMsg());
        String a="%" ;
        for (int i=0;i<list.size();i++) {
            a = a+list.get(i)+"%";
        }
        dto.setMsg(a);
        List<APSearchResult> postList = apSearchService.searchPost(dto);
        return Result.success(postList);
    }


}
