package com.cxp.openadmin.controller;

import com.cxp.openadmin.util.JwtOperator;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.WebRequest;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BaseController {

    @InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        DateFormat dateFormat=new SimpleDateFormat("YYYY-MM-DD");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @Autowired
    private JwtOperator jwtOperator;

    protected Integer getPassportUserId(HttpServletRequest request){
        String token = request.getHeader("Authorization");
        Claims claims = jwtOperator.getClaimsFromToken(token);
        return Integer.parseInt(claims.get("id").toString());
    }


    protected Map<String,String> getBindingResultErrors(BindingResult bindingResult){
        Map<String,String> map = new HashMap<>();
        List<FieldError> errorList = bindingResult.getFieldErrors();
        for(FieldError error : errorList){
            String field = error.getField();
            String message = error.getDefaultMessage();
            map.put(field,message);
        }
        return map;
    }

}
