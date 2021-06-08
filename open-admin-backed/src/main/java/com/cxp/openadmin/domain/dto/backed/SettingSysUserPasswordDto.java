package com.cxp.openadmin.domain.dto.backed;

import lombok.Data;
import javax.validation.constraints.NotBlank;

@Data
public class SettingSysUserPasswordDto {

    @NotBlank(message = "原始密码不能为空")
    private String sourcePassword;

    @NotBlank(message = "新密码不能为空")
    private String password;

    @NotBlank(message = "确认密码不能为空")
    private String confirmPassword;

}
