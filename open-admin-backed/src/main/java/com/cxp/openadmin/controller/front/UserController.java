package com.cxp.openadmin.controller.front;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo;
import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import com.cxp.openadmin.controller.BaseController;
import com.cxp.openadmin.domain.dto.front.BindMobileDTO;
import com.cxp.openadmin.domain.dto.front.UserLoginDTO;
import com.cxp.openadmin.domain.entity.User;
import com.cxp.openadmin.domain.vo.front.UserVo;
import com.cxp.openadmin.service.front.impl.UserServiceImpl;
import com.cxp.openadmin.util.JwtOperator;
import com.cxp.openadmin.util.HttpResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.error.WxErrorException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Api(value = "用户中心", tags = {"用户中心相关接口"})
@RestController
@RequestMapping("/front/user")
@Slf4j
public class UserController extends BaseController {

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private WxMaService wxMaService;

    @Autowired
    private JwtOperator jwtOperator;

    @ApiOperation(value = "小程序用户登录",notes = "小程序用户登录",httpMethod = "POST")
    @PostMapping("/login")
    public HttpResponse login(@RequestBody UserLoginDTO userLoginDTO) throws WxErrorException {

        WxMaJscode2SessionResult session = wxMaService.getUserService().getSessionInfo(userLoginDTO.getCode());
        String sessionKey = session.getSessionKey();

        WxMaUserInfo userInfo = wxMaService.getUserService().getUserInfo(sessionKey, userLoginDTO.getEncryptedData(), userLoginDTO.getIv());
        User user = userService.login(userInfo);
        Map<String,Object> map = new HashMap();
        map.put("id",user.getId());
        String token = jwtOperator.generateToken(map);
        UserVo userVo =  UserVo.builder().token(token).expireAt(jwtOperator.getExpirationDateFromToken(token)).user(user).build();

        return HttpResponse.success(userVo);

    }


    @ApiOperation(value = "绑定小程序用户手机号",notes = "绑定小程序用户手机号",httpMethod = "POST")
    @PostMapping("/bindMobile")
    public HttpResponse bindMobile(@RequestBody BindMobileDTO bindMobileDTO, HttpServletRequest request) throws WxErrorException {

        Integer userId = getPassportUserId(request);

        WxMaJscode2SessionResult session = wxMaService.getUserService().getSessionInfo(bindMobileDTO.getCode());
        String sessionKey = session.getSessionKey();
        WxMaPhoneNumberInfo wxMaPhoneNumberInfo = wxMaService.getUserService().getPhoneNoInfo(sessionKey, bindMobileDTO.getEncryptedData(), bindMobileDTO.getIv());
        userService.bindMobile(wxMaPhoneNumberInfo.getPhoneNumber(), userId);
        return HttpResponse.success();

    }


}
