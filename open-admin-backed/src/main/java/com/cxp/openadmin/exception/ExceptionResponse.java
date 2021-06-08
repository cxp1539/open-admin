package com.cxp.openadmin.exception;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class ExceptionResponse {

    private Integer code;
    private String message;
    private String url;

}
