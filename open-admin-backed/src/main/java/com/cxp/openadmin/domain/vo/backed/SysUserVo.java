package com.cxp.openadmin.domain.vo.backed;

import lombok.Data;
import java.util.Date;
import java.util.List;

@Data
public class SysUserVo {

    private SimpleSysUserVo user;
    private String token;
    private Date tokenExpireAt;
    private List<SysRoleMenuPermissionVo> permissions;
    private List<SysMenuVo> menus;
}
