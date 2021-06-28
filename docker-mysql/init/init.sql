use mysql;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
flush privileges;

create database open_admin;
use open_admin;


/*
 Navicat Premium Data Transfer

 Source Server         : water
 Source Server Type    : MySQL
 Source Server Version : 50648
 Source Host           : 116.63.145.108:3306
 Source Schema         : open_admin

 Target Server Type    : MySQL
 Target Server Version : 50648
 File Encoding         : 65001

 Date: 22/06/2021 14:20:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路径',
  `invisible` tinyint(1) NULL DEFAULT 0 COMMENT '是否隐藏菜单，0: 不隐藏, 1:隐藏',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父节点Id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `cache_able` tinyint(1) NULL DEFAULT 0 COMMENT '是否缓存菜单，0: 不缓存, 1:缓存',
  `sort` int(11) NULL DEFAULT 0 COMMENT '菜单排序',
  `component` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组件名称',
  `permissions` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作权限',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统菜单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 'workplace', 0, 0, '工作台', 'dashboard', 0, 1, 'Workplace', '', '2021-04-21 11:19:38');
INSERT INTO `sys_menu` VALUES (2, 'user', 0, 0, '用户管理', 'user', 0, 3, 'PageView', '', '2021-04-21 11:24:22');
INSERT INTO `sys_menu` VALUES (3, 'list', 0, 2, '用户列表', '', 0, 3, 'UserList', '', '2021-05-10 18:37:34');
INSERT INTO `sys_menu` VALUES (4, 'system', 0, 0, '系统管理', 'setting', 0, 4, 'PageView', '', '2021-04-21 11:24:49');
INSERT INTO `sys_menu` VALUES (5, 'form', 0, 0, '表单页', 'form', 0, 5, 'PageView', '', '2021-04-21 11:25:19');
INSERT INTO `sys_menu` VALUES (6, 'list', 0, 0, '列表页', 'table', 0, 6, 'PageView', '', '2021-04-21 11:25:42');
INSERT INTO `sys_menu` VALUES (7, 'details', 0, 0, '详情页', 'profile', 0, 7, 'PageView', '', '2021-04-21 11:26:59');
INSERT INTO `sys_menu` VALUES (8, 'result', 0, 0, '结果页', 'check-circle-o', 0, 8, 'PageView', '', '2021-04-21 11:27:19');
INSERT INTO `sys_menu` VALUES (9, 'components', 0, 0, '内置组件', 'appstore-o', 0, 9, 'PageView', '', '2021-04-21 11:27:57');
INSERT INTO `sys_menu` VALUES (10, 'auth-form', 0, 0, '验权表单', 'file-excel', 0, 10, 'AuthForm', '', '2021-04-21 11:28:39');
INSERT INTO `sys_menu` VALUES (12, 'users', 0, 4, '系统用户', '', 0, 12, 'SystemUserList', '', '2021-05-08 19:06:11');
INSERT INTO `sys_menu` VALUES (13, 'menus', 0, 4, '系统菜单', '', 0, 13, 'MenuList', '', '2021-05-08 19:06:49');
INSERT INTO `sys_menu` VALUES (14, 'roles', 0, 4, '系统角色', '', 0, 14, 'RoleList', '', '2021-05-08 19:07:18');
INSERT INTO `sys_menu` VALUES (15, 'logs', 0, 4, '系统日志', '', 0, 15, 'LogList', '', '2021-05-08 19:07:44');
INSERT INTO `sys_menu` VALUES (16, 'basic', 0, 5, '基础表单', '', 0, 16, 'FormBasic', '', '2021-05-09 17:30:52');
INSERT INTO `sys_menu` VALUES (17, 'step', 0, 5, '分步表单', '', 0, 17, 'FormStep', '', '2021-05-09 17:31:25');
INSERT INTO `sys_menu` VALUES (18, 'advance', 0, 5, '高级表单', '', 0, 18, 'FormAdvance', '', '2021-05-09 17:32:30');
INSERT INTO `sys_menu` VALUES (19, 'query', 0, 6, '查询表格', '', 0, 19, 'QueryList', '[{\"action\":\"delete\",\"describe\":\"删除\"}]', '2021-05-11 11:42:53');
INSERT INTO `sys_menu` VALUES (20, 'primary', 0, 6, '标准列表', '', 0, 20, 'StandardList', '', '2021-05-09 17:33:23');
INSERT INTO `sys_menu` VALUES (21, 'card', 0, 6, '卡片列表', '', 0, 21, 'CardList', '', '2021-05-09 17:33:48');
INSERT INTO `sys_menu` VALUES (22, 'advance', 0, 7, '高级详情页', '', 0, 22, 'AdvancedDetail', '', '2021-05-09 17:34:22');
INSERT INTO `sys_menu` VALUES (23, 'success', 0, 8, '成功', '', 0, 23, 'Success', '', '2021-05-09 17:34:46');
INSERT INTO `sys_menu` VALUES (24, 'error', 0, 8, '失败', '', 0, 24, 'Error', '', '2021-05-09 17:35:08');
INSERT INTO `sys_menu` VALUES (25, 'table', 0, 9, '高级表格', '', 0, 25, 'SeniorTable', '', '2021-05-09 17:35:40');

-- ----------------------------
-- Table structure for sys_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operation_log`;
CREATE TABLE `sys_operation_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `operation_id` int(11) NOT NULL COMMENT '操作人id',
  `url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作类型',
  `method` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方法',
  `params` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `browser` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器类型',
  `ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作ip',
  `take_time` int(11) NULL DEFAULT NULL COMMENT '执行时长',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 476 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_operation_log
-- ----------------------------
INSERT INTO `sys_operation_log` VALUES (35, 1, '/system/deleteRole', 'POST', '[\"rebot\"]', 'Chrome 8', '127.0.0.1', 197, '2021-03-17 16:10:52');
INSERT INTO `sys_operation_log` VALUES (36, 1, '/system/deleteRole', 'POST', '[\"review\"]', 'Chrome 8', '127.0.0.1', 207, '2021-03-17 16:10:59');
INSERT INTO `sys_operation_log` VALUES (37, 1, '/system/editPermission', 'POST', '[{\"id\":\"admin\",\"name\":\"系统管理\",\"operation\":\"[{\\\"action\\\":\\\"query\\\",\\\"describe\\\":\\\"查询\\\"},{\\\"action\\\":\\\"get\\\",\\\"describe\\\":\\\"编辑\\\"}]\",\"remark\":\"系统管理\"}]', 'Chrome 8', '127.0.0.1', 153, '2021-03-18 16:02:48');
INSERT INTO `sys_operation_log` VALUES (38, 1, '/system/editPermission', 'POST', '[{\"id\":\"admin\",\"name\":\"系统管理\",\"operation\":\"[{\\\"action\\\":\\\"query\\\",\\\"describe\\\":\\\"查询\\\"},{\\\"action\\\":\\\"get\\\",\\\"describe\\\":\\\"编辑\\\"}]\",\"remark\":\"系统管理\"}]', 'Chrome 8', '127.0.0.1', 136, '2021-03-18 16:02:52');
INSERT INTO `sys_operation_log` VALUES (39, 1, '/system/deletePermission', 'POST', '[\"review\"]', 'Chrome 8', '127.0.0.1', 112, '2021-03-18 16:02:55');
INSERT INTO `sys_operation_log` VALUES (40, 1, '/system/editPermission', 'POST', '[{\"id\":\"111\",\"name\":\"11\",\"operation\":\"11\",\"remark\":\"111\"}]', 'Chrome 8', '127.0.0.1', 184, '2021-03-18 16:04:18');
INSERT INTO `sys_operation_log` VALUES (41, 1, '/system/deletePermission', 'POST', '[\"111\"]', 'Chrome 8', '127.0.0.1', 108, '2021-03-18 16:04:29');
INSERT INTO `sys_operation_log` VALUES (42, 1, '/system/editPermission', 'POST', '[{\"id\":\"111\",\"name\":\"11\",\"operation\":\"11\",\"remark\":\"11\"}]', 'Chrome 8', '127.0.0.1', 156, '2021-03-18 16:05:11');
INSERT INTO `sys_operation_log` VALUES (43, 1, '/system/deletePermission', 'POST', '[\"111\"]', 'Chrome 8', '127.0.0.1', 107, '2021-03-18 16:07:00');
INSERT INTO `sys_operation_log` VALUES (44, 1, '/system/editPermission', 'POST', '[{\"id\":\"111\",\"name\":\"111\",\"operation\":\"111\",\"remark\":\"111\"}]', 'Chrome 8', '127.0.0.1', 142, '2021-03-18 16:07:08');
INSERT INTO `sys_operation_log` VALUES (45, 1, '/system/deletePermission', 'POST', '[\"111\"]', 'Chrome 8', '127.0.0.1', 105, '2021-03-18 16:07:36');
INSERT INTO `sys_operation_log` VALUES (46, 1, '/system/editPermission', 'POST', '[{\"id\":\"222\",\"name\":\"222\",\"operation\":\"222\",\"remark\":\"222\"}]', 'Chrome 8', '127.0.0.1', 122, '2021-03-18 16:07:48');
INSERT INTO `sys_operation_log` VALUES (47, 1, '/system/deletePermission', 'POST', '[\"222\"]', 'Chrome 8', '127.0.0.1', 104, '2021-03-18 16:12:18');
INSERT INTO `sys_operation_log` VALUES (48, 1, '/system/editPermission', 'POST', '[{\"id\":\"111\",\"name\":\"11\",\"operation\":\"11\"}]', 'Chrome 8', '127.0.0.1', 150, '2021-03-18 16:15:17');
INSERT INTO `sys_operation_log` VALUES (49, 1, '/system/deletePermission', 'POST', '[\"111\"]', 'Chrome 8', '127.0.0.1', 108, '2021-03-18 16:15:22');
INSERT INTO `sys_operation_log` VALUES (50, 1, '/system/editPermission', 'POST', '[{\"id\":\"111\",\"name\":\"111\",\"operation\":\"{\\\"aaa\\\":\\\"bb\\\"}\"}]', 'Chrome 8', '127.0.0.1', 141, '2021-03-18 16:24:10');
INSERT INTO `sys_operation_log` VALUES (51, 1, '/system/deletePermission', 'POST', '[\"111\"]', 'Chrome 8', '127.0.0.1', 92, '2021-03-18 16:24:16');
INSERT INTO `sys_operation_log` VALUES (52, 1, '/system/editRole', 'POST', '[{\"id\":\"verify\",\"name\":\"审核组\",\"permissions\":[{\"permissionId\":\"admin\",\"roleId\":\"verify\"},{\"permissionId\":\"verify\",\"roleId\":\"verify\"},{\"permissionId\":\"statistics\",\"roleId\":\"verify\"}],\"remark\":\"审核组\"}]', 'Chrome 8', '127.0.0.1', 391, '2021-03-18 17:19:05');
INSERT INTO `sys_operation_log` VALUES (53, 1, '/system/editRole', 'POST', '[{\"id\":\"admin\",\"name\":\"管理员\",\"permissions\":[{\"permissionId\":\"admin\",\"roleId\":\"admin\"},{\"permissionId\":\"verify\",\"roleId\":\"admin\"},{\"permissionId\":\"statistics\",\"roleId\":\"admin\"}],\"remark\":\"拥有所有权限\"}]', 'Chrome 8', '127.0.0.1', 387, '2021-03-18 17:19:34');
INSERT INTO `sys_operation_log` VALUES (54, 1, '/system/deletePermission', 'POST', '[\"verify\"]', 'Chrome 8', '127.0.0.1', 114, '2021-03-18 17:20:16');
INSERT INTO `sys_operation_log` VALUES (55, 1, '/system/editRole', 'POST', '[{\"id\":\"aaa\",\"name\":\"aaa\",\"permissions\":[{\"permissionId\":\"admin\",\"roleId\":\"aaa\"},{\"permissionId\":\"statistics\",\"roleId\":\"aaa\"}],\"remark\":\"aaaa\"}]', 'Chrome 8', '127.0.0.1', 314, '2021-03-18 17:22:04');
INSERT INTO `sys_operation_log` VALUES (56, 1, '/system/deleteRole', 'POST', '[\"aaa\"]', 'Chrome 8', '127.0.0.1', 170, '2021-03-18 17:24:26');
INSERT INTO `sys_operation_log` VALUES (57, 1, '/system/editRole', 'POST', '[{\"id\":\"aaa\",\"name\":\"aaa\",\"permissions\":[{\"operation\":\"[{\\\"action\\\":\\\"query\\\",\\\"describe\\\":\\\"查询\\\"},{\\\"action\\\":\\\"get\\\",\\\"describe\\\":\\\"编辑\\\"}]\",\"permissionId\":\"admin\",\"roleId\":\"aaa\"},{\"operation\":\"[{\\\"action\\\":\\\"query\\\",\\\"describe\\\":\\\"查询\\\"}]\",\"permissionId\":\"statistics\",\"roleId\":\"aaa\"}],\"remark\":\"aaa\"}]', 'Chrome 8', '127.0.0.1', 301, '2021-03-18 17:24:36');
INSERT INTO `sys_operation_log` VALUES (58, 1, '/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-19 14:38:31');
INSERT INTO `sys_operation_log` VALUES (59, 1, '/system/deleteRole', 'POST', '[\"aaa\"]', 'Chrome 8', '127.0.0.1', 164, '2021-03-19 17:04:39');
INSERT INTO `sys_operation_log` VALUES (60, 1, '/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-22 09:37:06');
INSERT INTO `sys_operation_log` VALUES (61, 1, '/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-22 09:38:18');
INSERT INTO `sys_operation_log` VALUES (62, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-22 11:20:08');
INSERT INTO `sys_operation_log` VALUES (63, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-22 11:23:07');
INSERT INTO `sys_operation_log` VALUES (64, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-22 14:39:26');
INSERT INTO `sys_operation_log` VALUES (65, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-22 14:39:43');
INSERT INTO `sys_operation_log` VALUES (66, 1, '/backed/system/setSysUserPassword', 'POST', '[{\"confirmPassword\":\"Aa123456!\",\"password\":\"Aa123456!\",\"sourcePassword\":\"111111\"},1]', 'Chrome 8', '127.0.0.1', 240, '2021-03-22 14:46:30');
INSERT INTO `sys_operation_log` VALUES (67, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"name\":\"管理员\"},1]', 'Chrome 8', '127.0.0.1', 154, '2021-03-22 15:13:05');
INSERT INTO `sys_operation_log` VALUES (68, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"name\":\"管理员\"},1]', 'Chrome 8', '127.0.0.1', 118, '2021-03-22 15:14:03');
INSERT INTO `sys_operation_log` VALUES (69, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"name\":\"管理员\"},1]', 'Chrome 8', '127.0.0.1', 118, '2021-03-22 15:14:26');
INSERT INTO `sys_operation_log` VALUES (70, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"name\":\"管理员1\"},1]', 'Chrome 8', '127.0.0.1', 121, '2021-03-22 15:14:28');
INSERT INTO `sys_operation_log` VALUES (71, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"name\":\"管理员\"},1]', 'Chrome 8', '127.0.0.1', 116, '2021-03-22 15:14:59');
INSERT INTO `sys_operation_log` VALUES (72, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"name\":\"管理员\"},1]', 'Chrome 8', '127.0.0.1', 116, '2021-03-22 15:15:00');
INSERT INTO `sys_operation_log` VALUES (73, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"name\":\"管理员\"},1]', 'Chrome 8', '127.0.0.1', 116, '2021-03-22 15:15:15');
INSERT INTO `sys_operation_log` VALUES (74, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/536bce8c-f8da-4cc3-8941-d4cd52ef4d8b.undefined\"},1]', 'Chrome 8', '127.0.0.1', 136, '2021-03-22 15:43:46');
INSERT INTO `sys_operation_log` VALUES (75, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/bdbd8e1f-b1a7-4da5-93f7-63a8adc9e265.undefined\"},1]', 'Chrome 8', '127.0.0.1', 97, '2021-03-22 15:47:03');
INSERT INTO `sys_operation_log` VALUES (76, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/15adca40-b457-4ac5-a6f9-bd4f4f629f56.undefined\"},1]', 'Chrome 8', '127.0.0.1', 139, '2021-03-22 15:51:11');
INSERT INTO `sys_operation_log` VALUES (77, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/25597c71-ca9c-43bb-ab39-fe9677c769cb.undefined\"},1]', 'Chrome 8', '127.0.0.1', 148, '2021-03-22 15:53:40');
INSERT INTO `sys_operation_log` VALUES (78, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/0df2179e-9535-4657-9262-b6a214f18c99.undefined\"},1]', 'Chrome 8', '127.0.0.1', 101, '2021-03-22 15:54:33');
INSERT INTO `sys_operation_log` VALUES (79, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/6b1a3b08-e62d-48b3-9bb2-c3c7a3f7cbb3.undefined\"},1]', 'Chrome 8', '127.0.0.1', 94, '2021-03-22 15:57:56');
INSERT INTO `sys_operation_log` VALUES (80, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/b668f1c6-f373-4154-8247-7695eee49ebd.jpeg\"},1]', 'Chrome 8', '127.0.0.1', 96, '2021-03-22 16:00:51');
INSERT INTO `sys_operation_log` VALUES (81, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/6a348c28-6aba-49a5-be74-107cf50e77a4.jpeg\"},1]', 'Chrome 8', '127.0.0.1', 94, '2021-03-22 16:04:23');
INSERT INTO `sys_operation_log` VALUES (82, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/xq/avatar/0aee3d3a-ce3a-4030-8bb8-24eb57384fef.jpeg\"},1]', 'Chrome 8', '127.0.0.1', 96, '2021-03-22 16:07:05');
INSERT INTO `sys_operation_log` VALUES (83, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/static/xq/avatar/9448b854-f56c-4681-88b6-21cbd74cc5b9.jpeg\"},1]', 'Chrome 8', '127.0.0.1', 111, '2021-03-22 16:12:48');
INSERT INTO `sys_operation_log` VALUES (84, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/static/xq/avatar/f1f2d4f6-66f3-4d7e-a13b-17bf1e1f5d6f.jpeg\"},1]', 'Chrome 8', '127.0.0.1', 110, '2021-03-22 16:14:10');
INSERT INTO `sys_operation_log` VALUES (85, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/static/xq/avatar/d26c41aa-005c-47f9-ba9f-e82aee24c8da.jpeg\"},1]', 'Chrome 8', '127.0.0.1', 175, '2021-03-22 16:15:17');
INSERT INTO `sys_operation_log` VALUES (86, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/static/xq/avatar/1db38371-e3f6-4e19-b562-f6f8e51191e4.jpeg\"},1]', 'Chrome 8', '127.0.0.1', 104, '2021-03-22 16:15:29');
INSERT INTO `sys_operation_log` VALUES (87, 1, '/backed/system/setSysUserInfo', 'POST', '[{\"avatar\":\"http://localhost:8020/static/xq/avatar/53b25fd8-66ee-4f0b-b2b7-50fe8d4f7b58.jpeg\"},1]', 'Chrome 8', '127.0.0.1', 107, '2021-03-22 16:15:48');
INSERT INTO `sys_operation_log` VALUES (88, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-22 16:24:53');
INSERT INTO `sys_operation_log` VALUES (89, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-22 16:25:03');
INSERT INTO `sys_operation_log` VALUES (92, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-22 16:29:06');
INSERT INTO `sys_operation_log` VALUES (93, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-22 16:29:17');
INSERT INTO `sys_operation_log` VALUES (94, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 2, '2021-03-22 16:31:40');
INSERT INTO `sys_operation_log` VALUES (95, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-22 16:31:49');
INSERT INTO `sys_operation_log` VALUES (96, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-22 16:31:54');
INSERT INTO `sys_operation_log` VALUES (97, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-22 16:32:01');
INSERT INTO `sys_operation_log` VALUES (98, 1, '/backed/system/editPermission', 'POST', '[{\"id\":\"88721\",\"name\":\"guanliyuan01\",\"operation\":\"111\",\"remark\":\"333\"}]', 'Chrome 8', '127.0.0.1', 167, '2021-03-22 16:55:53');
INSERT INTO `sys_operation_log` VALUES (99, 1, '/backed/system/deletePermission', 'POST', '[\"88721\"]', 'Chrome 8', '127.0.0.1', 116, '2021-03-22 16:59:21');
INSERT INTO `sys_operation_log` VALUES (100, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-22 18:22:30');
INSERT INTO `sys_operation_log` VALUES (101, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-22 18:43:23');
INSERT INTO `sys_operation_log` VALUES (102, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 1, '2021-03-23 09:28:08');
INSERT INTO `sys_operation_log` VALUES (103, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 09:28:23');
INSERT INTO `sys_operation_log` VALUES (104, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 2, '2021-03-23 09:32:10');
INSERT INTO `sys_operation_log` VALUES (105, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 09:32:16');
INSERT INTO `sys_operation_log` VALUES (106, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 09:32:22');
INSERT INTO `sys_operation_log` VALUES (107, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 09:32:30');
INSERT INTO `sys_operation_log` VALUES (108, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 09:44:12');
INSERT INTO `sys_operation_log` VALUES (109, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 3, '2021-03-23 09:56:16');
INSERT INTO `sys_operation_log` VALUES (110, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '117.160.193.16', 0, '2021-03-23 10:03:27');
INSERT INTO `sys_operation_log` VALUES (111, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '117.160.193.16', 6, '2021-03-23 10:29:33');
INSERT INTO `sys_operation_log` VALUES (112, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '117.160.193.16', 0, '2021-03-23 10:40:17');
INSERT INTO `sys_operation_log` VALUES (113, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '117.160.193.16', 0, '2021-03-23 10:41:17');
INSERT INTO `sys_operation_log` VALUES (114, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '117.160.193.16', 0, '2021-03-23 10:41:40');
INSERT INTO `sys_operation_log` VALUES (115, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '117.160.193.16', 0, '2021-03-23 11:04:28');
INSERT INTO `sys_operation_log` VALUES (116, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '117.160.193.16', 6, '2021-03-23 11:16:38');
INSERT INTO `sys_operation_log` VALUES (117, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '117.160.193.16', 0, '2021-03-23 11:17:05');
INSERT INTO `sys_operation_log` VALUES (118, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '117.160.193.16', 0, '2021-03-23 11:17:48');
INSERT INTO `sys_operation_log` VALUES (119, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '117.160.193.16', 0, '2021-03-23 11:19:33');
INSERT INTO `sys_operation_log` VALUES (120, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 3, '2021-03-23 11:26:32');
INSERT INTO `sys_operation_log` VALUES (121, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:26:42');
INSERT INTO `sys_operation_log` VALUES (122, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:29:42');
INSERT INTO `sys_operation_log` VALUES (123, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:29:47');
INSERT INTO `sys_operation_log` VALUES (124, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:29:56');
INSERT INTO `sys_operation_log` VALUES (125, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:30:01');
INSERT INTO `sys_operation_log` VALUES (126, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:31:26');
INSERT INTO `sys_operation_log` VALUES (127, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:31:34');
INSERT INTO `sys_operation_log` VALUES (128, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:31:38');
INSERT INTO `sys_operation_log` VALUES (129, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:31:43');
INSERT INTO `sys_operation_log` VALUES (130, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:32:47');
INSERT INTO `sys_operation_log` VALUES (131, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:32:54');
INSERT INTO `sys_operation_log` VALUES (132, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:35:03');
INSERT INTO `sys_operation_log` VALUES (133, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:35:09');
INSERT INTO `sys_operation_log` VALUES (134, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:36:18');
INSERT INTO `sys_operation_log` VALUES (135, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:37:02');
INSERT INTO `sys_operation_log` VALUES (136, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:37:08');
INSERT INTO `sys_operation_log` VALUES (137, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:37:37');
INSERT INTO `sys_operation_log` VALUES (138, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:39:38');
INSERT INTO `sys_operation_log` VALUES (139, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:39:45');
INSERT INTO `sys_operation_log` VALUES (140, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:41:53');
INSERT INTO `sys_operation_log` VALUES (141, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:42:00');
INSERT INTO `sys_operation_log` VALUES (142, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:42:14');
INSERT INTO `sys_operation_log` VALUES (143, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:42:43');
INSERT INTO `sys_operation_log` VALUES (144, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:42:47');
INSERT INTO `sys_operation_log` VALUES (145, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:42:53');
INSERT INTO `sys_operation_log` VALUES (146, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:43:52');
INSERT INTO `sys_operation_log` VALUES (147, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:43:58');
INSERT INTO `sys_operation_log` VALUES (148, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:49:28');
INSERT INTO `sys_operation_log` VALUES (149, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 11:49:36');
INSERT INTO `sys_operation_log` VALUES (150, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 12:44:24');
INSERT INTO `sys_operation_log` VALUES (151, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-03-23 12:44:41');
INSERT INTO `sys_operation_log` VALUES (152, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-03-23 12:44:45');
INSERT INTO `sys_operation_log` VALUES (153, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '172.17.0.1', 0, '2021-03-30 09:39:26');
INSERT INTO `sys_operation_log` VALUES (154, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '172.17.0.1', 0, '2021-03-30 09:39:35');
INSERT INTO `sys_operation_log` VALUES (155, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '172.17.0.1', 0, '2021-03-30 09:40:20');
INSERT INTO `sys_operation_log` VALUES (156, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '172.17.0.1', 0, '2021-03-30 09:40:45');
INSERT INTO `sys_operation_log` VALUES (157, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:20:34');
INSERT INTO `sys_operation_log` VALUES (158, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:22:21');
INSERT INTO `sys_operation_log` VALUES (159, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:23:48');
INSERT INTO `sys_operation_log` VALUES (160, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:24:01');
INSERT INTO `sys_operation_log` VALUES (161, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:24:09');
INSERT INTO `sys_operation_log` VALUES (162, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:24:19');
INSERT INTO `sys_operation_log` VALUES (163, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:24:25');
INSERT INTO `sys_operation_log` VALUES (164, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:24:54');
INSERT INTO `sys_operation_log` VALUES (165, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:25:14');
INSERT INTO `sys_operation_log` VALUES (166, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:25:48');
INSERT INTO `sys_operation_log` VALUES (167, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:26:15');
INSERT INTO `sys_operation_log` VALUES (168, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:26:46');
INSERT INTO `sys_operation_log` VALUES (169, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:26:52');
INSERT INTO `sys_operation_log` VALUES (170, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:43:57');
INSERT INTO `sys_operation_log` VALUES (171, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:45:26');
INSERT INTO `sys_operation_log` VALUES (172, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:45:32');
INSERT INTO `sys_operation_log` VALUES (173, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:46:04');
INSERT INTO `sys_operation_log` VALUES (174, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:46:11');
INSERT INTO `sys_operation_log` VALUES (175, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:46:15');
INSERT INTO `sys_operation_log` VALUES (176, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:46:21');
INSERT INTO `sys_operation_log` VALUES (177, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:46:55');
INSERT INTO `sys_operation_log` VALUES (178, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:47:04');
INSERT INTO `sys_operation_log` VALUES (179, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:59:14');
INSERT INTO `sys_operation_log` VALUES (180, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:59:08');
INSERT INTO `sys_operation_log` VALUES (181, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 15:59:37');
INSERT INTO `sys_operation_log` VALUES (182, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:01:26');
INSERT INTO `sys_operation_log` VALUES (183, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:01:30');
INSERT INTO `sys_operation_log` VALUES (184, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:01:37');
INSERT INTO `sys_operation_log` VALUES (185, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:01:44');
INSERT INTO `sys_operation_log` VALUES (186, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:01:51');
INSERT INTO `sys_operation_log` VALUES (187, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:02:00');
INSERT INTO `sys_operation_log` VALUES (188, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:08:38');
INSERT INTO `sys_operation_log` VALUES (189, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:08:44');
INSERT INTO `sys_operation_log` VALUES (190, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:10:18');
INSERT INTO `sys_operation_log` VALUES (191, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:10:23');
INSERT INTO `sys_operation_log` VALUES (192, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:11:35');
INSERT INTO `sys_operation_log` VALUES (193, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:11:45');
INSERT INTO `sys_operation_log` VALUES (194, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:14:30');
INSERT INTO `sys_operation_log` VALUES (195, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:14:33');
INSERT INTO `sys_operation_log` VALUES (196, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:17:59');
INSERT INTO `sys_operation_log` VALUES (197, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:18:04');
INSERT INTO `sys_operation_log` VALUES (198, 3, '/backed/system/login', 'POST', '[\"15517150091\"]', 'Chrome 8', '127.0.0.1', 165, '2021-04-19 16:59:52');
INSERT INTO `sys_operation_log` VALUES (199, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 16:59:52');
INSERT INTO `sys_operation_log` VALUES (200, 3, '/backed/system/login', 'POST', '[3]', 'Chrome 8', '127.0.0.1', 33, '2021-04-19 16:59:52');
INSERT INTO `sys_operation_log` VALUES (201, 3, '/backed/system/login', 'POST', '[\"operate\"]', 'Chrome 8', '127.0.0.1', 102, '2021-04-19 16:59:52');
INSERT INTO `sys_operation_log` VALUES (202, 3, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 41, '2021-04-19 16:59:52');
INSERT INTO `sys_operation_log` VALUES (203, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:03:44');
INSERT INTO `sys_operation_log` VALUES (204, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:03:51');
INSERT INTO `sys_operation_log` VALUES (205, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:10:46');
INSERT INTO `sys_operation_log` VALUES (206, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:10:51');
INSERT INTO `sys_operation_log` VALUES (207, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:11:17');
INSERT INTO `sys_operation_log` VALUES (208, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:11:25');
INSERT INTO `sys_operation_log` VALUES (209, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:11:55');
INSERT INTO `sys_operation_log` VALUES (210, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:15:55');
INSERT INTO `sys_operation_log` VALUES (211, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:16:13');
INSERT INTO `sys_operation_log` VALUES (212, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 2, '2021-04-19 17:29:27');
INSERT INTO `sys_operation_log` VALUES (213, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:29:32');
INSERT INTO `sys_operation_log` VALUES (214, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:36:18');
INSERT INTO `sys_operation_log` VALUES (215, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:36:23');
INSERT INTO `sys_operation_log` VALUES (216, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:38:17');
INSERT INTO `sys_operation_log` VALUES (217, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:38:49');
INSERT INTO `sys_operation_log` VALUES (218, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:39:26');
INSERT INTO `sys_operation_log` VALUES (219, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:39:31');
INSERT INTO `sys_operation_log` VALUES (220, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:39:37');
INSERT INTO `sys_operation_log` VALUES (221, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:46:22');
INSERT INTO `sys_operation_log` VALUES (222, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:46:53');
INSERT INTO `sys_operation_log` VALUES (223, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:46:55');
INSERT INTO `sys_operation_log` VALUES (224, 3, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:47:09');
INSERT INTO `sys_operation_log` VALUES (225, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 17:47:24');
INSERT INTO `sys_operation_log` VALUES (226, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-19 18:03:02');
INSERT INTO `sys_operation_log` VALUES (227, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-19 18:03:09');
INSERT INTO `sys_operation_log` VALUES (228, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 11:26:08');
INSERT INTO `sys_operation_log` VALUES (229, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 67, '2021-04-20 11:26:12');
INSERT INTO `sys_operation_log` VALUES (230, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 11:26:12');
INSERT INTO `sys_operation_log` VALUES (231, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:26:12');
INSERT INTO `sys_operation_log` VALUES (232, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:26:12');
INSERT INTO `sys_operation_log` VALUES (233, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 11:26:12');
INSERT INTO `sys_operation_log` VALUES (234, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:26:12');
INSERT INTO `sys_operation_log` VALUES (235, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 67, '2021-04-20 11:26:54');
INSERT INTO `sys_operation_log` VALUES (236, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 11:26:54');
INSERT INTO `sys_operation_log` VALUES (237, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 33, '2021-04-20 11:26:54');
INSERT INTO `sys_operation_log` VALUES (238, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:26:54');
INSERT INTO `sys_operation_log` VALUES (239, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:26:54');
INSERT INTO `sys_operation_log` VALUES (240, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:26:54');
INSERT INTO `sys_operation_log` VALUES (241, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 67, '2021-04-20 11:28:24');
INSERT INTO `sys_operation_log` VALUES (242, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 11:28:24');
INSERT INTO `sys_operation_log` VALUES (243, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:28:24');
INSERT INTO `sys_operation_log` VALUES (244, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 11:28:25');
INSERT INTO `sys_operation_log` VALUES (245, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:28:25');
INSERT INTO `sys_operation_log` VALUES (246, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:28:25');
INSERT INTO `sys_operation_log` VALUES (247, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 71, '2021-04-20 11:32:25');
INSERT INTO `sys_operation_log` VALUES (248, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 11:32:25');
INSERT INTO `sys_operation_log` VALUES (249, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 11:32:25');
INSERT INTO `sys_operation_log` VALUES (250, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 11:32:25');
INSERT INTO `sys_operation_log` VALUES (251, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 11:32:25');
INSERT INTO `sys_operation_log` VALUES (252, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 38, '2021-04-20 11:32:25');
INSERT INTO `sys_operation_log` VALUES (253, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 69, '2021-04-20 11:38:40');
INSERT INTO `sys_operation_log` VALUES (254, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 11:38:40');
INSERT INTO `sys_operation_log` VALUES (255, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 11:38:40');
INSERT INTO `sys_operation_log` VALUES (256, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:38:40');
INSERT INTO `sys_operation_log` VALUES (257, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 11:38:40');
INSERT INTO `sys_operation_log` VALUES (258, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 11:38:40');
INSERT INTO `sys_operation_log` VALUES (259, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 2, '2021-04-20 12:18:50');
INSERT INTO `sys_operation_log` VALUES (260, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 12:18:55');
INSERT INTO `sys_operation_log` VALUES (261, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-20 12:38:11');
INSERT INTO `sys_operation_log` VALUES (262, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 12:38:18');
INSERT INTO `sys_operation_log` VALUES (263, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 66, '2021-04-20 12:39:22');
INSERT INTO `sys_operation_log` VALUES (264, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 12:39:22');
INSERT INTO `sys_operation_log` VALUES (265, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 12:39:22');
INSERT INTO `sys_operation_log` VALUES (266, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 32, '2021-04-20 12:39:22');
INSERT INTO `sys_operation_log` VALUES (267, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 33, '2021-04-20 12:39:22');
INSERT INTO `sys_operation_log` VALUES (268, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 12:39:22');
INSERT INTO `sys_operation_log` VALUES (269, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 66, '2021-04-20 12:40:02');
INSERT INTO `sys_operation_log` VALUES (270, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 12:40:03');
INSERT INTO `sys_operation_log` VALUES (271, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 12:40:03');
INSERT INTO `sys_operation_log` VALUES (272, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 12:40:03');
INSERT INTO `sys_operation_log` VALUES (273, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 34, '2021-04-20 12:40:03');
INSERT INTO `sys_operation_log` VALUES (274, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 35, '2021-04-20 12:40:03');
INSERT INTO `sys_operation_log` VALUES (275, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:10:44');
INSERT INTO `sys_operation_log` VALUES (276, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:10:51');
INSERT INTO `sys_operation_log` VALUES (277, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 108, '2021-04-20 14:11:21');
INSERT INTO `sys_operation_log` VALUES (278, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:11:21');
INSERT INTO `sys_operation_log` VALUES (279, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:11:21');
INSERT INTO `sys_operation_log` VALUES (280, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 33, '2021-04-20 14:11:21');
INSERT INTO `sys_operation_log` VALUES (281, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:11:21');
INSERT INTO `sys_operation_log` VALUES (282, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:11:22');
INSERT INTO `sys_operation_log` VALUES (283, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 61, '2021-04-20 14:11:30');
INSERT INTO `sys_operation_log` VALUES (284, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:11:30');
INSERT INTO `sys_operation_log` VALUES (285, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:11:30');
INSERT INTO `sys_operation_log` VALUES (286, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:11:31');
INSERT INTO `sys_operation_log` VALUES (287, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 30, '2021-04-20 14:11:31');
INSERT INTO `sys_operation_log` VALUES (288, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:11:31');
INSERT INTO `sys_operation_log` VALUES (289, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 61, '2021-04-20 14:12:08');
INSERT INTO `sys_operation_log` VALUES (290, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:12:08');
INSERT INTO `sys_operation_log` VALUES (291, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 32, '2021-04-20 14:12:08');
INSERT INTO `sys_operation_log` VALUES (292, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:12:08');
INSERT INTO `sys_operation_log` VALUES (293, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 32, '2021-04-20 14:12:08');
INSERT INTO `sys_operation_log` VALUES (294, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 30, '2021-04-20 14:12:09');
INSERT INTO `sys_operation_log` VALUES (295, 1, '/backed/system/login', 'POST', '[\"13800138000\"]', 'Chrome 8', '127.0.0.1', 61, '2021-04-20 14:13:45');
INSERT INTO `sys_operation_log` VALUES (296, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:13:45');
INSERT INTO `sys_operation_log` VALUES (297, 1, '/backed/system/login', 'POST', '[1]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:13:45');
INSERT INTO `sys_operation_log` VALUES (298, 1, '/backed/system/login', 'POST', '[\"admin\"]', 'Chrome 8', '127.0.0.1', 31, '2021-04-20 14:13:45');
INSERT INTO `sys_operation_log` VALUES (299, 1, '/backed/system/login', 'POST', '[\"system\"]', 'Chrome 8', '127.0.0.1', 30, '2021-04-20 14:13:45');
INSERT INTO `sys_operation_log` VALUES (300, 1, '/backed/system/login', 'POST', '[\"user\"]', 'Chrome 8', '127.0.0.1', 32, '2021-04-20 14:13:46');
INSERT INTO `sys_operation_log` VALUES (301, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:14:01');
INSERT INTO `sys_operation_log` VALUES (302, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:14:08');
INSERT INTO `sys_operation_log` VALUES (303, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:16:24');
INSERT INTO `sys_operation_log` VALUES (304, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:16:29');
INSERT INTO `sys_operation_log` VALUES (305, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:17:28');
INSERT INTO `sys_operation_log` VALUES (306, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:17:34');
INSERT INTO `sys_operation_log` VALUES (307, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 2, '2021-04-20 14:18:44');
INSERT INTO `sys_operation_log` VALUES (308, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:18:48');
INSERT INTO `sys_operation_log` VALUES (309, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 3, '2021-04-20 14:20:32');
INSERT INTO `sys_operation_log` VALUES (310, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:20:39');
INSERT INTO `sys_operation_log` VALUES (311, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 2, '2021-04-20 14:21:36');
INSERT INTO `sys_operation_log` VALUES (312, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 14:21:41');
INSERT INTO `sys_operation_log` VALUES (313, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-20 15:01:20');
INSERT INTO `sys_operation_log` VALUES (314, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 15:01:30');
INSERT INTO `sys_operation_log` VALUES (315, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 15:01:54');
INSERT INTO `sys_operation_log` VALUES (316, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 15:02:09');
INSERT INTO `sys_operation_log` VALUES (317, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 15:03:44');
INSERT INTO `sys_operation_log` VALUES (318, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-20 15:04:52');
INSERT INTO `sys_operation_log` VALUES (319, 1, '/backed/system/editRole', 'POST', '[{\"name\":\"11\",\"remark\":\"111\",\"uniqueKey\":\"333\"}]', 'Chrome 8', '127.0.0.1', 80, '2021-04-26 17:41:35');
INSERT INTO `sys_operation_log` VALUES (320, 1, '/backed/system/editRole', 'POST', '[{\"name\":\"11\",\"remark\":\"111333\",\"uniqueKey\":\"333\"}]', 'Chrome 8', '127.0.0.1', 75, '2021-04-26 17:41:40');
INSERT INTO `sys_operation_log` VALUES (321, 1, '/backed/system/deleteRole', 'POST', '[4]', 'Chrome 8', '127.0.0.1', 98, '2021-04-26 17:43:54');
INSERT INTO `sys_operation_log` VALUES (322, 1, '/backed/system/deleteRole', 'POST', '[3]', 'Chrome 8', '127.0.0.1', 162, '2021-04-26 17:46:44');
INSERT INTO `sys_operation_log` VALUES (324, 1, '/backed/system/saveRoleMenus', 'POST', '[{\"menuIds\":\"2,11,3\",\"roleId\":1}]', 'Chrome 8', '127.0.0.1', 175, '2021-04-27 14:32:50');
INSERT INTO `sys_operation_log` VALUES (325, 1, '/backed/system/saveRoleMenus', 'POST', '[{\"menuIds\":\"2,11,3\",\"roleId\":1}]', 'Chrome 8', '127.0.0.1', 167, '2021-04-27 16:02:37');
INSERT INTO `sys_operation_log` VALUES (326, 1, '/backed/system/saveRoleMenuPermissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[{\\\"key\\\":\\\"query\\\",\\\"text\\\":\\\"查询\\\"}]\"}],\"roleId\":1}]', 'Chrome 8', '127.0.0.1', 200, '2021-04-27 16:02:41');
INSERT INTO `sys_operation_log` VALUES (327, 1, '/backed/system/saveRoleMenuPermissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[{\\\"key\\\":\\\"query\\\",\\\"text\\\":\\\"查询\\\"}]\"}],\"roleId\":1}]', 'Chrome 8', '127.0.0.1', 721, '2021-04-27 16:08:00');
INSERT INTO `sys_operation_log` VALUES (328, 1, '/backed/system/saveRoleMenuPermissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[{\\\"key\\\":\\\"query\\\",\\\"text\\\":\\\"查询\\\"}]\"}],\"roleId\":1}]', 'Chrome 8', '127.0.0.1', 180, '2021-04-27 16:08:26');
INSERT INTO `sys_operation_log` VALUES (329, 1, '/backed/system/saveRoleMenuPermissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[{\\\"key\\\":\\\"query\\\",\\\"text\\\":\\\"查询\\\"},{\\\"key\\\":\\\"get\\\",\\\"text\\\":\\\"编辑\\\"}]\"}],\"roleId\":1}]', 'Chrome 8', '127.0.0.1', 140, '2021-04-27 16:21:08');
INSERT INTO `sys_operation_log` VALUES (330, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 8', '127.0.0.1', 0, '2021-04-27 16:27:26');
INSERT INTO `sys_operation_log` VALUES (331, 1, '/backed/system/login', 'POST', NULL, 'Chrome 8', '127.0.0.1', 0, '2021-04-28 10:55:26');
INSERT INTO `sys_operation_log` VALUES (332, 1, '/backed/system/addMenu', 'POST', '[{\"cacheAble\":0,\"component\":\"TabsView\",\"icon\":\"audio\",\"invisible\":1,\"name\":\"guanliyuan01\",\"parentId\":0,\"path\":\"aaa\",\"permissions\":\"[]\",\"sort\":0}]', 'Chrome 8', '127.0.0.1', 137, '2021-04-28 14:21:42');
INSERT INTO `sys_operation_log` VALUES (333, 1, '/backed/system/editMenu', 'POST', '[{\"cacheAble\":0,\"component\":\"TabsView\",\"icon\":\"audio\",\"invisible\":1,\"name\":\"guanliyuan01\",\"parentId\":11,\"path\":\"aaa\",\"permissions\":\"[{\\\"key\\\":\\\"aaa\\\",\\\"text\\\":\\\"bbb\\\"},{\\\"key\\\":\\\"bbb\\\",\\\"text\\\":\\\"ddd\\\"}]\",\"sort\":0}]', 'Chrome 9', '127.0.0.1', 149, '2021-05-05 16:01:39');
INSERT INTO `sys_operation_log` VALUES (334, 1, '/backed/system/editMenu', 'POST', '[{\"cacheAble\":0,\"component\":\"TabsView\",\"icon\":\"audio\",\"invisible\":1,\"name\":\"guanliyuan01\",\"parentId\":11,\"path\":\"aaa\",\"permissions\":\"[{\\\"key\\\":\\\"aa\\\",\\\"text\\\":\\\"bbb\\\"}]\",\"sort\":0}]', 'Chrome 9', '127.0.0.1', 124, '2021-05-05 16:06:28');
INSERT INTO `sys_operation_log` VALUES (335, 1, '/backed/system/editMenu', 'POST', '[{\"cacheAble\":0,\"component\":\"TabsView\",\"icon\":\"audio\",\"id\":12,\"invisible\":1,\"name\":\"guanliyuan01\",\"parentId\":11,\"path\":\"aaa\",\"permissions\":\"[{\\\"key\\\":\\\"aaa\\\",\\\"text\\\":\\\"bbb\\\"}]\",\"sort\":0}]', 'Chrome 9', '127.0.0.1', 183, '2021-05-05 16:15:35');
INSERT INTO `sys_operation_log` VALUES (336, 1, '/backed/system/saveRoleMenus', 'POST', '[{\"menuIds\":\"2,11,12,3,1,4,5,6,7,8,9,10\",\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 189, '2021-05-05 16:17:08');
INSERT INTO `sys_operation_log` VALUES (337, 1, '/backed/system/saveRoleMenuPermissons', 'POST', '[{\"permissions\":[{\"menuId\":12,\"operation\":\"[{\\\"key\\\":\\\"aaa\\\",\\\"text\\\":\\\"bbb\\\"}]\"},{\"menuId\":3,\"operation\":\"[{\\\"key\\\":\\\"query\\\",\\\"text\\\":\\\"查询\\\"},{\\\"key\\\":\\\"get\\\",\\\"text\\\":\\\"编辑\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 2094, '2021-05-05 16:17:20');
INSERT INTO `sys_operation_log` VALUES (338, 1, '/backed/system/saveRoleMenuPermissons', 'POST', '[{\"permissions\":[{\"menuId\":12,\"operation\":\"[{\\\"key\\\":\\\"aaa\\\",\\\"text\\\":\\\"bbb\\\"}]\"},{\"menuId\":3,\"operation\":\"[{\\\"key\\\":\\\"query\\\",\\\"text\\\":\\\"查询\\\"},{\\\"key\\\":\\\"get\\\",\\\"text\\\":\\\"编辑\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 457, '2021-05-05 16:17:21');
INSERT INTO `sys_operation_log` VALUES (339, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 1, '2021-05-05 17:10:54');
INSERT INTO `sys_operation_log` VALUES (340, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-05 17:11:09');
INSERT INTO `sys_operation_log` VALUES (341, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:38:44');
INSERT INTO `sys_operation_log` VALUES (342, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:41:18');
INSERT INTO `sys_operation_log` VALUES (343, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:42:50');
INSERT INTO `sys_operation_log` VALUES (344, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:44:21');
INSERT INTO `sys_operation_log` VALUES (345, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:44:26');
INSERT INTO `sys_operation_log` VALUES (346, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:45:34');
INSERT INTO `sys_operation_log` VALUES (347, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:45:38');
INSERT INTO `sys_operation_log` VALUES (348, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:45:59');
INSERT INTO `sys_operation_log` VALUES (349, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:46:07');
INSERT INTO `sys_operation_log` VALUES (350, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:52:05');
INSERT INTO `sys_operation_log` VALUES (351, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-07 19:52:14');
INSERT INTO `sys_operation_log` VALUES (352, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-08 11:40:20');
INSERT INTO `sys_operation_log` VALUES (353, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 11:40:26');
INSERT INTO `sys_operation_log` VALUES (354, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:04:37');
INSERT INTO `sys_operation_log` VALUES (355, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:04:58');
INSERT INTO `sys_operation_log` VALUES (356, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:15:14');
INSERT INTO `sys_operation_log` VALUES (357, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:16:57');
INSERT INTO `sys_operation_log` VALUES (358, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:19:47');
INSERT INTO `sys_operation_log` VALUES (359, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:20:54');
INSERT INTO `sys_operation_log` VALUES (360, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:21:25');
INSERT INTO `sys_operation_log` VALUES (361, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:22:25');
INSERT INTO `sys_operation_log` VALUES (362, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:37:04');
INSERT INTO `sys_operation_log` VALUES (363, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:38:14');
INSERT INTO `sys_operation_log` VALUES (364, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:44:33');
INSERT INTO `sys_operation_log` VALUES (365, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:54:37');
INSERT INTO `sys_operation_log` VALUES (366, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:55:35');
INSERT INTO `sys_operation_log` VALUES (367, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:56:18');
INSERT INTO `sys_operation_log` VALUES (368, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:57:11');
INSERT INTO `sys_operation_log` VALUES (369, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 17:58:23');
INSERT INTO `sys_operation_log` VALUES (370, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 18:00:56');
INSERT INTO `sys_operation_log` VALUES (371, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 18:17:19');
INSERT INTO `sys_operation_log` VALUES (372, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 18:18:24');
INSERT INTO `sys_operation_log` VALUES (373, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:01:17');
INSERT INTO `sys_operation_log` VALUES (374, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:01:24');
INSERT INTO `sys_operation_log` VALUES (375, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:07:54');
INSERT INTO `sys_operation_log` VALUES (376, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:08:01');
INSERT INTO `sys_operation_log` VALUES (377, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:08:52');
INSERT INTO `sys_operation_log` VALUES (378, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:08:57');
INSERT INTO `sys_operation_log` VALUES (379, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:09:52');
INSERT INTO `sys_operation_log` VALUES (380, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:09:58');
INSERT INTO `sys_operation_log` VALUES (381, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-08 19:10:36');
INSERT INTO `sys_operation_log` VALUES (382, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-09 19:28:59');
INSERT INTO `sys_operation_log` VALUES (383, 1, '/backed/system/save-role-menus', 'POST', '[{\"menuIds\":\"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\",\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 176, '2021-05-09 19:29:32');
INSERT INTO `sys_operation_log` VALUES (384, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-09 19:31:22');
INSERT INTO `sys_operation_log` VALUES (385, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-09 19:51:34');
INSERT INTO `sys_operation_log` VALUES (386, 1, '/backed/system/save-role-menus', 'POST', '[{\"menuIds\":\"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\",\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 177, '2021-05-10 11:16:46');
INSERT INTO `sys_operation_log` VALUES (387, 1, '/backed/system/delete-menu', 'POST', '[11]', 'Chrome 9', '127.0.0.1', 316, '2021-05-10 14:26:56');
INSERT INTO `sys_operation_log` VALUES (388, 1, '/backed/system/delete-menu', 'POST', '[2]', 'Chrome 9', '127.0.0.1', 418, '2021-05-10 14:31:10');
INSERT INTO `sys_operation_log` VALUES (389, 1, '/backed/system/delete-menu', 'POST', '[3]', 'Chrome 9', '127.0.0.1', 207, '2021-05-10 14:33:08');
INSERT INTO `sys_operation_log` VALUES (390, 1, '/backed/system/delete-menu', 'POST', '[3]', 'Chrome 9', '127.0.0.1', 230, '2021-05-10 14:38:40');
INSERT INTO `sys_operation_log` VALUES (391, 1, '/backed/system/delete-menu', 'POST', '[3]', 'Chrome 9', '127.0.0.1', 212, '2021-05-10 14:44:04');
INSERT INTO `sys_operation_log` VALUES (392, 1, '/backed/system/delete-menu', 'POST', '[3]', 'Chrome 9', '127.0.0.1', 310, '2021-05-10 14:45:06');
INSERT INTO `sys_operation_log` VALUES (393, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 14:50:19');
INSERT INTO `sys_operation_log` VALUES (394, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 14:50:25');
INSERT INTO `sys_operation_log` VALUES (395, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 14:59:18');
INSERT INTO `sys_operation_log` VALUES (396, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 14:59:22');
INSERT INTO `sys_operation_log` VALUES (397, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:00:55');
INSERT INTO `sys_operation_log` VALUES (398, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:01:02');
INSERT INTO `sys_operation_log` VALUES (399, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:05:07');
INSERT INTO `sys_operation_log` VALUES (400, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:05:12');
INSERT INTO `sys_operation_log` VALUES (401, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:05:40');
INSERT INTO `sys_operation_log` VALUES (402, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:05:53');
INSERT INTO `sys_operation_log` VALUES (403, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:05:58');
INSERT INTO `sys_operation_log` VALUES (404, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:06:59');
INSERT INTO `sys_operation_log` VALUES (405, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:07:05');
INSERT INTO `sys_operation_log` VALUES (406, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:09:06');
INSERT INTO `sys_operation_log` VALUES (407, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:09:12');
INSERT INTO `sys_operation_log` VALUES (408, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:10:39');
INSERT INTO `sys_operation_log` VALUES (409, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:10:46');
INSERT INTO `sys_operation_log` VALUES (410, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:12:22');
INSERT INTO `sys_operation_log` VALUES (411, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:12:37');
INSERT INTO `sys_operation_log` VALUES (412, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:12:58');
INSERT INTO `sys_operation_log` VALUES (413, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:13:06');
INSERT INTO `sys_operation_log` VALUES (414, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:19:22');
INSERT INTO `sys_operation_log` VALUES (415, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:19:27');
INSERT INTO `sys_operation_log` VALUES (416, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:21:35');
INSERT INTO `sys_operation_log` VALUES (417, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:21:40');
INSERT INTO `sys_operation_log` VALUES (418, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:26:14');
INSERT INTO `sys_operation_log` VALUES (419, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:26:19');
INSERT INTO `sys_operation_log` VALUES (420, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 2, '2021-05-10 15:29:41');
INSERT INTO `sys_operation_log` VALUES (421, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:29:46');
INSERT INTO `sys_operation_log` VALUES (422, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:31:49');
INSERT INTO `sys_operation_log` VALUES (423, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 15:31:55');
INSERT INTO `sys_operation_log` VALUES (424, 1, '/backed/system/save-role-menus', 'POST', '[{\"menuIds\":\"1,2,4,5,6,7,8,9,10,12,13,14,15,16,17,18,19,20,21,22,23,24,25,3\",\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 156, '2021-05-10 15:34:51');
INSERT INTO `sys_operation_log` VALUES (425, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 95, '2021-05-10 15:53:22');
INSERT INTO `sys_operation_log` VALUES (426, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 90, '2021-05-10 15:53:54');
INSERT INTO `sys_operation_log` VALUES (427, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 89, '2021-05-10 15:55:29');
INSERT INTO `sys_operation_log` VALUES (428, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[{\\\"action\\\":\\\"query\\\",\\\"describe\\\":\\\"查询\\\"},{\\\"action\\\":\\\"delete\\\",\\\"describe\\\":\\\"删除\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 160, '2021-05-10 15:56:14');
INSERT INTO `sys_operation_log` VALUES (429, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[{\\\"action\\\":\\\"query\\\",\\\"describe\\\":\\\"查询\\\"},{\\\"action\\\":\\\"delete\\\",\\\"describe\\\":\\\"删除\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 210, '2021-05-10 15:58:46');
INSERT INTO `sys_operation_log` VALUES (430, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":3,\"operation\":\"[{\\\"action\\\":\\\"query\\\",\\\"describe\\\":\\\"查询\\\"},{\\\"action\\\":\\\"delete\\\",\\\"describe\\\":\\\"删除\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 194, '2021-05-10 16:02:30');
INSERT INTO `sys_operation_log` VALUES (431, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 17:09:53');
INSERT INTO `sys_operation_log` VALUES (432, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 17:09:59');
INSERT INTO `sys_operation_log` VALUES (433, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 2, '2021-05-10 17:48:03');
INSERT INTO `sys_operation_log` VALUES (434, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 17:48:20');
INSERT INTO `sys_operation_log` VALUES (435, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 17:53:52');
INSERT INTO `sys_operation_log` VALUES (436, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 17:55:53');
INSERT INTO `sys_operation_log` VALUES (437, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 17:58:04');
INSERT INTO `sys_operation_log` VALUES (438, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 18:01:06');
INSERT INTO `sys_operation_log` VALUES (439, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 18:02:37');
INSERT INTO `sys_operation_log` VALUES (440, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 18:02:42');
INSERT INTO `sys_operation_log` VALUES (441, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 18:38:46');
INSERT INTO `sys_operation_log` VALUES (442, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 18:38:52');
INSERT INTO `sys_operation_log` VALUES (443, 1, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-05-10 18:44:46');
INSERT INTO `sys_operation_log` VALUES (444, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-05-10 18:44:54');
INSERT INTO `sys_operation_log` VALUES (445, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":12,\"operation\":\"[{\\\"action\\\":\\\"update\\\",\\\"describe\\\":\\\"编辑\\\"},{\\\"action\\\":\\\"insert\\\",\\\"describe\\\":\\\"新建\\\"}]\"},{\"menuId\":13,\"operation\":\"[{\\\"action\\\":\\\"update\\\",\\\"describe\\\":\\\"编辑\\\"},{\\\"action\\\":\\\"insert\\\",\\\"describe\\\":\\\"新建\\\"},{\\\"action\\\":\\\"insert\\\",\\\"describe\\\":\\\"删除\\\"}]\"},{\"menuId\":14,\"operation\":\"[{\\\"action\\\":\\\"configure-permissions\\\",\\\"describe\\\":\\\"配置权限\\\"},{\\\"action\\\":\\\"insert\\\",\\\"describe\\\":\\\"新建\\\"},{\\\"action\\\":\\\"insert\\\",\\\"describe\\\":\\\"删除\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 371, '2021-05-11 10:42:07');
INSERT INTO `sys_operation_log` VALUES (446, 1, '/backed/system/save-role-menus', 'POST', '[{\"menuIds\":\"0,1,2,3,4,12,13,14,15,5,16,17,18,20,6,21,7,22,8,23,24,9,25,10\",\"roleId\":2}]', 'Chrome 9', '127.0.0.1', 141, '2021-05-11 10:43:54');
INSERT INTO `sys_operation_log` VALUES (447, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[{\\\"action\\\":\\\"delete\\\",\\\"describe\\\":\\\"删除\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 144, '2021-05-11 11:44:09');
INSERT INTO `sys_operation_log` VALUES (448, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"}],\"roleId\":2}]', 'Chrome 9', '127.0.0.1', 66, '2021-05-11 11:44:21');
INSERT INTO `sys_operation_log` VALUES (449, 1, '/backed/system/save-role-menus', 'POST', '[{\"menuIds\":\"1,2,3,13,14,15,5,16,17,18,20,6,19,21,7,22,8,23,24,9,25,10\",\"roleId\":2}]', 'Chrome 9', '127.0.0.1', 131, '2021-05-11 14:17:56');
INSERT INTO `sys_operation_log` VALUES (450, 1, '/backed/system/save-role-menus', 'POST', '[{\"menuIds\":\"1,2,3,13,14,15,5,16,17,18,20,6,19,21,7,22,8,23,24,9,25,10,12,4\",\"roleId\":2}]', 'Chrome 9', '127.0.0.1', 135, '2021-05-11 14:18:17');
INSERT INTO `sys_operation_log` VALUES (451, 1, '/backed/system/save-role-menus', 'POST', '[{\"menuIds\":\"1,2,3,12,14,15,5,16,17,18,6,19,20,21,7,22,8,23,24,9,25,10,13,4\",\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 143, '2021-05-11 14:19:39');
INSERT INTO `sys_operation_log` VALUES (452, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 61, '2021-05-11 17:24:24');
INSERT INTO `sys_operation_log` VALUES (453, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 70, '2021-05-11 17:27:42');
INSERT INTO `sys_operation_log` VALUES (454, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 72, '2021-05-11 17:28:49');
INSERT INTO `sys_operation_log` VALUES (455, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"},{\"menuId\":20,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 90, '2021-05-11 17:29:46');
INSERT INTO `sys_operation_log` VALUES (456, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"},{\"menuId\":20,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 103, '2021-05-11 17:34:47');
INSERT INTO `sys_operation_log` VALUES (457, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"},{\"menuId\":20,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 102, '2021-05-11 17:35:35');
INSERT INTO `sys_operation_log` VALUES (458, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"},{\"menuId\":20,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 106, '2021-05-11 17:36:12');
INSERT INTO `sys_operation_log` VALUES (459, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[]\"},{\"menuId\":20,\"operation\":\"[]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 99, '2021-05-11 17:37:06');
INSERT INTO `sys_operation_log` VALUES (460, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[{\\\"label\\\":\\\"删除\\\",\\\"value\\\":\\\"19-delete\\\"}]\"},{\"menuId\":20,\"operation\":\"[{\\\"label\\\":\\\"删除\\\",\\\"value\\\":\\\"20-delete\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 250, '2021-05-11 17:37:47');
INSERT INTO `sys_operation_log` VALUES (461, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[{\\\"label\\\":\\\"删除\\\",\\\"value\\\":\\\"delete\\\"}]\"},{\"menuId\":20,\"operation\":\"[{\\\"label\\\":\\\"删除\\\",\\\"value\\\":\\\"delete\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 334, '2021-05-11 17:39:45');
INSERT INTO `sys_operation_log` VALUES (462, 1, '/backed/system/save-role-menu-permissons', 'POST', '[{\"permissions\":[{\"menuId\":19,\"operation\":\"[{\\\"action\\\":\\\"delete\\\",\\\"describe\\\":\\\"删除\\\"}]\"},{\"menuId\":20,\"operation\":\"[{\\\"action\\\":\\\"delete\\\",\\\"describe\\\":\\\"删除\\\"}]\"}],\"roleId\":1}]', 'Chrome 9', '127.0.0.1', 252, '2021-05-11 17:41:19');
INSERT INTO `sys_operation_log` VALUES (463, 1, '/backed/system/update-sysUser', 'POST', '[{\"id\":1,\"name\":\"管理员\",\"roleId\":1,\"status\":1,\"username\":\"13800138000\"}]', 'Chrome 9', '127.0.0.1', 112, '2021-05-11 18:55:42');
INSERT INTO `sys_operation_log` VALUES (469, 3, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-06-08 10:46:22');
INSERT INTO `sys_operation_log` VALUES (470, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-06-08 11:04:03');
INSERT INTO `sys_operation_log` VALUES (471, 3, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-06-08 15:30:48');
INSERT INTO `sys_operation_log` VALUES (472, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-06-22 11:27:56');
INSERT INTO `sys_operation_log` VALUES (473, 3, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-06-22 11:28:02');
INSERT INTO `sys_operation_log` VALUES (474, 3, '/backed/system/logout', 'POST', '[]', 'Chrome 9', '127.0.0.1', 0, '2021-06-22 11:28:24');
INSERT INTO `sys_operation_log` VALUES (475, 1, '/backed/system/login', 'POST', NULL, 'Chrome 9', '127.0.0.1', 0, '2021-06-22 11:28:31');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `unique_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限唯一键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限名称',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'admin', '管理员', '拥有所有权限', '2020-12-09 15:43:18');
INSERT INTO `sys_role` VALUES (2, 'viewer', '体验员', '体验系统', '2021-01-21 09:38:20');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  `menu_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单ids',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (3, 1, '1,2,3,12,14,15,5,16,17,18,6,19,20,21,7,22,8,23,24,9,25,10,13,4', '2021-05-05 16:17:08');
INSERT INTO `sys_role_menu` VALUES (4, 2, '1,2,3,13,14,15,5,16,17,18,20,6,19,21,7,22,8,23,24,9,25,10,12,4', '2021-05-11 10:43:54');

-- ----------------------------
-- Table structure for sys_role_menu_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu_permission`;
CREATE TABLE `sys_role_menu_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  `menu_id` int(11) NULL DEFAULT 0 COMMENT '菜单id',
  `operation` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role_menu_permission
-- ----------------------------
INSERT INTO `sys_role_menu_permission` VALUES (8, 1, 19, '[{\"action\":\"delete\",\"describe\":\"删除\"}]', '2021-05-11 11:44:09');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '名称',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '状态,1 启动，2禁用',
  `created_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '13800138000', 'g25dGNFfAhu3DV+X8KHAsA==', '管理员', 'http://116.63.145.108:8030/img/avatar.png', 1, 1, '2020-12-21 16:46:13');
INSERT INTO `sys_user` VALUES (3, 'admin', 'ISMvKXpXpadDiUoOSoAfww==', '体验员', 'http://116.63.145.108:8030/img/avatar.png', 2, 1, '2021-03-22 16:26:41');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `openid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'openid',
  `unionid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'unionid',
  `nickname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `gender` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'gender',
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '头像地址',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '用户状态,1:正常,2:禁用',
  `created_time` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_time` datetime(0) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分享' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (4, 'odbzF5Aqz3f6-3Y1N415vPi_1F-k', NULL, '哈哈', '13700137000', '1', 'http://116.63.145.108:8030/img/avatar.png', 1, '2021-03-21 20:00:45', '2021-03-21 20:00:45');

SET FOREIGN_KEY_CHECKS = 1;
