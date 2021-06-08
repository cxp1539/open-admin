package com.cxp.openadmin.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import java.util.HashMap;
import java.util.Map;

@ConfigurationProperties(prefix = "error")
@PropertySource(value = "classpath:exception-code.properties")
@Component
public class ExceptionCodeConfiguration {

    public Map<Integer, String> getCodes() {
        return codes;
    }

    public void setCodes(Map<Integer, String> codes) {
        this.codes = codes;
    }

    private Map<Integer,String> codes = new HashMap<>();

    public String getMessageByCode(Integer code){
        return codes.get(code);
    }

}
