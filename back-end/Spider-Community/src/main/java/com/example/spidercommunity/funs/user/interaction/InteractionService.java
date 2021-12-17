package com.example.spidercommunity.funs.user.interaction;

import com.example.spidercommunity.funs.user.info.User;
import com.example.spidercommunity.funs.user.load_post.LoadPostDto;
import com.example.spidercommunity.funs.user.load_post.UserFollowDto;

import java.util.List;

public interface InteractionService {
    void likePost(LoadPostDto loadPostDto);

    List<CollectGroup> loadCollectFolders(LoadPostDto loadPostDto);

    void collectPost(LoadCollectionGroupDto loadCollectionGroupDto);

    void likeComment(LoadPostDto loadPostDto);

    void comment(CommentDto commentDto);

    void deleteComment(CommentDto commentDto);

    void attention(UserFollowDto userFollowDto);

    List<PostLike> getPostLike(PostLikeDto postlikedto);

    List<Commment> getComment(CommentDto commentdto);

    List<User> getViewattention(CommentDto commentdto);

    List<User> getViewfollower(CommentDto commentdto);
}
