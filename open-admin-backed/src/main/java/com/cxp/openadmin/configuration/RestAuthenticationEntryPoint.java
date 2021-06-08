package com.cxp.openadmin.configuration;

import com.cxp.openadmin.exception.ExceptionResponse;
import com.cxp.openadmin.util.JsonUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException {
        httpServletResponse.setContentType("application/json;charset=UTF-8");
        httpServletResponse.setCharacterEncoding("UTF-8");
        httpServletResponse.getWriter().write(JsonUtils.objectToJson(new ExceptionResponse(1003, "token失效",httpServletRequest.getMethod()+':'+httpServletRequest.getRequestURI())));
    }
}
