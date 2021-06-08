package com.cxp.openadmin.domain.entity;

import java.util.Date;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Table(name = "sys_role_menu")
public class SysRoleMenu {
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
     * 菜单ids
     */
    @Column(name = "menu_ids")
    private String menuIds;

    /**
     * 创建时间
     */
    @Column(name = "created_time")
    private Date createdTime;
}