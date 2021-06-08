package com.cxp.openadmin.exception.http;

public class OperatorException extends HttpException{

    public OperatorException(int code) {
        this.code = code;
        this.httpStatusCode = 400;
    }
}
