package com.example.spidercommunity.funs.admin.audit.impl;

import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.funs.admin.audit.Data;
import com.example.spidercommunity.funs.admin.audit.AuditDto;
import com.example.spidercommunity.funs.admin.audit.AuditService;
import com.example.spidercommunity.funs.admin.audit.dao.AuditDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service // 说明这是一个受 spring 管理的业务类组件(Bean)
@Transactional // 说明本类所有方法都是事务性的
public class AuditServiceImpl implements AuditService {

    @Resource
    private AuditDao auditDao;

//    @Override
//    public void setId(AuditDto dto) {
//        List<ZCJ> zcjList = new ArrayList<>();
//        zcjList.add(new ZCJ());
//        zcjList.addAll(auditDao.findCountByUserIdAndPassword(dto));
//    }

//    @Override
//    public void setStatus(AuditDto dto) {
//
//    }

    @Override
    public List<Data> getPost(AuditDto dto) {
        List<Data> posts = new ArrayList<>();
        posts.addAll(auditDao.loadAllPost(dto));
        return posts;
    }

    @Override
    public  List<Data> loadContent(AuditDto dto){
        List<Data> posts = new ArrayList<>();
        posts.addAll(auditDao.loadContent(dto));
        return posts;
    }

    @Override
    public void changeStatus(AuditDto dto)
    {
        //List<Data> posts =
//        int temp=auditDao.changeStatus(dto);
//        List<Data> lis = new ArrayList<>();
//        lis.addAll(auditDao.loadAllPost(dto));
//        auditDao.changeStatus(dto);
        List<Data> lis = new ArrayList<>();
        lis.addAll(auditDao.loadAllPost(dto));
        auditDao.changeStatus(dto);
    }

    @Override
    public List<Data> loadOwnPost(AuditDto dto) {
        List<Data> lis= new ArrayList<>();
        lis=auditDao.loadAllPost(dto);
        List<Data> lis_own=new ArrayList<>();
        for (int i=0;i<lis.size();i++)
        {
            if(lis.get(i).getUser_id().equals(dto.getUser_id()))
            {
                lis_own.add(lis.get(i));
            }
        }
        return lis_own;
    }
}
