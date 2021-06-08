package com.cxp.openadmin.domain.dto.backed;

import lombok.Data;
import java.util.List;

@Data
public class SaveRoleMenuPermissonsDto {
    private Integer roleId;
    private List<SysRoleMenuPermissonsDto> permissions;
}
