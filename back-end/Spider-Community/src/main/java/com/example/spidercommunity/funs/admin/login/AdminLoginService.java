package com.example.spidercommunity.funs.admin.login;

import com.example.spidercommunity.funs.user.login.LoginDto;

public interface AdminLoginService {
    boolean checkLogin(AdminLoginDto Dto);

    String getAid(AdminLoginDto Dto);
    String getAname(A_id a_id);
    boolean checkLoginWithIdOrName(AdminLoginDto Dto);
}
