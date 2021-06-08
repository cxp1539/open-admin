package com.cxp.openadmin.exception.http;

public class FordiddenException extends HttpException{
    public FordiddenException(int code) {
        this.code = code;
        this.httpStatusCode = 403;
    }
}
