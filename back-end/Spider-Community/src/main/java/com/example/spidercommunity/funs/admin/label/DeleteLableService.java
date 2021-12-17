package com.example.spidercommunity.funs.admin.label;




import java.awt.*;
import java.util.List;

public interface DeleteLableService {
    String delete(DeleteLabelDto dto);

    List<String> searchLabel(String msg) ;
}
