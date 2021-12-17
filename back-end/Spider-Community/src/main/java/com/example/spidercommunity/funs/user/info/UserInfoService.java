package com.example.spidercommunity.funs.user.info;

public interface UserInfoService {

    User getUserInfo(UserInfoDto userInfoDto);

    void updateUserInfo(User user);

    void updateUserInfoPwd(User user);
}
