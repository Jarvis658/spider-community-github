package com.example.spidercommunity.funs.admin.register.impl;

import com.example.spidercommunity.funs.admin.register.RDto;
import com.example.spidercommunity.funs.admin.register.RService;
import com.example.spidercommunity.funs.admin.register.dao.RDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service // 说明这是一个受 spring 管理的业务类组件(Bean)
@Transactional // 说明本类所有方法都是事务性的
public class RImpl implements RService {
    @Resource
    private RDao rDao;

    @Override
    public String R(RDto dto) {
        if (rDao.checkThree(dto)>0)return  "该工人已注册过账号";
        if (rDao.checkOne(dto)<1) return "工号或姓名错误";
        if (dto.getA_id()<0||dto.getA_id()>300) return "请输入0~300的id";
        if (rDao.checkTwo(dto)>0) return "该账号已被使用";
        if (!dto.getA_pwd().equals(dto.getA_pwd2())) return "两次密码不一样";
        rDao.R(dto);

        return "注册成功";
    }
}
