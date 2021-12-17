package com.example.spidercommunity.funs.user.interaction.impl;

import com.example.spidercommunity.funs.user.info.User;
import com.example.spidercommunity.funs.user.interaction.*;
import com.example.spidercommunity.funs.user.interaction.dao.InteractionDao;
import com.example.spidercommunity.funs.user.load_post.LoadPostDto;
import com.example.spidercommunity.funs.user.load_post.UserFollowDto;
import com.example.spidercommunity.funs.user.load_post.dao.LoadPostDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class InteractionServiceImpl implements InteractionService {

    @Resource
    private InteractionDao interactionDao;

    @Resource
    private LoadPostDao postDao;

    @Override
    public void likePost(LoadPostDto loadPostDto) {
        int like_status = postDao.checkPostLike(loadPostDto);
        if(like_status > 0) {
            interactionDao.deletePostLike(loadPostDto);
            interactionDao.decreasePostLikeNumber(loadPostDto);
        }
        else {
            Date date = new Date();
            interactionDao.insertPostLike(new PostLikeDto(loadPostDto.getPno(), loadPostDto.getUid(), date));
            interactionDao.increasePostLikeNumber(loadPostDto);
        }
    }

    @Override
    public List<CollectGroup> loadCollectFolders(LoadPostDto dto) {
        List<CollectGroup> collectGroupList = interactionDao.loadCollectFolders(dto);
        for(CollectGroup each:collectGroupList) {
            int collect_status = interactionDao.checkCollectionStatus(new LoadCollectionGroupDto(dto.getPno(), dto.getUid(), each.getCollect_group_id()));
            each.setCollect_status(collect_status);
        }
        return collectGroupList;
    }

    @Override
    public void collectPost(LoadCollectionGroupDto loadCollectionGroupDto) {
        int collect_status = interactionDao.checkCollectionStatus(loadCollectionGroupDto);
        if(collect_status > 0) {
            interactionDao.deletePostCollect(loadCollectionGroupDto);
            interactionDao.decreasePostCollectNumber(loadCollectionGroupDto);
            interactionDao.decreaseCollectContentNumber(loadCollectionGroupDto);
        }
        else {
            loadCollectionGroupDto.setPostCollectTime(new Date());
            interactionDao.insertPostCollect(loadCollectionGroupDto);
            interactionDao.increasePostCollectNumber(loadCollectionGroupDto);
            interactionDao.increaseCollectContentNumber(loadCollectionGroupDto);
        }
    }

    @Override
    public void likeComment(LoadPostDto loadPostDto) {
        int like_status = postDao.checkCommentLike(loadPostDto);
        if(like_status > 0) {
            interactionDao.deleteCommentLike(loadPostDto);
            interactionDao.decreaseCommentLikeNumber(loadPostDto);
        }
        else {
            interactionDao.insertCommentLike(loadPostDto);
            interactionDao.increaseCommentLikeNumber(loadPostDto);
        }
    }

    @Override
    public void comment(CommentDto commentDto) {
        interactionDao.comment(commentDto);
        interactionDao.increaseCommentNumber(commentDto);
    }

    @Override
    public void deleteComment(CommentDto commentDto) {
        List<CommentDto> subCommentList = interactionDao.findSubComment(commentDto);
        if(subCommentList.size() != 0) {
            for(CommentDto each:subCommentList) {
                deleteComment(each);
            }
        }
        interactionDao.deleteThisCommentLike(commentDto);
        interactionDao.deleteThisComment(commentDto);
        interactionDao.decreasePostCommentNumber(commentDto);
    }

    @Override
    public void attention(UserFollowDto userFollowDto) {
        int follow_status = postDao.checkFollow(userFollowDto);
        System.out.println(follow_status);
        if(follow_status > 0) {
            interactionDao.deleteFollow(userFollowDto);
            interactionDao.decreaseFansNumber(userFollowDto);
            interactionDao.decreaseAttentionNumber(userFollowDto);
        }
        else {
            System.out.println("124578");
            interactionDao.insertFollow(userFollowDto);
            interactionDao.increaseFansNumber(userFollowDto);
            interactionDao.increaseAttentionNumber(userFollowDto);

        }
    }

    @Override
    public List<PostLike> getPostLike(PostLikeDto postlikedto) {
        List<PostLike> postlike = interactionDao.getPostLike(postlikedto);
        return postlike;
    }

    @Override
    public List<Commment> getComment(CommentDto commentdto) {
        List<Commment> commment = interactionDao.getComment(commentdto);
        return commment;
    }

    @Override
    public List<User> getViewattention(CommentDto commentdto) {
        List<User> user = interactionDao.getViewattention(commentdto);
        return user;
    }

    @Override
    public List<User> getViewfollower(CommentDto commentdto) {
        List<User> user = interactionDao.getViewfollower(commentdto);
        return user;
    }

}
