package com.cxp.openadmin.service.backed.impl;

import com.cxp.openadmin.dao.*;
import com.cxp.openadmin.domain.dto.backed.*;
import com.cxp.openadmin.domain.entity.*;
import com.cxp.openadmin.domain.vo.backed.PermissionVo;
import com.cxp.openadmin.domain.vo.backed.RoleMenuAndMenuPermissionVo;
import com.cxp.openadmin.domain.vo.backed.SysMenuVo;
import com.cxp.openadmin.domain.vo.backed.SysRoleMenuPermissionVo;
import com.cxp.openadmin.exception.http.OperatorException;
import com.cxp.openadmin.exception.http.ParamException;
import com.cxp.openadmin.exception.http.VerifyException;
import com.cxp.openadmin.service.backed.SystemService;
import com.cxp.openadmin.util.Md5Util;
import com.cxp.openadmin.util.PagedGridResult;
import com.cxp.openadmin.util.TreeParser;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.Transformer;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;
import javax.annotation.Resource;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class SystemServiceImpl implements SystemService, UserDetailsService {

    @Resource
    private SysUserMapper sysUserMapper;

    @Resource
    private SysRoleMapper sysRoleMapper;

    @Resource
    private SysMenuMapper sysMenuMapper;

    @Resource
    private SysOperationLogMapper sysOperationLogMapper;

    @Resource
    private SysRoleMenuMapper sysRoleMenuMapper;

    @Resource
    private SysRoleMenuPermissionMapper sysRoleMenuPermissionMapper;

    @Resource
    private SysMenuCustomMapper sysMenuCustomMapper;

    @Resource
    private SysRoleMenuPermissionCustomMapper sysRoleMenuPermissionCustomMapper;

    @Value("${server-url}")
    private String serverUrl;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        SysUser sysUser = new SysUser();
        sysUser.setUsername(s);
        SysUser selectSysUser = sysUserMapper.selectOne(sysUser);
        SysRole sysrole = sysRoleMapper.selectByPrimaryKey(selectSysUser.getRoleId());
        JwtSysUserDto jwtSysUserDTO = new JwtSysUserDto(selectSysUser, sysrole);
        return jwtSysUserDTO;
    }

    @Override
    public SysUser getUserInfoById(Integer userId) {
        return sysUserMapper.selectByPrimaryKey(userId);
    }

    @Override
    public PagedGridResult getSysUserList(Integer page, Integer pageSize) {

        PageHelper.startPage(page,pageSize);

        List<SysUser> list = sysUserMapper.selectAll();
        PageInfo<?> pageList = new PageInfo<>(list);
        PagedGridResult grid = new PagedGridResult();
        grid.setPage(page);
        grid.setRows(list);
        grid.setTotal(pageList.getPages());
        grid.setRecords(pageList.getTotal());

        return grid;

    }

    @Override
    public List<SysUser> getSysUserList() {
        return sysUserMapper.selectAll();
    }


    @Override
    public void createSysUser(SaveSysUserDto saveSysUserDto) {

        SysUser sysUser = new SysUser();
        sysUser.setUsername(saveSysUserDto.getUsername());
        SysUser selectSysUser = sysUserMapper.selectOne(sysUser);

        if(selectSysUser != null){
            throw new VerifyException(1007);
        }

        try {
            sysUser.setAvatar(saveSysUserDto.getAvatar());
            sysUser.setUsername(saveSysUserDto.getUsername());
            sysUser.setPassword(Md5Util.getMd5Str(saveSysUserDto.getPassword()));
            sysUser.setRoleId(saveSysUserDto.getRoleId());
            sysUser.setName(saveSysUserDto.getName());
            sysUser.setAvatar(serverUrl+ "/img/avatar.png");
            sysUser.setStatus(saveSysUserDto.getStatus());
            sysUser.setCreatedTime(new Date());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        sysUserMapper.insertSelective(sysUser);

    }

    @Override
    public void updateSysUser(SaveSysUserDto saveSysUserDto) {
        SysUser sysUser = new SysUser();
        try {
            sysUser.setUsername(saveSysUserDto.getUsername());
            if(!StringUtils.isEmpty(saveSysUserDto.getPassword())){
                sysUser.setPassword(Md5Util.getMd5Str(saveSysUserDto.getPassword()));
            }
            sysUser.setId(saveSysUserDto.getId());
            sysUser.setRoleId(saveSysUserDto.getRoleId());
            sysUser.setName(saveSysUserDto.getName());
            sysUser.setStatus(saveSysUserDto.getStatus());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        sysUserMapper.updateByPrimaryKeySelective(sysUser);
    }

    @Override
    public void addMenu(SaveMenuDto saveMenuDto) {
        SysMenu sysMenu = new SysMenu();
        BeanUtils.copyProperties(saveMenuDto,sysMenu);
        sysMenu.setCreatedTime(new Date());
        sysMenuMapper.insert(sysMenu);
    }

    @Override
    public void editMenu(SaveMenuDto saveMenuDto) {
        SysMenu sysMenu = new SysMenu();
        BeanUtils.copyProperties(saveMenuDto,sysMenu);
        sysMenuMapper.updateByPrimaryKey(sysMenu);
    }

    @Transactional
    @Override
    public void deleteMenu(Integer menuId) {

        SysMenu sysMenu = new SysMenu();
        sysMenu.setParentId(menuId);
        Integer count = sysMenuMapper.selectCount(sysMenu);
        if(count > 0){
            throw new OperatorException(1011);
        }

        SysRoleMenuPermission sysRoleMenuPermission = new SysRoleMenuPermission();
        sysRoleMenuPermission.setMenuId(menuId);
        sysRoleMenuPermissionMapper.delete(sysRoleMenuPermission);

        Example example = new Example(SysRoleMenu.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andLike("menuIds","%"+menuId+"%");
        List<SysRoleMenu> sysRoleMenus = sysRoleMenuMapper.selectByExample(example);

        sysRoleMenus.forEach(item -> {
            List<String> inputMenuIds = Arrays.asList(item.getMenuIds().split(","));
            List<Integer> menuIdList = new ArrayList<>();
            CollectionUtils.collect(inputMenuIds, new Transformer() {
                @Override
                public Object transform(Object o) {
                    return Integer.valueOf(o.toString());
                }
            }, menuIdList);
            boolean ret = menuIdList.remove(menuId);
            if(ret){
                item.setMenuIds(String.join(",", menuIdList.stream().map(String::valueOf).collect(Collectors.toList())));
                sysRoleMenuMapper.updateByPrimaryKey(item);
            }
        });

        sysMenuMapper.deleteByPrimaryKey(menuId);

    }

    @Override
    public List<SysRole> getSysRoles() {
        Example example = new Example(SysRole.class);
        example.orderBy("createdTime").asc();
        return sysRoleMapper.selectByExample(example);
    }

    @Override
    public List<SysMenu> getMenuPermissions() {
        Example example = new Example(SysMenu.class);
        example.orderBy("sort").asc();
        Example.Criteria criteria = example.createCriteria();
        criteria.andNotEqualTo("permissions","");
        criteria.andNotEqualTo("permissions","[]");
        return sysMenuMapper.selectByExample(example);
    }


    @Override
    public void editSysRole(EditSysRoleDto editSysRoleDto) {

        SysRole sysRole = new SysRole();
        sysRole.setUniqueKey(editSysRoleDto.getUniqueKey());
        SysRole selectSysRole = sysRoleMapper.selectOne(sysRole);
        if(selectSysRole == null){
            BeanUtils.copyProperties(editSysRoleDto, selectSysRole);
            selectSysRole.setCreatedTime(new Date());
            sysRoleMapper.insertSelective(selectSysRole);
        }else {
            BeanUtils.copyProperties(editSysRoleDto, selectSysRole);
            sysRoleMapper.updateByPrimaryKeySelective(selectSysRole);
        }

    }

    @Override
    public void deleteSysRole(Integer roleId) {
        sysRoleMapper.deleteByPrimaryKey(roleId);
    }

    @Override
    public List<SysMenuVo> getRoleMenus(Integer roleId) {
        SysRoleMenu sysRoleMenu = new SysRoleMenu();
        sysRoleMenu.setRoleId(roleId);
        SysRoleMenu selectSysRoleMenu = sysRoleMenuMapper.selectOne(sysRoleMenu);
        if(selectSysRoleMenu != null && StringUtils.isNotBlank(selectSysRoleMenu.getMenuIds())){
            String menuIds = selectSysRoleMenu.getMenuIds();
            String[] ids = menuIds.split(",");
            List<SysMenu> sysMenus =  sysMenuCustomMapper.findMenuByIds(ids);
            List<SysMenuVo> list = new ArrayList<>();
            sysMenus.forEach(item -> {
                SysMenuVo sysMenuVo = new SysMenuVo();
                BeanUtils.copyProperties(item,sysMenuVo);
                list.add(sysMenuVo);
            });
            return TreeParser.getTreeList(0, list);
        }else{
            return new ArrayList<>();
        }

    }

    @Override
    public List<SysRoleMenuPermissionVo> getRoleMenuPermissons(Integer roleId) {
        HashMap<String,Integer> map = new HashMap<>();
        map.put("roleId", roleId);
        return sysRoleMenuPermissionCustomMapper.getRoleMenuPermissons(map);
    }

    @Override
    public void saveRoleMenus(SaveRoleMenusDto saveRoleMenusDto){

        SysRoleMenu sysRoleMenu = new SysRoleMenu();
        sysRoleMenu.setRoleId(saveRoleMenusDto.getRoleId());
        SysRoleMenu selectSysRoleMenu = sysRoleMenuMapper.selectOne(sysRoleMenu);
        if(selectSysRoleMenu == null){
            SysRoleMenu insertSysRoleMenu = new SysRoleMenu();
            insertSysRoleMenu.setRoleId(saveRoleMenusDto.getRoleId());
            insertSysRoleMenu.setMenuIds(saveRoleMenusDto.getMenuIds());
            insertSysRoleMenu.setCreatedTime(new Date());
            sysRoleMenuMapper.insertSelective(insertSysRoleMenu);
        }else {
            selectSysRoleMenu.setMenuIds(saveRoleMenusDto.getMenuIds());
            sysRoleMenuMapper.updateByPrimaryKeySelective(selectSysRoleMenu);
        }

    }

    @Override
    public void saveRoleMenuPermissons(SaveRoleMenuPermissonsDto saveRoleMenuPermissonsDto){
        List<SysRoleMenuPermissonsDto> roleMenuPermissonsDtos = saveRoleMenuPermissonsDto.getPermissions();
        for (SysRoleMenuPermissonsDto roleMenuPermissonsDto: roleMenuPermissonsDtos) {
            SysRoleMenuPermission roleMenuPermission = new SysRoleMenuPermission();
            roleMenuPermission.setRoleId(saveRoleMenuPermissonsDto.getRoleId());
            roleMenuPermission.setMenuId(roleMenuPermissonsDto.getMenuId());
            SysRoleMenuPermission selectRolePermissions = sysRoleMenuPermissionMapper.selectOne(roleMenuPermission);
            if(selectRolePermissions == null && !"[]".equals(roleMenuPermissonsDto.getOperation())){
                roleMenuPermission.setOperation(roleMenuPermissonsDto.getOperation());
                roleMenuPermission.setCreatedTime(new Date());
                sysRoleMenuPermissionMapper.insertSelective(roleMenuPermission);
            }else{
                if(!"[]".equals(roleMenuPermissonsDto.getOperation())){
                    selectRolePermissions.setOperation(roleMenuPermissonsDto.getOperation());
                    sysRoleMenuPermissionMapper.updateByPrimaryKeySelective(selectRolePermissions);
                }
            }
        }
    }

    @Override
    public RoleMenuAndMenuPermissionVo getMenuAndMenuPermissions(Integer roleId){
        SysRoleMenu sysRoleMenu = new SysRoleMenu();
        sysRoleMenu.setRoleId(roleId);
        SysRoleMenu selectRoleMenu = sysRoleMenuMapper.selectOne(sysRoleMenu);

        SysRoleMenuPermission sysRoleMenuPermission = new SysRoleMenuPermission();
        sysRoleMenuPermission.setRoleId(roleId);
        List<SysRoleMenuPermission> sysRoleMenuPermissions = sysRoleMenuPermissionMapper.select(sysRoleMenuPermission);

        RoleMenuAndMenuPermissionVo roleMenuAndMenuPermissionVo = new RoleMenuAndMenuPermissionVo();

        if(selectRoleMenu != null){
            roleMenuAndMenuPermissionVo.setMenuIds(selectRoleMenu.getMenuIds());
        }else{
            roleMenuAndMenuPermissionVo.setMenuIds("");
        }
        List<PermissionVo> permissionVos = new ArrayList<>();
        sysRoleMenuPermissions.forEach(item->{
            PermissionVo permissionVo = new PermissionVo();
            permissionVo.setMenuId(item.getMenuId());
            permissionVo.setOperation(item.getOperation());
            permissionVos.add(permissionVo);
        });

        roleMenuAndMenuPermissionVo.setPermissions(permissionVos);

        return roleMenuAndMenuPermissionVo;

    }

    @Override
    public PagedGridResult getOperactionLogList(Date startTime, Date endTime, String operationId, Integer page, Integer pageSize) {

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        PageHelper.startPage(page,pageSize);
        Example example = new Example(SysOperationLog.class);

        example.orderBy("createdTime").desc();
        Example.Criteria criteria = example.createCriteria();

        if(!StringUtils.isBlank(operationId)){
            criteria.andEqualTo("operationId",operationId);
        }
        if(startTime != null){
            criteria.andGreaterThanOrEqualTo("createdTime",simpleDateFormat.format(startTime));
        }
        if(endTime != null){
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(endTime);
            calendar.add(calendar.DATE,1);
            endTime=calendar.getTime();
            criteria.andLessThanOrEqualTo("createdTime",simpleDateFormat.format(endTime));
        }

        List<SysOperationLog> list= sysOperationLogMapper.selectByExample(example);

        PageInfo<?> pageList = new PageInfo<>(list);
        PagedGridResult grid = new PagedGridResult();
        grid.setPage(page);
        grid.setRows(list);
        grid.setTotal(pageList.getPages());
        grid.setRecords(pageList.getTotal());

        return grid;
    }

    @Override
    public void settingSysUserInfo(SettingSysUserInfoDto settingSysUserInfoDto, Integer userId) {

        SysUser sysUser = new SysUser();
        sysUser.setId(userId);
        if(!StringUtils.isBlank(settingSysUserInfoDto.getName())){
            sysUser.setName(settingSysUserInfoDto.getName());
        }
        if(!StringUtils.isBlank(settingSysUserInfoDto.getAvatar())){
            sysUser.setAvatar(settingSysUserInfoDto.getAvatar());
        }
        sysUserMapper.updateByPrimaryKeySelective(sysUser);
    }

    @Override
    public void settingSysUserPassword(SettingSysUserPasswordDto settingSysUserPasswordDto, Integer userId) {

        SysUser selectSysUser = sysUserMapper.selectByPrimaryKey(userId);

        SysUser sysUser = new SysUser();
        sysUser.setId(userId);
        try {
            if(!Md5Util.getMd5Str(settingSysUserPasswordDto.getSourcePassword()).equals(selectSysUser.getPassword())){
                throw new ParamException(1009);
            }

            if(!settingSysUserPasswordDto.getPassword().equals(settingSysUserPasswordDto.getConfirmPassword())){
                throw new ParamException(1010);
            }

            sysUser.setPassword(Md5Util.getMd5Str(settingSysUserPasswordDto.getPassword()));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        sysUserMapper.updateByPrimaryKeySelective(sysUser);

    }

    @Override
    public List<SysMenuVo> getSysMenus() {

        Example example = new Example(SysMenu.class);

        example.orderBy("sort").asc();
        Example.Criteria criteria = example.createCriteria();

        List<SysMenu> sysMenus = sysMenuMapper.selectByExample(example);

        List<SysMenuVo> list = new ArrayList<>();

        sysMenus.forEach(item -> {
            SysMenuVo sysMenuVo = new SysMenuVo();
            BeanUtils.copyProperties(item,sysMenuVo);
            list.add(sysMenuVo);
        });

        return TreeParser.getTreeList(0, list);

    }

    @Override
    public void logout() {

    }

}
