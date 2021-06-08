package com.cxp.openadmin.domain.vo.backed;

import com.cxp.openadmin.util.TreeEntity;
import lombok.Data;
import java.util.List;

@Data
public class SysMenuVo implements TreeEntity<SysMenuVo>{
    public Integer id;
    public String name;
    public String path;
    public Integer invisible;
    public String icon;
    public Integer cacheAble;
    public String component;
    public Integer parentId;
    public List<SysMenuVo> children;
}
