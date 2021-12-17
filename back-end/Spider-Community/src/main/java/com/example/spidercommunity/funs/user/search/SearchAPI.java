package com.example.spidercommunity.funs.user.search;


import com.example.spidercommunity.common.Result;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/user/search")
public class SearchAPI {
    @Resource
    private SearchService searchService;

    @RequestMapping("")
    public Result search(@RequestBody SearchDto dto){
        ArrayList list = Split.split(dto.getMsg());
        String a="%" ;
        for (int i=0;i<list.size();i++) {
            a = a+list.get(i)+"%";
        }
        dto.setMsg(a);
        List<SearchResult> postList = searchService.searchPost(dto);
        return Result.success(postList);
    }
}
