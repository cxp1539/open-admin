package com.cxp.openadmin.domain.vo.front;

import com.cxp.openadmin.domain.entity.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class UserVo {

    private String token;
    private Date expireAt;
    private User user;

}
