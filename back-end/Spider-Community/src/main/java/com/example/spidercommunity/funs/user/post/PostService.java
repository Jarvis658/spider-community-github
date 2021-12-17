package com.example.spidercommunity.funs.user.post;

import java.util.List;

public interface PostService {
    void postPost(PostLastDto postLastDto);

    void postLabel(PostLabelDto postLabelDto);

    PostLastDto searchPost(String post_id);

    void updatePost(RewriteDto rewriteDto);

    void deleteLabel(String post_id);

    List<String > searchLabelInPostLabel(String post_id);

    void deletePost(PostLastDto postDto);

    void reportPost(PostLastDto postDto);

    List<PostLastDto> viewHistory(PostDto postDto);
}
