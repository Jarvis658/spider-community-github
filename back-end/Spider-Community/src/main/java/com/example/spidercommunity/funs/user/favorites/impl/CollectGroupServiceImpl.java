package com.example.spidercommunity.funs.user.favorites.impl;

import com.example.spidercommunity.funs.user.favorites.*;
import com.example.spidercommunity.funs.user.favorites.dao.CollectGroupDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class CollectGroupServiceImpl implements CollectGroupService {

    @Resource
    private CollectGroupDao collectGroupDao;

    @Override
    public List<CollectGroup> getCollectGroup(CollectGroupDto collectGroupDto) {
                List <CollectGroup> collectGroup = collectGroupDao.getCollectGroup(collectGroupDto);
        return collectGroup;
    }

    @Override
    public void addCollectGroup(CollectGroupDto collectGroupDto) {
        collectGroupDao.addCollectGroup(collectGroupDto);

    }

    @Override
    public void deleteCollectGroup(CollectGroupDto collectGroupDto) {
        collectGroupDao.deleteCollectGroupContent(collectGroupDto);
        collectGroupDao.deleteCollectGroup(collectGroupDto);
    }

    @Override
    public void updateCollectGroup(CollectGroupDto collectGroupDto) {
        collectGroupDao.updateCollectGroup(collectGroupDto);
    }

    @Override
    public List<Post> getCollectGroupContent(CollectGroupDto collectGroupDto) {
        List<Post> collect = collectGroupDao.getCollectGroupContent(collectGroupDto);
        return collect;
    }

    @Override
    public void deleteCollectGroupLike(CollectDto collectDto) {
        collectGroupDao.deleteCollectGroupLike(collectDto);
        collectGroupDao.decreaseCollectPostNumber(collectDto);
    }

    @Override
    public List<CollectGroup> getOtherCollectGroup(CollectGroupDto collectGroupDto) {
        List <CollectGroup> collectGroup = collectGroupDao.getOtherCollectGroup(collectGroupDto);
        return collectGroup;
    }


}
