/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : localhost:3306
 Source Schema         : ssm_crud

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 28/11/2020 11:04:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_dept
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept`  (
  `dept_id` int(0) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_estonian_ci NOT NULL,
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_estonian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_dept
-- ----------------------------
INSERT INTO `tbl_dept` VALUES (1, '开发部');
INSERT INTO `tbl_dept` VALUES (2, '测试部');

-- ----------------------------
-- Table structure for tbl_emp
-- ----------------------------
DROP TABLE IF EXISTS `tbl_emp`;
CREATE TABLE `tbl_emp`  (
  `emp_id` int(0) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_estonian_ci NOT NULL,
  `gender` char(1) CHARACTER SET utf8 COLLATE utf8_estonian_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_estonian_ci NULL DEFAULT NULL,
  `d_id` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`emp_id`) USING BTREE,
  INDEX `fk_emp_dept`(`d_id`) USING BTREE,
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8 COLLATE = utf8_estonian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_emp
-- ----------------------------
INSERT INTO `tbl_emp` VALUES (1, 'haha', '2', '1234@qq.com', 2);
INSERT INTO `tbl_emp` VALUES (2, 'bb20', '2', 'bb20@qq.com', 2);
INSERT INTO `tbl_emp` VALUES (3, 'c231', '1', 'c231@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (4, '1e76', '1', '1e76@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (5, 'ca77', '1', 'ca77@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (6, 'ea48', '1', 'ea48@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (7, '2612', '1', '2612@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (8, '022f', '1', '022f@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (9, 'a9ae', '1', 'a9ae@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (10, '4b70', '1', '4b70@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (11, 'c910', '1', 'c910@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (12, '8878', '1', '8878@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (13, '36df', '1', '36df@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (14, '790f', '1', '790f@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (15, 'ffa8', '1', 'ffa8@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (16, 'b99f', '1', 'b99f@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (17, '0d58', '1', '0d58@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (18, 'b254', '1', 'b254@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (19, '0acf', '1', '0acf@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (20, 'e5d2', '1', 'e5d2@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (21, '5a25', '1', '5a25@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (22, '07c7', '1', '07c7@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (23, 'b5e2', '1', 'b5e2@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (24, '6848', '1', '6848@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (25, '40f8', '1', '40f8@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (26, '0b32', '1', '0b32@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (27, '4326', '1', '4326@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (28, '4f9f', '1', '4f9f@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (29, '8a5c', '1', '8a5c@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (30, '89b6', '1', '89b6@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (31, '501e', '1', '501e@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (32, 'fb73', '1', 'fb73@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (33, '25c1', '1', '25c1@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (34, 'a2e4', '1', 'a2e4@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (35, '8e9e', '1', '8e9e@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (36, 'c9c1', '1', 'c9c1@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (37, 'e6ce', '1', 'e6ce@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (38, 'd5d2', '1', 'd5d2@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (39, 'e73e', '1', 'e73e@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (40, '1e5c', '1', '1e5c@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (41, '8044', '1', '8044@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (42, '3251', '1', '3251@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (43, '677a', '1', '677a@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (44, 'd4e4', '1', 'd4e4@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (45, '2f2e', '1', '2f2e@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (46, '4088', '1', '4088@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (47, 'a39c', '1', 'a39c@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (48, '5436', '1', '5436@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (49, 'd3d3', '1', 'd3d3@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (50, 'f0be', '1', 'f0be@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (51, '4f5e', '1', '4f5e@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (52, '1c33', '1', '1c33@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (53, '1584', '1', '1584@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (54, 'd9dd', '1', 'd9dd@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (55, '794d', '1', '794d@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (56, '205b', '1', '205b@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (57, 'a28f', '1', 'a28f@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (58, 'ec13', '1', 'ec13@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (59, 'ed5c', '1', 'ed5c@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (60, '0010', '1', '0010@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (61, '85b9', '1', '85b9@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (62, '9481', '1', '9481@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (63, 'be3a', '1', 'be3a@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (64, '2550', '1', '2550@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (65, 'df3a', '1', 'df3a@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (66, 'a0e4', '1', 'a0e4@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (67, 'cde9', '1', 'cde9@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (68, 'c9d9', '1', 'c9d9@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (69, '3e48', '1', '3e48@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (70, '80fe', '1', '80fe@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (71, 'fe17', '1', 'fe17@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (72, 'e01a', '1', 'e01a@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (73, 'cc9e', '1', 'cc9e@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (74, '3950', '1', '3950@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (75, '8a05', '1', '8a05@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (76, '27ec', '1', '27ec@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (77, 'f3a2', '1', 'f3a2@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (78, 'c533', '1', 'c533@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (79, 'e70d', '1', 'e70d@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (80, '1f14', '1', '1f14@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (81, '14ed', '1', '14ed@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (82, '5ab9', '1', '5ab9@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (83, '8a34', '1', '8a34@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (84, '1b41', '1', '1b41@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (85, '81ae', '1', '81ae@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (86, '69ba', '1', '69ba@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (87, '0a15', '1', '0a15@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (88, 'f26a', '1', 'f26a@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (89, '01fa', '1', '01fa@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (90, 'b8b6', '1', 'b8b6@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (91, '1688', '1', '1688@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (92, '7d3a', '1', '7d3a@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (93, '8f52', '1', '8f52@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (94, 'b8e6', '1', 'b8e6@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (95, '3fb8', '1', '3fb8@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (96, 'c4cb', '1', 'c4cb@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (97, 'b695', '1', 'b695@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (98, '17b3', '1', '17b3@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (99, 'bdc5', '1', 'bdc5@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (100, '2bd3', '1', '2bd3@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (101, 'a203', '1', 'a203@qq.com', 1);
INSERT INTO `tbl_emp` VALUES (104, '阿斯蒂芬', '2', '1460662245@qq.com', 2);
INSERT INTO `tbl_emp` VALUES (105, '阿斯蒂芬哈豆腐干', '2', 'ruoxijun@163.com', 1);

SET FOREIGN_KEY_CHECKS = 1;
