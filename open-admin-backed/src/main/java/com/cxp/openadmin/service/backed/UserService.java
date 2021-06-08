package com.cxp.openadmin.service.backed;

import com.cxp.openadmin.domain.entity.User;
import com.cxp.openadmin.util.PagedGridResult;
import java.util.List;

public interface UserService {

    PagedGridResult getUserList(String nickname, Integer page, Integer pageSize);

    List<User> getUserList(String nickname);

}
