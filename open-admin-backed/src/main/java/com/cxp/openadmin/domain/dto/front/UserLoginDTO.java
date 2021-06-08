package com.cxp.openadmin.domain.dto.front;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class UserLoginDTO {

    private String code;
    private String signature;
    private String encryptedData;
    private String iv;

}
