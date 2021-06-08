package com.cxp.openadmin.filter;


import com.cxp.openadmin.dao.SysOperationLogMapper;
import com.cxp.openadmin.domain.dto.backed.JwtSysUserDto;
import com.cxp.openadmin.domain.dto.backed.SysUserLoginDto;
import com.cxp.openadmin.domain.entity.SysOperationLog;
import com.cxp.openadmin.domain.entity.SysUser;
import com.cxp.openadmin.domain.vo.backed.SimpleSysUserVo;
import com.cxp.openadmin.domain.vo.backed.SysUserVo;
import com.cxp.openadmin.exception.ExceptionResponse;
import com.cxp.openadmin.service.backed.SystemService;
import com.cxp.openadmin.util.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.code.kaptcha.Constants;
import lombok.SneakyThrows;
import nl.bitwalker.useragentutils.Browser;
import nl.bitwalker.useragentutils.UserAgent;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import javax.servlet.FilterChain;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class JWTAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    private AuthenticationManager authenticationManager;

    public JWTAuthenticationFilter(AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
        super.setFilterProcessesUrl("/backed/system/login");
    }

    @Autowired
    private JwtOperator jwtOperator;

    @Autowired
    private SysOperationLogMapper sysOperationLogMapper;

    @Autowired
    private SystemService systemService;

    @SneakyThrows
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request,
                                                HttpServletResponse response) throws AuthenticationException {

        ServletInputStream inputStream = request.getInputStream();
        ObjectMapper objectMapper = new ObjectMapper();
        SysUserLoginDto sysUserLoginDto = objectMapper.readValue(inputStream, SysUserLoginDto.class);

        String code = sysUserLoginDto.getCode();
        String kaptchaCode = (String) request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);

        if(kaptchaCode != null && !code.equals(kaptchaCode)) {
            response.setContentType("application/json;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(JsonUtils.objectToJson(new ExceptionResponse(1006, "验证码错误，请刷新验证码！", request.getMethod() + ':' + request.getRequestURI())));
            return null;
        }

        return authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(sysUserLoginDto.getUsername(), sysUserLoginDto.getPassword(), new ArrayList<>())
            );
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain chain,
                                            Authentication authResult) {

        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer=null;

        JwtSysUserDto jwtSysUserDTO = (JwtSysUserDto) authResult.getPrincipal();
        if(jwtSysUserDTO.getStatus() == 0){
            try {
                writer=response.getWriter();
                writer.write(JsonUtils.objectToJson(new ExceptionResponse(1005, "用户已禁用",request.getMethod()+':'+request.getRequestURI())));
                writer.flush();
            } catch (IOException ex) {
            }finally {
                if(writer!=null) {
                    writer.close();
                }
            }
        }else{

            String role = "";
            Collection<? extends GrantedAuthority> authorities = jwtSysUserDTO.getAuthorities();
            for (GrantedAuthority authority : authorities){
                role = authority.getAuthority();
            }

            _recordLoginLog(jwtSysUserDTO.getId());

            SysUserVo sysUserVo = _getSysUserInfo(jwtSysUserDTO, role);

            try {
                writer=response.getWriter();
                writer.write(JsonUtils.objectToJson(HttpResponse.success(sysUserVo)));
                writer.flush();
            } catch (IOException ex) {
            }finally {
                if(writer!=null) {
                    writer.close();
                }
            }
        }

    }

    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(JsonUtils.objectToJson(new ExceptionResponse(1004, "用户名密码错误",request.getMethod()+':'+request.getRequestURI())));

    }

    private SysUserVo _getSysUserInfo(JwtSysUserDto jwtSysUserDTO, String role){

        if(jwtOperator == null){
            jwtOperator = SpringUtils.getBean(JwtOperator.class);
        }

        if(systemService == null){
            systemService = SpringUtils.getBean(SystemService.class);
        }

        Map<String,Object> map = new HashMap();
        map.put("id",jwtSysUserDTO.getId());
        map.put("username",jwtSysUserDTO.getUsername());
        map.put("role",role);

        String token = jwtOperator.generateToken(map);

        SysUser sysUser = systemService.getUserInfoById(jwtSysUserDTO.getId());
        SimpleSysUserVo simpleSysUserVo = new SimpleSysUserVo();
        SysUserVo sysUserVo = new SysUserVo();
        BeanUtils.copyProperties(sysUser,simpleSysUserVo);
        simpleSysUserVo.setRole(role);
        sysUserVo.setUser(simpleSysUserVo);
        sysUserVo.setToken(token);
        sysUserVo.setTokenExpireAt(jwtOperator.getExpirationDateFromToken(token));
        sysUserVo.setPermissions(systemService.getRoleMenuPermissons(sysUser.getRoleId()));
        sysUserVo.setMenus(systemService.getRoleMenus(sysUser.getRoleId()));
        return sysUserVo;
    }

    private void _recordLoginLog(Integer operationId){

        if(sysOperationLogMapper == null){
            sysOperationLogMapper = SpringUtils.getBean(SysOperationLogMapper.class);
        }

        HttpServletRequest request = ((ServletRequestAttributes)
                RequestContextHolder.getRequestAttributes()).getRequest();

        // 记录操作日志
        SysOperationLog sysOperationLog = new SysOperationLog();
        sysOperationLog.setUrl(request.getRequestURI());
        sysOperationLog.setMethod(request.getMethod());
        sysOperationLog.setIp(IpUtil.getIpAddress(request));
        String ua = request.getHeader("User-Agent");
        UserAgent userAgent = UserAgent.parseUserAgentString(ua);
        Browser browser = userAgent.getBrowser();
        sysOperationLog.setBrowser(browser.getName());
        sysOperationLog.setCreatedTime(new Date());
        sysOperationLog.setOperationId(operationId);
        sysOperationLog.setTakeTime(0);
        sysOperationLogMapper.insertSelective(sysOperationLog);

    }

}
