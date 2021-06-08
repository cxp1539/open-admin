package com.cxp.openadmin.domain.dto.backed;

import lombok.Data;

@Data
public class SaveSysUserDto {

    private Integer id;
    private String username;
    private String password;
    private Integer roleId;
    private String name;
    private Integer status;
    private String avatar;

}
