package com.example.spidercommunity.funs.user.login.impl;

import com.example.spidercommunity.funs.user.login.LoginDto;
import com.example.spidercommunity.funs.user.login.LoginService;
import com.example.spidercommunity.funs.user.login.dao.LoginDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service // 说明这是一个受 spring 管理的业务类组件(Bean)
@Transactional // 说明本类所有方法都是事务性的
public class LoginServiceImpl implements LoginService {

    @Resource
    private LoginDao loginDao;

    @Override
    public boolean checkLogin(LoginDto dto) {
        int count1 = loginDao.findCountByUserIdAndPassword(dto);
        int count2 = loginDao.findCountByUserNameAndPassword(dto);
        int cnt = count1 + count2;
        return cnt > 0;
    }

    @Override
    public String getUid(LoginDto dto) {
        String uid = loginDao.getUserIdByUidAndUpwd(dto);
        return uid;
    }

    @Override
    public boolean checkLoginWithIdOrName(LoginDto dto) {
        int count = loginDao.checkLoginWithName(dto);
        return count == 1;
    }

    @Override
    public boolean checkPhoneExist(LoginDto dto) {
        int count = loginDao.checkPhoneExist(dto);
        return count == 1;
    }

    @Override
    public int getUidByPhone(LoginDto dto) {
        return loginDao.getUserIdByPhone(dto);
    }


}
