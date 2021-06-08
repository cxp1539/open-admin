package com.cxp.openadmin.controller.backed;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.write.metadata.style.WriteCellStyle;
import com.alibaba.excel.write.metadata.style.WriteFont;
import com.alibaba.excel.write.style.HorizontalCellStyleStrategy;
import com.cxp.openadmin.controller.BaseController;
import com.cxp.openadmin.domain.entity.User;
import com.cxp.openadmin.domain.model.UserExcelProperty;
import com.cxp.openadmin.service.backed.impl.UserServiceImpl;
import com.cxp.openadmin.util.PagedGridResult;
import com.cxp.openadmin.util.HttpResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@RestController("backedUserController")
@RequestMapping("/backed/user")
@Slf4j
public class UserController extends BaseController {

    @Autowired
    private UserServiceImpl userService;

    @GetMapping("/list")
    public HttpResponse getUserList(@RequestParam(required = false) String nickname, @RequestParam Integer page, @RequestParam Integer pageSize){
        PagedGridResult grid = userService.getUserList(nickname, page,pageSize);
        return HttpResponse.success(grid);
    }

    @GetMapping("/export-excel")
    public void exportExcel(@RequestParam(required = false) String nickname, HttpServletResponse response) {

        ServletOutputStream outputStream = null;

        WriteCellStyle headWriteCellStyle = new WriteCellStyle();
        WriteFont headWriteFont = new WriteFont();
        headWriteFont.setFontHeightInPoints((short) 11);
        headWriteFont.setBold(false);
        headWriteCellStyle.setWriteFont(headWriteFont);

        WriteCellStyle contentWriteCellStyle = new WriteCellStyle();
        WriteFont contentWriteFont = new WriteFont();
        contentWriteFont.setFontHeightInPoints((short) 11);
        contentWriteCellStyle.setWriteFont(contentWriteFont);
        contentWriteCellStyle.setHorizontalAlignment(HorizontalAlignment.CENTER);

        HorizontalCellStyleStrategy styleStrategy =
                new HorizontalCellStyleStrategy(headWriteCellStyle, contentWriteCellStyle);

        List<User> userList = userService.getUserList(nickname);
        List<UserExcelProperty> list = new ArrayList<>();
        userList.forEach(user -> {
            UserExcelProperty item = new UserExcelProperty();
            BeanUtils.copyProperties(user, item);
            item.setGender(item.getGender().equals("1") ? "男" : item.getGender().equals("2") ? "女" : "未知");
            item.setStatus(user.getStatus() == 1 ? "正常" : "禁用");
            list.add(item);
        });

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setCharacterEncoding("utf-8");
            String name = URLEncoder.encode("用户列表.xlsx", "UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename*=UTF-8''"+name+".xlsx");

            outputStream = response.getOutputStream();
            EasyExcel.write(outputStream, UserExcelProperty.class)
                    .sheet()
                    .registerWriteHandler(styleStrategy)
                    .doWrite(list);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }


}
