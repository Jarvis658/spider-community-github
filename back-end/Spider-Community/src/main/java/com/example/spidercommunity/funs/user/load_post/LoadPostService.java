package com.example.spidercommunity.funs.user.load_post;

import java.util.ArrayList;
import java.util.List;

public interface LoadPostService {
    PostAndUname getUserPost(LoadPostDto loadPostDto);

    List<ArrayList> getCommentList(LoadPostDto loadPostDto);

    CommentAndUname getCommentById(LoadPostDto dto);

    int checkAuthorRole(LoadPostDto dto);

    PostAndUname getAdminPost(LoadPostDto dto);

    String getUserIdByPostId(String post_id);
}
