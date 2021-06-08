package com.cxp.openadmin.domain.entity;

import java.util.Date;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Table(name = "sys_operation_log")
public class SysOperationLog {
    /**
     * 主键ID
     */
    @Id
    private Integer id;

    /**
     * 操作人id
     */
    @Column(name = "operation_id")
    private Integer operationId;

    /**
     * 操作类型
     */
    private String url;

    /**
     * 操作方法
     */
    private String method;

    /**
     * 操作内容
     */
    private String params;

    /**
     * 浏览器类型
     */
    private String browser;

    /**
     * 操作ip
     */
    private String ip;

    /**
     * 执行时长
     */
    @Column(name = "take_time")
    private Integer takeTime;

    /**
     * 创建时间
     */
    @Column(name = "created_time")
    private Date createdTime;
}