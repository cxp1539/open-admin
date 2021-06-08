package com.cxp.openadmin.service.backed;

import com.cxp.openadmin.domain.dto.backed.*;
import com.cxp.openadmin.domain.entity.*;
import com.cxp.openadmin.domain.vo.backed.RoleMenuAndMenuPermissionVo;
import com.cxp.openadmin.domain.vo.backed.SysMenuVo;
import com.cxp.openadmin.domain.vo.backed.SysRoleMenuPermissionVo;
import com.cxp.openadmin.util.PagedGridResult;
import java.util.Date;
import java.util.List;

public interface SystemService {

    SysUser getUserInfoById(Integer userId);

    PagedGridResult getSysUserList(Integer page, Integer pageSize);

    List<SysUser> getSysUserList();

    void createSysUser(SaveSysUserDto saveSysUserDto);

    void updateSysUser(SaveSysUserDto saveSysUserDto);

    void addMenu(SaveMenuDto saveMenuDto);

    void editMenu(SaveMenuDto saveMenuDto);

    void deleteMenu(Integer menuId);

    List<SysRole> getSysRoles();

    List<SysMenu> getMenuPermissions();

    void editSysRole(EditSysRoleDto editSysRoleDto);

    void deleteSysRole(Integer roleId);

    List<SysMenuVo> getRoleMenus(Integer roleId);

    List<SysRoleMenuPermissionVo> getRoleMenuPermissons(Integer roleId);

    void saveRoleMenus(SaveRoleMenusDto saveRoleMenusDto);

    void saveRoleMenuPermissons(SaveRoleMenuPermissonsDto saveRoleMenuPermissonsDto);

    RoleMenuAndMenuPermissionVo getMenuAndMenuPermissions(Integer roleId);

    PagedGridResult getOperactionLogList(Date startTime, Date endTime, String operationId, Integer page, Integer pageSize);

    void settingSysUserInfo(SettingSysUserInfoDto settingSysUserInfoDto, Integer userId);

    void settingSysUserPassword(SettingSysUserPasswordDto settingSysUserPasswordDto, Integer userId);

    List<SysMenuVo> getSysMenus();

    void logout();
}
