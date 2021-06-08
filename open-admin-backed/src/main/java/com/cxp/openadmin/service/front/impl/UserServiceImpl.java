package com.cxp.openadmin.service.front.impl;

import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import com.cxp.openadmin.dao.UserMapper;
import com.cxp.openadmin.domain.entity.User;
import com.cxp.openadmin.service.front.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;

@Service
public class UserServiceImpl implements UserService {

    @Autowired(required = false)
    private UserMapper userMapper;

    public User login(WxMaUserInfo wxMaUserInfo) {

        User user = new User();
        user.setOpenid(wxMaUserInfo.getOpenId());
        User selectUser = userMapper.selectOne(user);

        if (selectUser == null) {
            User insertUser = User.builder().openid(wxMaUserInfo.getOpenId())
                    .unionid(wxMaUserInfo.getUnionId())
                    .avatarUrl(wxMaUserInfo.getAvatarUrl())
                    .nickname(wxMaUserInfo.getNickName())
                    .gender(wxMaUserInfo.getGender())
                    .updatedTime(new Date())
                    .createdTime(new Date())
                    .build();
            userMapper.insertSelective(insertUser);

            return insertUser;

        } else {
            return selectUser;
        }
    }


    public void bindMobile(String mobile, Integer userId) {

        User user = new User();
        user.setId(userId);
        user.setMobile(mobile);
        userMapper.updateByPrimaryKeySelective(user);

    }

}
