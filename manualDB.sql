/*
 Navicat Premium Data Transfer

 Source Server         : manual
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : manual

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 10/12/2019 21:21:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for form_attachment
-- ----------------------------
DROP TABLE IF EXISTS `form_attachment`;
CREATE TABLE `form_attachment` (
  `handbook` varchar(255) NOT NULL COMMENT '手册名称',
  `procedure_number` varchar(60) NOT NULL COMMENT '程序编号',
  `attachment_id` varchar(60) NOT NULL COMMENT '附件代码',
  `attachment_description` varchar(255) NOT NULL COMMENT '附件描述',
  `attachment_file` varchar(255) DEFAULT NULL COMMENT '附件文件路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`attachment_id`,`procedure_number`,`handbook`) USING BTREE,
  KEY `attachment_procedure` (`procedure_number`,`handbook`),
  CONSTRAINT `attachment_procedure` FOREIGN KEY (`procedure_number`, `handbook`) REFERENCES `procedure` (`procedure_number`, `handbook`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for handbook
-- ----------------------------
DROP TABLE IF EXISTS `handbook`;
CREATE TABLE `handbook` (
  `handbook_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手册名称',
  `handbook_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手册文件路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`handbook_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for personnel_and_work
-- ----------------------------
DROP TABLE IF EXISTS `personnel_and_work`;
CREATE TABLE `personnel_and_work` (
  `worker` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '员工姓名',
  `department` varchar(100) NOT NULL COMMENT '所属部门',
  `work` varchar(100) NOT NULL COMMENT '工作名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`worker`,`work`) USING BTREE,
  KEY `worker_staff` (`worker`,`department`),
  CONSTRAINT `worker_staff` FOREIGN KEY (`worker`, `department`) REFERENCES `staff` (`user_name`, `department`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `position_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`position_name`,`department`) USING BTREE,
  KEY `position_department` (`department`),
  KEY `position_name` (`position_name`),
  CONSTRAINT `position_department` FOREIGN KEY (`department`) REFERENCES `department` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for procedure
-- ----------------------------
DROP TABLE IF EXISTS `procedure`;
CREATE TABLE `procedure` (
  `procedure_number` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '程序编号',
  `procedure_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '程序名称',
  `handbook` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手册文件',
  `purpose` varchar(255) NOT NULL COMMENT '目的',
  `application` varchar(255) NOT NULL COMMENT '适用范围',
  `terms` varchar(255) NOT NULL COMMENT '名词术语',
  `according` varchar(255) NOT NULL COMMENT '依据',
  `diagram_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '流程图文件路径',
  `procedure_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '程序文件路径',
  `revision` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修订版本',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`procedure_number`,`handbook`) USING BTREE,
  KEY `procedure_handbook` (`handbook`),
  CONSTRAINT `procedure_handbook` FOREIGN KEY (`handbook`) REFERENCES `handbook` (`handbook_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for procedure_record
-- ----------------------------
DROP TABLE IF EXISTS `procedure_record`;
CREATE TABLE `procedure_record` (
  `procedure_number` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '程序编号',
  `record_number` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '存档编号',
  `handbook` varchar(255) NOT NULL COMMENT '手册名称',
  `revision_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '修订标识',
  `record_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '存档内容',
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '责任部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`record_number`,`procedure_number`,`handbook`) USING BTREE,
  KEY `record_procedure` (`procedure_number`,`handbook`),
  KEY `record_department` (`department`),
  CONSTRAINT `record_department` FOREIGN KEY (`department`) REFERENCES `department` (`department_name`),
  CONSTRAINT `record_procedure` FOREIGN KEY (`procedure_number`, `handbook`) REFERENCES `procedure` (`procedure_number`, `handbook`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for procedure_step
-- ----------------------------
DROP TABLE IF EXISTS `procedure_step`;
CREATE TABLE `procedure_step` (
  `procedure_number` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '程序编号',
  `handbook` varchar(255) NOT NULL COMMENT '手册名称',
  `step_number` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '步骤编号',
  `revision_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '修订标识',
  `step_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '程序流程',
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '责任部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`step_number`,`procedure_number`,`handbook`) USING BTREE,
  KEY `step_procedure` (`handbook`,`procedure_number`),
  KEY `step_department` (`department`),
  CONSTRAINT `step_department` FOREIGN KEY (`department`) REFERENCES `department` (`department_name`),
  CONSTRAINT `step_procedure` FOREIGN KEY (`handbook`, `procedure_number`) REFERENCES `procedure` (`handbook`, `procedure_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for process_and_work
-- ----------------------------
DROP TABLE IF EXISTS `process_and_work`;
CREATE TABLE `process_and_work` (
  `process_number` varchar(100) NOT NULL COMMENT '流程编号',
  `procedure_number` varchar(60) NOT NULL COMMENT '程序编号',
  `handbook` varchar(255) NOT NULL COMMENT '手册名称',
  `department` varchar(255) NOT NULL COMMENT '所属部门',
  `work` varchar(255) NOT NULL COMMENT '工作名称',
  `regulation` varchar(255) DEFAULT NULL COMMENT '工作规范',
  `regulation_file` varchar(255) DEFAULT NULL COMMENT '工作规范文件',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`process_number`,`procedure_number`,`handbook`),
  KEY `process_work` (`work`,`department`),
  CONSTRAINT `process_step` FOREIGN KEY (`process_number`, `procedure_number`, `handbook`) REFERENCES `procedure_step` (`step_number`, `procedure_number`, `handbook`),
  CONSTRAINT `process_work` FOREIGN KEY (`work`, `department`) REFERENCES `work` (`work_name`, `department`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '员工姓名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '123456' COMMENT '密码',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '性别',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电话',
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属部门',
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `privilege_admin` tinyint(1) unsigned zerofill DEFAULT NULL COMMENT '管理员权限',
  `privilege_input` tinyint(1) unsigned zerofill DEFAULT NULL COMMENT '手册录入权限',
  `privilege_basic` tinyint(1) unsigned zerofill DEFAULT NULL COMMENT '基本配置',
  `privilege_department` tinyint(1) unsigned zerofill DEFAULT NULL COMMENT '部门配置',
  PRIMARY KEY (`user_name`),
  KEY `sraff_department` (`department`),
  KEY `staff_position` (`position`),
  KEY `user_name` (`user_name`,`department`),
  CONSTRAINT `sraff_department` FOREIGN KEY (`department`) REFERENCES `department` (`department_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `staff_position` FOREIGN KEY (`position`) REFERENCES `position` (`position_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for work
-- ----------------------------
DROP TABLE IF EXISTS `work`;
CREATE TABLE `work` (
  `work_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工作名称',
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属部门',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '工作描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`work_name`,`department`) USING BTREE,
  KEY `work_department` (`department`),
  CONSTRAINT `work_department` FOREIGN KEY (`department`) REFERENCES `department` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET FOREIGN_KEY_CHECKS = 1;
