package com.example.spidercommunity.funs.admin.info.impl;

import com.example.spidercommunity.funs.admin.info.Update_passwordDto;
import com.example.spidercommunity.funs.admin.info.Update_passwordService;
import com.example.spidercommunity.funs.admin.info.dao.Update_passwordDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import javax.annotation.Resource;

@Service
@Transactional
public class Update_passwordServiceImpl implements Update_passwordService {
    @Resource
    private Update_passwordDao update_passwordDao;

    @Override
    public String update_password(Update_passwordDto dto) {
        int count=update_passwordDao.findCountByAdminIDAndPassword(dto);
        if (count<1) return "原密码错误";
        else {
            update_passwordDao.updateAdminPwd(dto);
            return "修改成功，请重新登录";
        }
    }
}
