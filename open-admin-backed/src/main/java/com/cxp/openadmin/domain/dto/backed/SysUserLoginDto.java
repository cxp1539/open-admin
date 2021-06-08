package com.cxp.openadmin.domain.dto.backed;

import lombok.Data;

@Data
public class SysUserLoginDto {

    private String username;
    private String password;
    private String code;

}
