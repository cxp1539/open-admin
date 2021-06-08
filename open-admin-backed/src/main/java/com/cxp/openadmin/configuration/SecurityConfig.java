package com.cxp.openadmin.configuration;

import com.cxp.openadmin.filter.JWTAuthenticationFilter;
import com.cxp.openadmin.filter.JWTAuthorizationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;

@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Qualifier("systemServiceImpl")
    @Autowired
    private UserDetailsService backedUserServiceImpl;

    @Autowired
    private RestAccessDeniedHandler accessDeniedHandler;

    @Autowired
    private RestAuthenticationEntryPoint authenticationEntryPoint;

    @Bean
    public Md5PasswordEncoder md5PasswordEncoder(){
        return new Md5PasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(backedUserServiceImpl).passwordEncoder(md5PasswordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.cors().and().csrf().disable()
                .authorizeRequests()
                .antMatchers("/backed/system/edit-role","/backed/system/delete-role","/backed/system/delete-menu","/backed/system/add-menu","/backed/system/edit-menu", "/backed/system/save-role-menus", "/backed/system/save-role-menu-permissons", "/backed/system/create-sysuser", "/backed/system/update-sysuser")
                .hasAuthority("admin")
                .antMatchers("/backed/user/**").authenticated()
                .antMatchers("/backed/mock/**").authenticated()
                .antMatchers("/common/**").authenticated()
                .anyRequest().permitAll()
                .and()
                .exceptionHandling().authenticationEntryPoint(authenticationEntryPoint).accessDeniedHandler(accessDeniedHandler)
                .and()
                .addFilter(new JWTAuthenticationFilter(authenticationManager()))
                .addFilter(new JWTAuthorizationFilter(authenticationManager()))
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);

    }


}