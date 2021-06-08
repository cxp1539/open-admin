package com.cxp.openadmin.util;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel(value = "HttpResponse")
@Data
public class HttpResponse {

    @ApiModelProperty(name = "code",value = "返回code,200正常，其他则为异常",required = true)
    private Integer code;

    @ApiModelProperty(name = "message",value = "相应信息",required = true)
    private String message;

    @ApiModelProperty(name = "data",value = "响应数据",required = true)
    private Object data;

    public HttpResponse(Object data) {
        this.code = 200;
        this.message = "OK";
        this.data = data;
    }

    public static HttpResponse success(Object data) {
        return new HttpResponse(data);
    }

    public static HttpResponse success() {
        return new HttpResponse(null);
    }

}
