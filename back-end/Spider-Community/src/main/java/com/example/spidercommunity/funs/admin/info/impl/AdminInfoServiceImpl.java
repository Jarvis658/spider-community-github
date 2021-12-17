package com.example.spidercommunity.funs.admin.info.impl;

import com.example.spidercommunity.funs.admin.info.Admin;
import com.example.spidercommunity.funs.admin.info.AdminInfoDto;
import com.example.spidercommunity.funs.admin.info.AdminInfoService;
import com.example.spidercommunity.funs.admin.info.dao.AdminInfoDao;
import com.example.spidercommunity.funs.user.load_post.PostAndUname;
import com.example.spidercommunity.funs.user.load_post.dao.LoadPostDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class AdminInfoServiceImpl implements AdminInfoService {

    @Resource
    private AdminInfoDao adminInfoDao;

    @Override
    public Admin getCurrentInfo(AdminInfoDto adminInfoDto) {
        Admin admin = adminInfoDao.getCurrentInfo(adminInfoDto);
        return admin;
    }

    @Override
    public boolean checkBind(AdminInfoDto adminInfoDto) {
        int num = adminInfoDao.checkBind(adminInfoDto);
        if(num > 0)
            return true;
        else
            return false;
    }

    @Override
    public String getUserId(AdminInfoDto adminInfoDto) {
        AdminInfoDto dto = adminInfoDao.getUserId(adminInfoDto);
        return dto.getUid();
    }

    @Override
    public void updateAvatar(String avatarUrl, String admin_id) {
        adminInfoDao.updateAvatar(avatarUrl,admin_id);
    }

    @Override
    public void updateAvatar_C(String avatarUrl, String user_id) {
        adminInfoDao.updateAvatar_C(avatarUrl,user_id);
    }

}
