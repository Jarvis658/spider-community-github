package com.example.spidercommunity.funs.admin.info.impl;


import com.example.spidercommunity.funs.admin.info.UpdateInfoDto;
import com.example.spidercommunity.funs.admin.info.UpdateInfoService;
import com.example.spidercommunity.funs.admin.info.dao.UpdateInfoDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class UpdateInfoServiceImpl implements UpdateInfoService {
    @Resource
    private UpdateInfoDao updateInfoDao;


    @Override
    public String UpdateInfo(UpdateInfoDto dto) {
        updateInfoDao.UpdateAdminInfo(dto);
        return ("修改成功");
    }

}
