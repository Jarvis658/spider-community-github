package com.example.spidercommunity.funs.admin.info.impl;

import com.example.spidercommunity.funs.admin.info.UpdateInfoCDto;
import com.example.spidercommunity.funs.admin.info.UpdateInfoCService;
import com.example.spidercommunity.funs.admin.info.UpdateInfoDto;
import com.example.spidercommunity.funs.admin.info.dao.UpdateInfoCDao;
import com.example.spidercommunity.funs.admin.info.dao.UpdateInfoDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class UpdateInfoCServiceImpl implements UpdateInfoCService {
    @Resource
    private UpdateInfoCDao updateInfoCDao;


    @Override
    public String UpdateInfoC(UpdateInfoCDto dto) {
        updateInfoCDao.UpdateCInfo(dto);
        return ("修改成功");
    }
}
