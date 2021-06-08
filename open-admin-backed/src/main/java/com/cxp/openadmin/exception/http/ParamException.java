package com.cxp.openadmin.exception.http;

public class ParamException extends HttpException{
    public ParamException(int code) {
        this.code = code;
        this.httpStatusCode = 400;
    }

}
