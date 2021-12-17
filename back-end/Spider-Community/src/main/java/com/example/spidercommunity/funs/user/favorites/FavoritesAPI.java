package com.example.spidercommunity.funs.user.favorites;

import com.example.spidercommunity.common.Result;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/user/favorites")
public class FavoritesAPI {

    @Resource
    private CollectGroupService collectGroupService;

    @RequestMapping("/view_list")
    public Result getCollectGroup(@RequestBody CollectGroupDto collectGroupDto){
       List<CollectGroup> collectGroup = collectGroupService.getCollectGroup(collectGroupDto);
        return Result.success(collectGroup);
    }

    @RequestMapping("/view_other_list")
    public Result getOtherCollectGroup(@RequestBody CollectGroupDto collectGroupDto){
        List<CollectGroup> collectGroup = collectGroupService.getOtherCollectGroup(collectGroupDto);
        System.out.println(collectGroup);
        return Result.success(collectGroup);
    }

    @RequestMapping("/create_folder")
    public Result addCollectGroup(@RequestBody CollectGroupDto collectGroupDto){
        collectGroupService.addCollectGroup(collectGroupDto);
        return Result.success();
    }
    @RequestMapping("/delete_folder")
    public Result deleteCollectGroup(@RequestBody CollectGroupDto collectGroupDto){
         collectGroupService.deleteCollectGroup(collectGroupDto);
        return Result.success();
    }
    @RequestMapping("/edit_folder")
    public Result updateCollectGroup(@RequestBody CollectGroupDto collectGroupDto){
        collectGroupService.updateCollectGroup(collectGroupDto);
        return Result.success();
    }
    @RequestMapping("/view_content")
    public Result getCollectGroupContent(@RequestBody CollectGroupDto collectGroupDto){
        List<Post> collect =collectGroupService.getCollectGroupContent(collectGroupDto);
        return Result.success(collect);
    }
    @RequestMapping("/delete_post")
    public Result deleteCollectGroupLike(@RequestBody CollectDto collectDto){
        collectGroupService.deleteCollectGroupLike(collectDto);
        return Result.success();
    }
}
