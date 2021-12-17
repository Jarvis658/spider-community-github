package com.example.spidercommunity.funs.admin.label.impl;

import com.example.spidercommunity.funs.admin.label.DeleteLabelDto;
import com.example.spidercommunity.funs.admin.label.DeleteLableService;
import com.example.spidercommunity.funs.admin.label.DeletePostId;
import com.example.spidercommunity.funs.admin.label.LabelId;
import com.example.spidercommunity.funs.admin.label.dao.DeleteLableDao;
import com.example.spidercommunity.funs.user.load_post.CommentAndUname;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service // 说明这是一个受 spring 管理的业务类组件(Bean)
@Transactional // 说明本类所有方法都是事务性的
public class DeleteLabelServiceImpl implements DeleteLableService {
    @Resource
    private DeleteLableDao deleteLableDao;


    @Override
    public List<String> searchLabel(String msg){
       return deleteLableDao.search(msg);
    }


    @Override
    public String delete(DeleteLabelDto dto) {
        System.out.println(dto.getName());
        int ok =deleteLableDao.checkExist(dto);
        if(ok>0){
            LabelId id =new LabelId(deleteLableDao.getId(dto));
            List<String> pid=deleteLableDao.getPostId(id);
            for (String s : pid) {
                DeletePostId deletePostId = new DeletePostId(s);

                List<CommentAndUname> commentList = deleteLableDao.getCommentList(deletePostId);
                for (CommentAndUname each : commentList) {
                    deleteLableDao.deleteCommentLike(each);
                }
                deleteLableDao.deleteAllComment(deletePostId);
                deleteLableDao.deleteAllPostLike(deletePostId);
                deleteLableDao.deleteAllPostLabel(deletePostId);
                deleteLableDao.deleteAllPostCollected(deletePostId);
                deleteLableDao.deletePost(deletePostId);


            }
            deleteLableDao.deleteUserLabel(id);
            deleteLableDao.deleteLabel(id);
            return "删除成功";

        }else return "无该标签";


    }
}
