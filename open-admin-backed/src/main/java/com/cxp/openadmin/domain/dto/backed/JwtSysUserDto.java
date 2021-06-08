package com.cxp.openadmin.domain.dto.backed;

import com.cxp.openadmin.domain.entity.SysRole;
import com.cxp.openadmin.domain.entity.SysUser;
import lombok.Data;
import lombok.ToString;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.Collection;
import java.util.Collections;

@Data
@ToString
public class JwtSysUserDto implements UserDetails {

    private Integer id;
    private String username;
    private String password;
    private Integer status;
    private Collection<? extends GrantedAuthority> authorities;


    public JwtSysUserDto(SysUser sysUser, SysRole sysRole) {
        System.out.println(11111111);
        System.out.println(sysUser.getRoleId());
        System.out.println(sysRole.getUniqueKey());
        id = sysUser.getId();
        username = sysUser.getUsername();
        password = sysUser.getPassword();
        status = sysUser.getStatus();
        authorities = Collections.singleton(new SimpleGrantedAuthority(sysRole.getUniqueKey()));
    }


    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
