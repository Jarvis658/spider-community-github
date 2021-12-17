package com.example.spidercommunity.funs.user.login;

public interface LoginService {
    boolean checkLogin(LoginDto dto);

    String getUid(LoginDto dto);

    boolean checkLoginWithIdOrName(LoginDto dto);

    boolean checkPhoneExist(LoginDto dto);

    int getUidByPhone(LoginDto dto);
}
