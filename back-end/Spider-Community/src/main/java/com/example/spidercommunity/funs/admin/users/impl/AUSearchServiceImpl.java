package com.example.spidercommunity.funs.admin.users.impl;


import com.example.spidercommunity.funs.admin.users.AUSearchService;
import com.example.spidercommunity.funs.admin.users.AUSearchDto;
import com.example.spidercommunity.funs.admin.users.AUSearchResult;

import com.example.spidercommunity.funs.admin.users.dao.AUSearchDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;


@Service
@Transactional
public class AUSearchServiceImpl implements AUSearchService {


        @Resource
        private AUSearchDao AUsearchDao;

        @Override
        public List<AUSearchResult> searchPost(AUSearchDto dto) {
            if (dto.getKey().equals("1")){
                int msg=Integer.parseInt(dto.getMsg());
                return AUsearchDao.AUfindPost1(msg);//查用户ID
            }
            if (dto.getKey().equals("2")){

                return AUsearchDao.AUfindPost2(dto.getMsg());//查用户昵称(注册时间)
            }

            return AUsearchDao.AUfindPost3(dto.getMsg());//默认查昵称（最近登录时间）
        }



}
