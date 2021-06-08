package com.cxp.openadmin.domain.model;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.metadata.BaseRowModel;
import lombok.Data;
import java.util.Date;

@Data
public class UserExcelProperty extends BaseRowModel {

    @ExcelProperty(value = "Id", index = 0)
    private Integer id;

    @ExcelProperty(value = "昵称", index = 1)
    private String nickname;

    @ExcelProperty(value = "手机号", index = 2)
    private String mobile;

    @ExcelProperty(value = "性别", index = 3)
    private String gender;

    @ExcelProperty(value = "用户状态", index = 4)
    private String status;

    @ExcelProperty(value = "创建时间", index = 5)
    private Date createdTime;

}
