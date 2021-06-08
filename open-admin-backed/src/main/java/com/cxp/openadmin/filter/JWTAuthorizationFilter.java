package com.cxp.openadmin.filter;

import com.cxp.openadmin.exception.ExceptionResponse;
import com.cxp.openadmin.util.JsonUtils;
import com.cxp.openadmin.util.JwtOperator;
import com.cxp.openadmin.util.SpringUtils;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;

public class JWTAuthorizationFilter extends BasicAuthenticationFilter {

    @Autowired
    private JwtOperator jwtOperator;

    public JWTAuthorizationFilter(AuthenticationManager authenticationManager) {
        super(authenticationManager);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain chain) throws IOException, ServletException {
        String tokenHeader = request.getHeader("Authorization");

        if (tokenHeader == null) {
            chain.doFilter(request, response);
            return;
        }

        SecurityContextHolder.getContext().setAuthentication(getAuthentication(tokenHeader));
        super.doFilterInternal(request, response, chain);
    }

    private UsernamePasswordAuthenticationToken getAuthentication(String token) {

        if(jwtOperator == null){
            jwtOperator = (JwtOperator) SpringUtils.getBean("jwtOperator");
        }

        Boolean isValid = jwtOperator.validateToken(token);

        if(isValid){
            Claims claims = jwtOperator.getClaimsFromToken(token);
            String username = claims.get("username").toString();
            String role = claims.get("role").toString();
            return new UsernamePasswordAuthenticationToken(username, null, Collections.singleton(new SimpleGrantedAuthority(role)));

        }else{

            ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            HttpServletRequest request = servletRequestAttributes.getRequest();
            HttpServletResponse response = servletRequestAttributes.getResponse();

            response.setContentType("application/json;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer=null;

            try {
                writer=response.getWriter();
                writer.write(JsonUtils.objectToJson(new ExceptionResponse(1003, "token失效",request.getMethod()+':'+request.getRequestURI())));
                writer.flush();
            } catch (IOException ex) {
            }finally {
                if(writer!=null) {
                    writer.close();
                }
            }

        }
        return null;
    }
}