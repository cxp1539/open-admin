package com.cxp.openadmin.domain.entity;

import java.util.Date;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Table(name = "sys_role")
public class SysRole {
    /**
     * 主键
     */
    @Id
    private Integer id;

    /**
     * 权限唯一键
     */
    @Column(name = "unique_key")
    private String uniqueKey;

    /**
     * 权限名称
     */
    private String name;

    /**
     * 备注
     */
    private String remark;

    /**
     * 创建时间
     */
    @Column(name = "created_time")
    private Date createdTime;
}