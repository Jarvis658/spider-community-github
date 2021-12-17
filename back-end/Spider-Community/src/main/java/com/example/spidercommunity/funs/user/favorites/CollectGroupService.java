package com.example.spidercommunity.funs.user.favorites;

import java.util.List;

public interface CollectGroupService {
    List<CollectGroup> getCollectGroup(CollectGroupDto collectGroupDto);

    void addCollectGroup(CollectGroupDto collectGroupDto);

    void deleteCollectGroup(CollectGroupDto collectGroupDto);

    void updateCollectGroup(CollectGroupDto collectGroupDto);

    List<Post> getCollectGroupContent(CollectGroupDto collectGroupDto);

    void deleteCollectGroupLike(CollectDto collectDto);

    List<CollectGroup> getOtherCollectGroup(CollectGroupDto collectGroupDto);
}
