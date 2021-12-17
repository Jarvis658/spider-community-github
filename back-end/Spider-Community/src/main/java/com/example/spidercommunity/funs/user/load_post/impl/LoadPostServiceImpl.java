package com.example.spidercommunity.funs.user.load_post.impl;

import com.example.spidercommunity.funs.user.load_post.dao.LoadPostDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.spidercommunity.funs.user.load_post.*;

import javax.annotation.Resource;
import java.util.*;


@Service
@Transactional
public class LoadPostServiceImpl implements LoadPostService {

    @Resource
    private LoadPostDao LoadPostDao;

    @Override
    public PostAndUname getUserPost(LoadPostDto loadPostDto) {
        PostAndUname postAndUname = LoadPostDao.findUserPost(loadPostDto);
        int like_status = LoadPostDao.checkPostLike(loadPostDto);
        int collect_status = LoadPostDao.checkCollect(loadPostDto);
        int follow_status = LoadPostDao.checkFollow(new UserFollowDto(loadPostDto.getUid(), postAndUname.getUser_id()));
        int report_status = LoadPostDao.checkReport(loadPostDto);

        if(collect_status > 0)
            postAndUname.setCollect_status(1);
        else
            postAndUname.setCollect_status(0);

        postAndUname.setLike_status(like_status);
        postAndUname.setFollow_status(follow_status);
        postAndUname.setReport_status(report_status);
        return postAndUname;
    }

    @Override
    public List<ArrayList> getCommentList(LoadPostDto loadPostDto) {
        List<ArrayList> list = new ArrayList();
        List<CommentAndUname> parent_list = LoadPostDao.getCommentList(loadPostDto);
        for(CommentAndUname each:parent_list) {
            int like_status = LoadPostDao.checkCommentLike(new LoadPostDto(each.getComment_id(), loadPostDto.getUid()));
            each.setLike_status(like_status);
        }

        for(CommentAndUname each:parent_list) {
            String comment_id = each.getComment_id();
            List<CommentAndUname> sub_list = LoadPostDao.getCommentList(new LoadPostDto(comment_id));
            each.setSub_comment_number(sub_list.size());
            for(CommentAndUname each_:sub_list) {
                int like_status = LoadPostDao.checkCommentLike(new LoadPostDto(each_.getComment_id(), loadPostDto.getUid()));
                each_.setLike_status(like_status);
            }
            ArrayList arrayList = new ArrayList();
            arrayList.add(each);
            arrayList.add(sub_list);
            list.add(arrayList);
        }
        return list;
    }

    @Override
    public CommentAndUname getCommentById(LoadPostDto loadPostDto) {
        CommentAndUname commentAndUname = LoadPostDao.getCommentById(loadPostDto);
        List<CommentAndUname> sub_list = LoadPostDao.getCommentList(loadPostDto);
        int like_status = LoadPostDao.checkCommentLike(loadPostDto);
        commentAndUname.setLike_status(like_status);
        commentAndUname.setSub_comment_number(sub_list.size());
        return commentAndUname;
    }

    @Override
    public int checkAuthorRole(LoadPostDto dto) {
        int author_role = LoadPostDao.checkAuthorRole(dto);
        return author_role;
    }

    @Override
    public PostAndUname getAdminPost(LoadPostDto dto) {
        PostAndUname postAndUname = LoadPostDao.findAdminPost(dto);
        return postAndUname;
    }

    @Override
    public String getUserIdByPostId(String post_id) {
        String user_id = LoadPostDao.getUserIdByPostId(post_id);
        System.out.println(post_id+"hahha "+user_id);
        return user_id;
    }
}
