package com.example.spidercommunity.funs.user.search.impl;


import com.example.spidercommunity.funs.user.search.SearchResult;
import com.example.spidercommunity.funs.user.search.dao.SearchDao;

import com.example.spidercommunity.funs.user.search.SearchDto;
import com.example.spidercommunity.funs.user.search.SearchService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


@Service
@Transactional
public class SearchServiceImpl implements SearchService{


        @Resource
        private SearchDao searchDao;

        @Override
        public List<SearchResult> searchPost(SearchDto dto) {
            List<SearchResult> searchResult = new ArrayList<>();

            if (dto.getKey().equals("1")){
                searchResult.addAll(searchDao.findPost1(dto.getMsg()));
            }//查内容
            else if (dto.getKey().equals("2"))
                searchResult.addAll(searchDao.findPost2(dto.getMsg()));//查标题
            else if (dto.getKey().equals("3")){
                searchResult.addAll(searchDao.findPost3(dto.getMsg())); // 查用户
                searchResult.addAll(searchDao.findPost5(dto.getMsg())); // 查管理员

            }

            else if (dto.getKey().equals("4"))
                searchResult.addAll(searchDao.findPost4(dto.getMsg()));//查标签
            else
                searchResult.addAll(searchDao.findPost1(dto.getMsg()));//默认查内容

            for (int i = 0; i < searchResult.size(); i++){
                if (i == searchResult.size()) break;
                searchResult.get(i).setPost_like_number(searchDao.getPostLikeNumber(searchResult.get(i)));
                searchResult.get(i).setLike_status(0);
            }

            System.out.println(dto.getKey());
            return searchResult;
        }



}
