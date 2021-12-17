package com.example.spidercommunity.funs.user.register;

public interface RegisterService {

    boolean checkRepeat(RegisterDto dto);

    boolean register(RegisterDto dto);

    boolean checkExist(RegisterDto dto);

    boolean checkBlankName(RegisterDto dto);

    boolean checkBlankPwd(RegisterDto dto);

    boolean checkBlankPhone(RegisterDto dto);

    boolean checkRepeatPhone(RegisterDto dto);
}