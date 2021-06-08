package com.cxp.openadmin.domain.entity;

import java.util.Date;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Table(name = "sys_role_menu_permission")
public class SysRoleMenuPermission {
    /**
     * 主键
     */
    @Id
    private Integer id;

    /**
     * 角色id
     */
    @Column(name = "role_id")
    private Integer roleId;

    /**
     * 菜单id
     */
    @Column(name = "menu_id")
    private Integer menuId;

    /**
     * 操作
     */
    private String operation;

    /**
     * 创建时间
     */
    @Column(name = "created_time")
    private Date createdTime;
}