package com.example.spidercommunity.funs.user.info.impl;

import com.example.spidercommunity.funs.user.info.User;
import com.example.spidercommunity.funs.user.info.UserInfoDto;
import com.example.spidercommunity.funs.user.info.UserInfoService;
import com.example.spidercommunity.funs.user.info.dao.UserInfoDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class UserInfoServiceImpl implements UserInfoService {
    @Resource
    private UserInfoDao userInfoDao;

    @Override
    public User getUserInfo(UserInfoDto userInfoDto) {
        User userInfo = userInfoDao.getUserInfo(userInfoDto);
        return userInfo;
    }

    public void updateUserInfo(User user) {
        userInfoDao.updateUserInfo(user);
    }

    @Override
    public void updateUserInfoPwd(User user) {
        userInfoDao.updateUserInfoPwd(user);
    }
}
