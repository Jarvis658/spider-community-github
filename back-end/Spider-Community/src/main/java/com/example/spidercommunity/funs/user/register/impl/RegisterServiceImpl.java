package com.example.spidercommunity.funs.user.register.impl;

import com.example.spidercommunity.funs.user.register.RegisterDto;
import com.example.spidercommunity.funs.user.register.RegisterService;
import com.example.spidercommunity.funs.user.register.dao.RegisterDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service //说明这是一个收spring管理的业务类组件(Bean)
@Transactional //说明本类所有方法都是事务性的
public class RegisterServiceImpl implements RegisterService {

    @Resource
    private RegisterDao registerDao;


    @Override
    public boolean checkRepeat(RegisterDto dto) {
        int count = registerDao.checkRepeatUserName(dto);
        return count == 0;
    }

    @Override
    public boolean register(RegisterDto dto) {
        dto.setU_id(registerDao.getNewUid(dto) + 1);
        registerDao.CreateUser(dto);
        int count = registerDao.checkRegister(dto);
        return count == 1;
    }

    @Override
    public boolean checkExist(RegisterDto dto) {
        int count = registerDao.checkExistUserId(dto);
        return count == 0;
    }

    @Override
    public boolean checkBlankName(RegisterDto dto) {
        if(dto.getU_name().equals(""))
            return false;
        return true;
    }

    @Override
    public boolean checkBlankPwd(RegisterDto dto) {
        if (dto.getU_pwd().equals(""))
            return false;
        return true;
    }

    @Override
    public boolean checkBlankPhone(RegisterDto dto) {
        if (dto.getU_phone().equals(""))
            return false;
        return true;
    }

    @Override
    public boolean checkRepeatPhone(RegisterDto dto) {
        int count = registerDao.checkRepeatUserPhone(dto);
        return count == 0;
    }
}
