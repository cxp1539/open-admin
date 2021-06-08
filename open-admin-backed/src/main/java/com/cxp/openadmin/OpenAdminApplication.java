package com.cxp.openadmin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan("com.cxp.openadmin.dao")
@SpringBootApplication
public class OpenAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(OpenAdminApplication.class, args);
    }

}
