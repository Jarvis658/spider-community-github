package com.example.spidercommunity.funs.admin.login.impl;

import com.example.spidercommunity.funs.admin.login.A_id;
import com.example.spidercommunity.funs.admin.login.AdminLoginDto;
import com.example.spidercommunity.funs.admin.login.AdminLoginService;
import com.example.spidercommunity.funs.admin.login.dao.AdminLoginDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service // 说明这是一个受 spring 管理的业务类组件(Bean)
@Transactional // 说明本类所有方法都是事务性的
public class AdminLoginServiceImpl implements AdminLoginService {

    @Resource
    private AdminLoginDao adminLoginDao;

    @Override
    public boolean checkLogin(AdminLoginDto dto) {
        int count1 = adminLoginDao.findCountByUserIdAndPassword(dto);
        int count2 = adminLoginDao.findCountByUserNameAndPassword(dto);
        int cnt = count1 + count2;
        return cnt > 0;
    }

    @Override
    public String getAid(AdminLoginDto dto) {
        String aid = adminLoginDao.getAdminIdByAnameAndApwd(dto);
        return aid;
    }

    @Override
    public String getAname(A_id a_id) {
        return adminLoginDao.getAdminName(a_id);
    }

    @Override
    public boolean checkLoginWithIdOrName(AdminLoginDto dto) {
        int count = adminLoginDao.checkLoginWithName(dto);
        return count == 1;
    }


}
