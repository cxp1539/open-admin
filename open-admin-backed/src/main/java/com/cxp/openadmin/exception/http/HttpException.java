package com.cxp.openadmin.exception.http;

import lombok.Data;

@Data
public class HttpException extends RuntimeException{
    protected Integer code;
    protected Integer httpStatusCode = 500;
}
