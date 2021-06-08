package com.cxp.openadmin.exception.http;

public class VerifyException extends HttpException{
    public VerifyException(int code) {
        this.code = code;
        this.httpStatusCode = 401;
    }
}
