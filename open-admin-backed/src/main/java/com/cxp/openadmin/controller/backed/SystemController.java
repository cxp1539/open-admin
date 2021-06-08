package com.cxp.openadmin.controller.backed;

import com.cxp.openadmin.controller.BaseController;
import com.cxp.openadmin.domain.dto.backed.*;
import com.cxp.openadmin.domain.entity.SysUser;
import com.cxp.openadmin.exception.http.ParamException;
import com.cxp.openadmin.service.backed.SystemService;
import com.cxp.openadmin.util.PagedGridResult;
import com.cxp.openadmin.util.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/backed/system")
public class SystemController extends BaseController {

    @Autowired
    private SystemService systemService;

    @GetMapping("/roles")
    public HttpResponse roles(){
        return HttpResponse.success(systemService.getSysRoles());
    }

    @PostMapping("/edit-role")
    public HttpResponse editRole(@RequestBody EditSysRoleDto editSysRoleDto){
        systemService.editSysRole(editSysRoleDto);
        return HttpResponse.success();
    }

    @PostMapping("/delete-role")
    public HttpResponse deleteRole(@RequestParam Integer roleId){
        systemService.deleteSysRole(roleId);
        return HttpResponse.success();
    }

    @GetMapping("/menus")
    public HttpResponse menus(){
        return HttpResponse.success(systemService.getSysMenus());
    }

    @PostMapping("/delete-menu")
    public HttpResponse deleteMenu(@RequestParam Integer menuId){
        systemService.deleteMenu(menuId);
        return HttpResponse.success();
    }

    @PostMapping("/add-menu")
    public HttpResponse addMenu(@RequestBody SaveMenuDto saveMenuDto){
        systemService.addMenu(saveMenuDto);
        return HttpResponse.success();
    }

    @PostMapping("/edit-menu")
    public HttpResponse editMenu(@RequestBody SaveMenuDto saveMenuDto){
        systemService.editMenu(saveMenuDto);
        return HttpResponse.success();
    }

    @GetMapping("/menu-permissions")
    public HttpResponse menuPermissions(){
        return HttpResponse.success(systemService.getMenuPermissions());
    }


    @PostMapping("/save-role-menus")
    public HttpResponse saveRoleMenus(@RequestBody SaveRoleMenusDto saveRoleMenusDto){
        systemService.saveRoleMenus(saveRoleMenusDto);
        return HttpResponse.success();
    }

    @PostMapping("/save-role-menu-permissons")
    public HttpResponse saveRoleMenuPermissons(@RequestBody SaveRoleMenuPermissonsDto saveRoleMenuPermissonsDto){
        systemService.saveRoleMenuPermissons(saveRoleMenuPermissonsDto);
        return HttpResponse.success();
    }

    @GetMapping("/menu-and-menu-permissions")
    public HttpResponse getMenuAndMenuPermissions(@RequestParam Integer roleId){
        return HttpResponse.success(systemService.getMenuAndMenuPermissions(roleId));
    }

    @GetMapping("/sysuser-list")
    public HttpResponse getSysUserList(@RequestParam(required = false) Integer page, @RequestParam(required = false) Integer pageSize){
        if(page == null && pageSize == null){
            List<SysUser> list = systemService.getSysUserList();
            for (SysUser sysUser: list) {
                sysUser.setPassword(null);
            }
            return HttpResponse.success(list);
        }else{
            PagedGridResult grid = systemService.getSysUserList(page,pageSize);
            List<SysUser> list = (List<SysUser>) grid.getRows();
            for (SysUser sysUser: list) {
                sysUser.setPassword(null);
            }
            return HttpResponse.success(grid);
        }
    }

    @PostMapping("/create-sysuser")
    public HttpResponse createSysUser(@RequestBody SaveSysUserDto saveSysUserDto){
        systemService.createSysUser(saveSysUserDto);
        return HttpResponse.success();
    }

    @PostMapping("/update-sysuser")
    public HttpResponse updateSysUser(@RequestBody SaveSysUserDto saveSysUserDto){
        systemService.updateSysUser(saveSysUserDto);
        return HttpResponse.success();
    }

    @PostMapping("/set-sysuser-info")
    public HttpResponse settingSysUserInfo(@RequestBody SettingSysUserInfoDto settingSysUserInfoDto, HttpServletRequest request){
        Integer userId = getPassportUserId(request);
        systemService.settingSysUserInfo(settingSysUserInfoDto,userId);
        return HttpResponse.success();
    }

    @PostMapping("/set-sysuser-password")
    public HttpResponse settingSysUserPassword(@RequestBody @Valid SettingSysUserPasswordDto settingSysUserPasswordDto, BindingResult bindingResult, HttpServletRequest request){

        if(bindingResult.hasErrors()){
            Map<String,String> errorsMap = getBindingResultErrors(bindingResult);
            String errCode = errorsMap.entrySet().iterator().next().getValue();
            throw new ParamException(Integer.parseInt(errCode));
        }
        Integer userId = getPassportUserId(request);
        systemService.settingSysUserPassword(settingSysUserPasswordDto,userId);
        return HttpResponse.success();
    }

    @PostMapping("/logout")
    public HttpResponse logout(){
        systemService.logout();
        return HttpResponse.success();
    }

    @GetMapping("/log-list")
    public HttpResponse getLogList(
            @RequestParam(required = false) Date startTime,
            @RequestParam(required = false) Date endTime,
            @RequestParam(required = false) String operationId,
            @RequestParam Integer page,
            @RequestParam Integer pageSize
    ){
        PagedGridResult grid = systemService.getOperactionLogList(startTime, endTime, operationId, page,pageSize);
        return HttpResponse.success(grid);
    }


}
