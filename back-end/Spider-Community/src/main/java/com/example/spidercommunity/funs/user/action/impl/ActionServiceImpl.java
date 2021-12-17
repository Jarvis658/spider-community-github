package com.example.spidercommunity.funs.user.action.impl;

import com.example.spidercommunity.funs.user.action.ActionDto;
import com.example.spidercommunity.funs.user.action.ActionService;
import com.example.spidercommunity.funs.user.action.dao.ActionDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class ActionServiceImpl implements ActionService {
    @Resource
    private ActionDao actionDao;

    @Override
    public void addViewRecord(ActionDto dto) {
        if (actionDao.checkViewRecord(dto) >= 1)
            actionDao.refreshViewRecord(dto);
        else actionDao.addViewRecord(dto);
    }
}
