package com.cxp.openadmin.domain.entity;

import java.util.Date;
import javax.persistence.*;

import lombok.*;

@Getter
@Setter
@ToString
@Table(name = "user")
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {
    /**
     * Id
     */
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;

    private String openid;

    private String unionid;

    private String nickname;

    private String mobile;

    private String gender;

    /**
     * 头像地址
     */
    @Column(name = "avatar_url")
    private String avatarUrl;

    /**
     * 状态,1 启动，2禁用
     */
    private Integer status;

    /**
     * 创建时间
     */
    @Column(name = "created_time")
    private Date createdTime;

    /**
     * 修改时间
     */
    @Column(name = "updated_time")
    private Date updatedTime;
}