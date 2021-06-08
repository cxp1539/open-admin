package com.cxp.openadmin.service.front;

import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import com.cxp.openadmin.domain.entity.User;

public interface UserService {

    User login(WxMaUserInfo wxMaUserInfo);

    void bindMobile(String mobile, Integer userId);

}
