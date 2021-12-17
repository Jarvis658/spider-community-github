package com.example.spidercommunity.funs.user.post.impl;

import com.example.spidercommunity.funs.user.load_post.CommentAndUname;
import com.example.spidercommunity.funs.user.post.*;
import com.example.spidercommunity.funs.user.post.dao.PostPostDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service //说明这是一个受spring容器管理的业务组件(Bean)
@Transactional //说明本类的所有方法都是事务性
public class PostServiceImpl implements PostService {

    @Resource
    private PostPostDao postPostDao;

    @Override
    public void postPost(PostLastDto postLastDto) {
        postPostDao.insertPost(postLastDto);
    }

    @Override
    public void postLabel(PostLabelDto postLabelDto) {
        String post_id = postLabelDto.getPost_id();
        String user_id = postLabelDto.getUser_id();
        String[] labelArray = postLabelDto.getLabelArray();

        for(int i=0; i<labelArray.length; i++){
            String label_i = labelArray[i];
            int count1 = postPostDao.searchLabel(label_i);
            boolean inLabelPool =(count1 == 0)?false:true;//检查标签是否在标签池中
            int label_id;
            if(!inLabelPool){
                postPostDao.newLabel(label_i);//若不在总标签池，加入标签池
            }
            label_id = postPostDao.selectLabelID(label_i);//得到该标签的id

            postPostDao.insertLabel(post_id,label_id);//插入帖子标签表

            PostLabelLastDto postLastLabelDto = new PostLabelLastDto();
            postLastLabelDto.setPost_id(post_id);
            postLastLabelDto.setUser_id(user_id);
            postLastLabelDto.setLabel_id(label_id);
            postLastLabelDto.setScore(0.6);

            int count2 = postPostDao.searchLabelInUserLabel(user_id,label_id);
            boolean inLabelUserLabel =(count2 == 0)?false:true;//检查该用户标签是否存在用户标签表
            if(inLabelUserLabel){
                //用户标签表中存在，则更新
                System.out.println(postLastLabelDto.getScore());
                postPostDao.updateUserLabel(postLastLabelDto);
            }else{
                //若不在用户标签表，加入用户标签表
                postPostDao.insertUserLabel(postLastLabelDto);
            }
        }
    }

    @Override
    public PostLastDto searchPost(String post_id) {
        PostLastDto postLastDto = postPostDao.searchPost(post_id);
        return postLastDto;
    }

    @Override
    public void updatePost(RewriteDto rewriteDto) {
        postPostDao.updatePost(rewriteDto);
        System.out.println("kanwo");
    }

    @Override
    public void deleteLabel(String post_id) {
        postPostDao.deleteLabel(post_id);
    }

    @Override
    public List<String > searchLabelInPostLabel(String post_id) {
        System.out.println(post_id);
        List<String> labelArray = postPostDao.searchLabelInPostLabel(post_id);
        System.out.println(labelArray);
        return labelArray;
    }

    @Override
    public void deletePost(PostLastDto postDto) {
        List<CommentAndUname> commentList = postPostDao.getCommentList(postDto);
        for(CommentAndUname each:commentList) {
            postPostDao.deleteCommentLike(each);
        }
        postPostDao.deleteAllComment(postDto);
        postPostDao.deleteAllPostLike(postDto);
        postPostDao.deleteAllPostLabel(postDto);
        postPostDao.deleteAllPostCollected(postDto);
        postPostDao.deletePost(postDto);
    }

    @Override
    public void reportPost(PostLastDto postDto) {
        postPostDao.increasePostReportNumber(postDto);
        postPostDao.reportPost(postDto);
        int reportNumber = postPostDao.checkReportNumber(postDto);
        if(reportNumber > 20)
            postPostDao.solveReport(postDto);
    }

    @Override
    public List<PostLastDto> viewHistory(PostDto postDto) {
        return postPostDao.viewHistory(postDto);
    }

}