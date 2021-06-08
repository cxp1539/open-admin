package com.cxp.openadmin.exception.http;

public class UploadException extends HttpException{
    public UploadException(int code) {
        this.code = code;
        this.httpStatusCode = 500;
    }
}
