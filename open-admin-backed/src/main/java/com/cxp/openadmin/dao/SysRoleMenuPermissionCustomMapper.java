package com.cxp.openadmin.dao;

import com.cxp.openadmin.domain.entity.SysRoleMenuPermission;
import com.cxp.openadmin.domain.vo.backed.SysRoleMenuPermissionVo;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;
import java.util.List;
import java.util.Map;

public interface SysRoleMenuPermissionCustomMapper extends Mapper<SysRoleMenuPermission> {

    List<SysRoleMenuPermissionVo> getRoleMenuPermissons(@Param("paramsMap") Map<String, Integer> map);
}