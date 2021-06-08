package com.cxp.openadmin.domain.dto.front;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class BindMobileDTO {

    private String code;
    private String encryptedData;
    private String iv;

}
