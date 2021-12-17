package com.example.spidercommunity.funs.admin.audit;


import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.awt.dnd.DropTarget;
import java.util.ArrayList;
import java.util.List;
import java.lang.Object;

@RestController // 说明这是一个受 spring 管理的对象，即 Bean 组件
@RequestMapping("/admin/audit")
public class AuditAPI {

//    DBdata data=new DBdata();

    @Resource
    private AuditService auditService;

//    @RequestMapping("")
//    public Result loadList(@RequestBody AuditDto dto)//加载待审核文章列表
//    {
//
//    }

    @RequestMapping("/loadpost")
    public  Result loadPost(@RequestBody AuditDto dto)//加载待审核文章列表
    {
        List<Data> lis=auditService.getPost(dto);
        List<Data> lis_out=new ArrayList<>();
//        List<Data> lis = auditService.findUserPost(dto);
//        return Result.success(lis);
        for(int i=0;i<lis.size();i++)
        {
            if (lis.get(i).getAudit_status()==0)
            {
                lis_out.add(lis.get(i));
            }
        }
        return Result.success(lis_out);
    }

    @RequestMapping("/loadtitle")
    public Result loadtitle(@RequestBody AuditDto dto)
    {
        List<Data> lis=auditService.getPost(dto);
        int index=0;
        for(int i=0;i<lis.size();i++) //2021-12-10
        {
            if (dto.getPost_id().equals(lis.get(i).getPost_id())) {
                index = i;
                break;
            }
        }
        return Result.success(lis.get(index).getPost_title());
    }

    @RequestMapping("/loadcontent")
    public  Result loadContent(@RequestBody AuditDto dto)//加载待审核文章
    {
        List<Data> lis = auditService.loadContent(dto);
        int index=0;
        for(int i=0;i<lis.size();i++) //2021-12-10
        {
            if(dto.getPost_id().equals(lis.get(i).getPost_id()))
            {
                index=i;
                break;
            }
        }
        return Result.success(lis.get(index).getPost_content());
    }

    @RequestMapping("/setstatus")//修改审核状态
    public Result changeStatus(@RequestBody AuditDto dto)
    {
        try{
            auditService.changeStatus(dto);

        }catch(Exception e ) {
            return Result.fail(Result.ERR_CODE_SYS, "fail");
        }
        return Result.success("设置审核状态成功");
    }


    @RequestMapping("/loadownpost")
    public Result loadOwnPost(@RequestBody AuditDto dto)
    {
        System.out.println(dto.getUser_id());
        List<Data> lis=new ArrayList<>();
//        List<Data> lis = auditService.findUserPost(dto);
//        return Result.success(lis);
        lis=auditService.loadOwnPost(dto);
        return Result.success(lis);
    }

}
