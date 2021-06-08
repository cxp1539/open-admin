package com.cxp.openadmin.domain.vo.backed;

import lombok.Data;
import java.util.List;

@Data
public class RoleMenuAndMenuPermissionVo {

    private String menuIds;
    private List<PermissionVo> permissions;

}
