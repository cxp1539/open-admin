package com.cxp.openadmin.service.backed.impl;

import com.cxp.openadmin.dao.UserMapper;
import com.cxp.openadmin.domain.entity.User;
import com.cxp.openadmin.service.backed.UserService;
import com.cxp.openadmin.util.PagedGridResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;
import javax.annotation.Resource;
import java.util.List;

@Service("backedUserServiceImpl")
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public PagedGridResult getUserList(String nickname, Integer page, Integer pageSize) {
        PageHelper.startPage(page,pageSize);

        Example example = new Example(User.class);
        example.orderBy("createdTime").desc();
        Example.Criteria criteria = example.createCriteria();
        if(!StringUtils.isBlank(nickname)){
            criteria.andLike("nickname","%"+nickname+"%");
        }
        List<User> list = userMapper.selectByExample(example);
        PageInfo<?> pageList = new PageInfo<>(list);
        PagedGridResult grid = new PagedGridResult();
        grid.setPage(page);
        grid.setRows(list);
        grid.setTotal(pageList.getPages());
        grid.setRecords(pageList.getTotal());
        return grid;
    }


    @Override
    public List<User> getUserList(String nickname) {
        Example example = new Example(User.class);
        Example.Criteria criteria = example.createCriteria();
        if(!StringUtils.isBlank(nickname)){
            criteria.andLike("nickname","%"+nickname+"%");
        }
        example.orderBy("createdTime").desc();
        return userMapper.selectByExample(example);
    }
}
