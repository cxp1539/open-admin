package com.cxp.openadmin.domain.dto.backed;

import lombok.Data;

@Data
public class SaveMenuDto {

    private Integer id;
    private String path;
    private Integer invisible;
    private Integer parentId;
    private String name;
    private String icon;
    private Integer cacheAble;
    private Integer sort;
    private String component;
    private String permissions;

}
