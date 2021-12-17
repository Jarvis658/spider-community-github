package com.example.spidercommunity.funs.admin.users;


import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/admin/users/search")
public class AdminUserSearchAPI {
    @Resource
    private AUSearchService searchService;

    @RequestMapping("")
    public Result adminUserSearch(@RequestBody AUSearchDto dto){
        if (dto.getKey().equals("1")){
            System.out.println(dto.getKey());
            return Result.success(searchService.searchPost(dto));
        }else {
            ArrayList list = Split.split(dto.getMsg());
            String a="%" ;
            for (int i=0;i<list.size();i++) {
                a = a+list.get(i)+"%";
            }
            dto.setMsg(a);
            List<AUSearchResult> postList = searchService.searchPost(dto);
            return Result.success(postList);
        }

    }



}
