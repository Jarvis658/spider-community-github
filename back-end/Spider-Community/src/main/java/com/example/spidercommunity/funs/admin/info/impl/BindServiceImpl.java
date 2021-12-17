package com.example.spidercommunity.funs.admin.info.impl;

import com.example.spidercommunity.funs.admin.info.BindDto;
import com.example.spidercommunity.funs.admin.info.BindService;
import com.example.spidercommunity.funs.admin.info.UnBindDto;
import com.example.spidercommunity.funs.admin.info.dao.BindDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class BindServiceImpl implements BindService {
    @Resource
    private BindDao bindDao;

    @Override
    public String Bind(BindDto dto) {
        int cnt1=bindDao.BindCheck1(dto);
        int cnt2=bindDao.BindCheck2(dto);
        int cnt3=bindDao.BindCheck3(dto);
        if (cnt1>0) return "该用户账号已被绑定";
        if (cnt2==0)  return "用户账号或密码输入错误";
        if (cnt3>0) return "该管理员账号已绑定，请先接绑";
        bindDao.Bind(dto);
        return "绑定成功";
    }

    @Override
    public String UnBind(UnBindDto dto) {

        bindDao.UnBind(dto);
        return "解绑成功";
    }
}
