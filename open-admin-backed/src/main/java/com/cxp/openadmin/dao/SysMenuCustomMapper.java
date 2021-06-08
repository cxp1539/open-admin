package com.cxp.openadmin.dao;

import com.cxp.openadmin.domain.entity.SysMenu;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;
import java.util.List;

public interface SysMenuCustomMapper extends Mapper<SysMenu> {

    List<SysMenu> findMenuByIds(@Param("ids") String[] ids);
}