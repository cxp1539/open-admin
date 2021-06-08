package com.cxp.openadmin.domain.entity;

import java.util.Date;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Table(name = "sys_menu")
public class SysMenu {
    /**
     * 主键
     */
    @Id
    private Integer id;

    /**
     * 路径
     */
    private String path;

    /**
     * 是否隐藏菜单，0: 不隐藏, 1:隐藏
     */
    private Integer invisible;

    /**
     * 父节点Id
     */
    @Column(name = "parent_id")
    private Integer parentId;

    /**
     * 菜单名称
     */
    private String name;

    /**
     * 图标
     */
    private String icon;

    /**
     * 是否隐藏菜单，0: 不缓存, 1:缓存
     */
    @Column(name = "cache_able")
    private Integer cacheAble;

    /**
     * 菜单排序
     */
    private Integer sort;

    /**
     * 组件名称
     */
    private String component;

    /**
     * 操作权限
     */
    private String permissions;

    /**
     * 创建时间
     */
    @Column(name = "created_time")
    private Date createdTime;
}