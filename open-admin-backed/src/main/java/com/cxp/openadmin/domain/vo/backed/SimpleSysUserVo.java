package com.cxp.openadmin.domain.vo.backed;

import lombok.Data;
import java.util.Date;

@Data
public class SimpleSysUserVo {
    private String username;
    private String avatar;
    private String name;
    private String role;
    private Date createdTime;
}
