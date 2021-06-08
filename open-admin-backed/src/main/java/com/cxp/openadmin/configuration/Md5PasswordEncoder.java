package com.cxp.openadmin.configuration;

import com.cxp.openadmin.util.Md5Util;
import lombok.SneakyThrows;
import org.springframework.security.crypto.password.PasswordEncoder;

public class Md5PasswordEncoder implements PasswordEncoder {

    @SneakyThrows
    @Override
    public String encode(CharSequence charSequence) {
        return Md5Util.getMd5Str(charSequence.toString());
    }

    @SneakyThrows
    @Override
    public boolean matches(CharSequence charSequence, String s) {
        System.out.println(s);
        System.out.println(Md5Util.getMd5Str(charSequence.toString()));
        return s.equals(Md5Util.getMd5Str(charSequence.toString()));
    }

}
