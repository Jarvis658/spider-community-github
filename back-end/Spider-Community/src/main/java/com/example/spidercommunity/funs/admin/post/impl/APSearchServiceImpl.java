package com.example.spidercommunity.funs.admin.post.impl;


import com.example.spidercommunity.funs.admin.post.APSearchService;
import com.example.spidercommunity.funs.admin.post.APSearchDto;
import com.example.spidercommunity.funs.admin.post.APSearchResult;

import com.example.spidercommunity.funs.admin.post.dao.APSearchDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;


@Service
@Transactional
public class APSearchServiceImpl implements APSearchService {


        @Resource
        private APSearchDao APsearchDao;

        @Override
        public List<APSearchResult> searchPost(APSearchDto dto) {
            if (dto.getKey().equals("1"))
                return APsearchDao.APfindPost1(dto.getMsg());//查内容
            if (dto.getKey().equals("2"))
                return APsearchDao.APfindPost2(dto.getMsg());//查标题
            if (dto.getKey().equals("3")){
                int msg=Integer.parseInt(dto.getMsg());
                System.out.println(msg);
                return APsearchDao.APfindPost3(msg);//查作者ID
            }

            if (dto.getKey().equals("4"))
                return APsearchDao.APfindPost4(dto.getMsg());//文章ID

            System.out.println(dto.getKey());
            return APsearchDao.APfindPost1(dto.getMsg());//默认查内容
        }



}
