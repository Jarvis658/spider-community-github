package com.example.spidercommunity.funs.admin.audit;

import java.util.List;

public interface AuditService {

    List<Data> getPost(AuditDto dto);

    List<Data> loadContent(AuditDto dto);

    void changeStatus(AuditDto dto);

    List<Data> loadOwnPost(AuditDto dto);
}
