package com.cxp.openadmin.exception;

import com.cxp.openadmin.configuration.ExceptionCodeConfiguration;
import com.cxp.openadmin.exception.http.HttpException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionAdvice {

    final static Logger logger = LoggerFactory.getLogger(GlobalExceptionAdvice.class);

    @Autowired
    private ExceptionCodeConfiguration exceptionCodeConfiguration;


    @ExceptionHandler(value=Exception.class)
    @ResponseBody
    @ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
    public ExceptionResponse handleException(HttpServletRequest request, Exception e){
        ExceptionResponse result = new ExceptionResponse(99999,e.toString(),request.getMethod()+':'+request.getRequestURI());
        logger.error(e.toString());
        return result;
    }


    @ExceptionHandler(value= HttpException.class)
    public ResponseEntity<ExceptionResponse> handleHttpException(HttpServletRequest request, HttpException e){
        ExceptionResponse result = new ExceptionResponse(e.getCode(),exceptionCodeConfiguration.getMessageByCode(e.getCode()),request.getMethod()+':'+request.getRequestURI());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        //HttpStatus status = HttpStatus.resolve(e.getHttpStatusCode());
        HttpStatus status = HttpStatus.OK;
        ResponseEntity<ExceptionResponse> re = new ResponseEntity<>(result,headers,status);
        return re;
    }

}