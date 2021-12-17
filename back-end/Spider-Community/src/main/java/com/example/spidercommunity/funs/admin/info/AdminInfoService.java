package com.example.spidercommunity.funs.admin.info;

import com.example.spidercommunity.funs.user.load_post.PostAndUname;

public interface AdminInfoService {
    Admin getCurrentInfo(AdminInfoDto adminInfoDto);

    boolean checkBind(AdminInfoDto adminInfoDto);

    String getUserId(AdminInfoDto adminInfoDto);

    void updateAvatar(String avatarUrl,String admin_id);

    void updateAvatar_C(String avatarUrl, String user_id);
}
