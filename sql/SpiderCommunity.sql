/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : spider-community

 Target Server Type    : MySQL
 Target Server Version : 50599
 File Encoding         : 65001

 Date: 07/11/2021 22:02:13
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for action
-- ----------------------------
DROP TABLE IF EXISTS `action`;
CREATE TABLE `action`  (
  `action_id` int NOT NULL,
  `action_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`action_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of action
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `admin_password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `admin_birthday` date NULL DEFAULT NULL,
  `admin_avatar` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `admin_sex` int NULL DEFAULT NULL,
  `admin_register` datetime NOT NULL,
  `worker_id` int NOT NULL,
  `role_id` int NOT NULL,
  `user_id` int NULL DEFAULT NULL,
  `admin_email` varchar(50)  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `worker_id`(`worker_id`) USING BTREE,
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `admin_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `admin_ibfk_3` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for authority
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority`  (
  `authority_id` int NOT NULL,
  `object_id` int NOT NULL,
  `action_id` int NOT NULL,
  PRIMARY KEY (`authority_id`) USING BTREE,
  INDEX `FK_Relationship_1`(`object_id`) USING BTREE,
  INDEX `FK_Relationship_2`(`action_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_1` FOREIGN KEY (`object_id`) REFERENCES `object` (`object_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_2` FOREIGN KEY (`action_id`) REFERENCES `action` (`action_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of authority
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `collect_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `collect_time` timestamp NOT NULL,
  `collect_group_id` int NOT NULL,
  PRIMARY KEY (`collect_id`) USING BTREE,
  INDEX `FK_Relationship_19`(`user_id`) USING BTREE,
  INDEX `collect_group_id`(`collect_group_id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`collect_group_id`) REFERENCES `collect_group` (`collect_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `collect_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_19` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of collect
-- ----------------------------
BEGIN;
INSERT INTO `collect` VALUES (6, 100, 'BDEB1762-773D-1FCD-F781-E8F9D959677A', '2021-11-07 17:11:14', 2), (8, 100, 'BDEB1762-773D-1FCD-F781-E8F9D959677A', '2021-11-07 17:12:52', 1);
COMMIT;

-- ----------------------------
-- Table structure for collect_group
-- ----------------------------
DROP TABLE IF EXISTS `collect_group`;
CREATE TABLE `collect_group`  (
  `collect_group_id` int NOT NULL AUTO_INCREMENT,
  `collect_group_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` timestamp NOT NULL,
  `user_id` int NOT NULL,
  `post_number` int NOT NULL DEFAULT 0,
  `display_status` int NOT NULL DEFAULT 1 COMMENT '公开：1，私密：0',
  PRIMARY KEY (`collect_group_id`) USING BTREE,
  INDEX `FK_Relationship_20`(`user_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_20` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of collect_group
-- ----------------------------
BEGIN;
INSERT INTO `collect_group` VALUES (1, '学习', '2021-11-03 14:12:09', 100, 1, 1), (2, '娱乐', '2021-10-27 14:12:27', 100, 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `post_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `parent_comment_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `comment_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `comment_like_number` int NOT NULL DEFAULT 0,
  `comment_time` timestamp NOT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `FK_Relationship_8`(`user_id`) USING BTREE,
  INDEX `FK_C`(`post_id`) USING BTREE,
  CONSTRAINT `FK_C` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_8` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES ('4562E92D-2391-358B-9F4A-534F25231ED6', 'B8253869-1358-576D-FCB4-5D488A3822C3', 102, 'B8253869-1358-576D-FCB4-5D488A3822C3', '...', 1, '2021-11-04 21:30:44'), ('5155196B-BE5A-6E45-1C09-9C2A2E37F5BA', 'B8253869-1358-576D-FCB4-5D488A3822C3', 105, 'B8253869-1358-576D-FCB4-5D488A3822C3', '额', 1, '2021-10-27 17:19:41'), ('A496DBF4-EC30-4E98-A47F-2E2B92408B0B', 'BDEB1762-773D-1FCD-F781-E8F9D959677A', 100, 'BDEB1762-773D-1FCD-F781-E8F9D959677A', '123456789', 0, '2021-11-07 18:05:55'), ('B73AEAAA-EAF0-127A-9B9F-544EEAE0A3FE', 'B8253869-1358-576D-FCB4-5D488A3822C3', 103, 'B8253869-1358-576D-FCB4-5D488A3822C3', '是是是', 1, '2021-11-03 21:31:45'), ('CA72C813-3F06-5355-0F28-26B8E3C17697', 'B8253869-1358-576D-FCB4-5D488A3822C3', 104, 'B8253869-1358-576D-FCB4-5D488A3822C3', '可以', 1000, '2021-10-28 17:17:35'), ('DA0234E7-0A82-2336-3D41-D295A215B060', 'B8253869-1358-576D-FCB4-5D488A3822C3', 102, 'B8253869-1358-576D-FCB4-5D488A3822C3', '写的还行', 55, '2021-11-03 16:53:03'), ('E860B53C-6097-2E97-B4DF-8C4A49EC2F66', 'B8253869-1358-576D-FCB4-5D488A3822C3', 101, 'B8253869-1358-576D-FCB4-5D488A3822C3', '写的不错', 100, '2021-10-02 16:52:14'), ('F6480B3F-2A2B-2096-2872-2B22416A89A9', 'B8253869-1358-576D-FCB4-5D488A3822C3', 103, 'B8253869-1358-576D-FCB4-5D488A3822C3', '行', 20, '2021-11-02 16:53:18');
COMMIT;

-- ----------------------------
-- Table structure for comment_like
-- ----------------------------
DROP TABLE IF EXISTS `comment_like`;
CREATE TABLE `comment_like`  (
  `comment_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`comment_id`, `user_id`) USING BTREE,
  INDEX `FK_Relationship_13`(`user_id`) USING BTREE,
  CONSTRAINT `comment_like_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_CLA` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_13` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of comment_like
-- ----------------------------
BEGIN;
INSERT INTO `comment_like` VALUES ('B73AEAAA-EAF0-127A-9B9F-544EEAE0A3FE', 100), ('E860B53C-6097-2E97-B4DF-8C4A49EC2F66', 100);
COMMIT;

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `follower_id` int NOT NULL,
  `followed_id` int NOT NULL,
  PRIMARY KEY (`follower_id`, `followed_id`) USING BTREE,
  INDEX `FK_Relationship_11`(`followed_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_10` FOREIGN KEY (`follower_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_11` FOREIGN KEY (`followed_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of follow
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for label_
-- ----------------------------
DROP TABLE IF EXISTS `label_`;
CREATE TABLE `label_`  (
  `label_id` int NOT NULL AUTO_INCREMENT,
  `label_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`label_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of label_
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for object
-- ----------------------------
DROP TABLE IF EXISTS `object`;
CREATE TABLE `object`  (
  `object_id` int NOT NULL,
  `object_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`object_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of object
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `post_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `post_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `post_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `audit_status` int NOT NULL DEFAULT 0 COMMENT '审核中：0，审核通过：1，审核驳回：2',
  `post_like_number` int NOT NULL DEFAULT 0,
  `collect_number` int NOT NULL DEFAULT 0,
  `comment_number` int NOT NULL DEFAULT 0,
  `report_number` int NOT NULL DEFAULT 0,
  `post_time` timestamp NOT NULL,
  `recommended_score` float NULL DEFAULT NULL,
  `recommended_status` int NOT NULL DEFAULT 0 COMMENT '未推荐：0，推荐：1',
  `cover_image` char NOT NULL,
  PRIMARY KEY (`post_id`) USING BTREE,
  INDEX `FK_CLA_ID`(`user_id`) USING BTREE,
  CONSTRAINT `FK_CLA_ID` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post
-- ----------------------------
BEGIN;
INSERT INTO `post` VALUES ('8EF61115-708D-1CCE-AD45-5F49C220C97A', '攀岩的意义是什么？', '今年三四月份的时候重新认识了一位故人，顿时体会到一种“世上所有的相遇都是久别重逢”的人生滋味。看到她朋友圈里发的攀岩照片与一些日常，七月末我也第一次走进岩馆。不出意外的话，应该是这个问题目前所有回答里攀岩时间最短，水平最差的那一位，完全新手。', 103, 0, 0, 0, 0, 0, '2021-10-20 16:38:52', NULL, 0), ('B8253869-1358-576D-FCB4-5D488A3822C3', '旅游指南', '国庆去哪里旅游呢？', 100, 1, 0, 0, 0, 0, '2021-11-04 17:28:56', NULL, 0), ('BDEB1762-773D-1FCD-F781-E8F9D959677A', '穿搭指南', '女孩子都喜欢穿着干干净净的男孩子', 101, 0, 1, 2, 1, 0, '2021-11-18 17:29:48', NULL, 0), ('CA72C813-3F06-5355-0F28-26B8E3C17697', '为什么现在喜欢穿皮衣的年轻男生越来越少了？', '其实为什么现在喜欢穿皮衣的年轻男生越来越少，除了上面说到 4 点原因以外，还和一个效应有关，这个效应叫做“沉锚效应”，在中国服饰的发展历史里面没有丰富的“机车运动史”以及对于军事服饰的大量借鉴，导致一提到皮衣，我们脑海里就会先入为主的将皮衣和油腻、老气、土气联想在一起，觉得穿皮衣的都是中年男士或者那种暴发户式的土鳖。', 102, 0, 0, 0, 0, 0, '2021-09-01 16:37:52', NULL, 0), ('E9B32A7A-B2B2-B618-346A-C819A6EB1EB3', '为什么大三和弦使人类有愉悦感？', '这个是有听觉神经电生理学基础的，听觉中脑编码周期性信号时频特征的机制之一是锁相反应,其编码信息向上传递至更高级中枢供其整合以实现听觉系统的言语感知。这个锁相反应简单理解就是你的大脑两侧听觉神经元只有在特定的相位声波刺激下做出同步性频率发放（频率发放可以简单理解为声音信号转化听觉神经电信号的增加，相当于扩音喇叭）。', 100, 0, 0, 0, 0, 0, '2021-10-01 16:34:22', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for post_label
-- ----------------------------
DROP TABLE IF EXISTS `post_label`;
CREATE TABLE `post_label`  (
  `post_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `label_id` int NOT NULL,
  PRIMARY KEY (`post_id`, `label_id`) USING BTREE,
  INDEX `FK_Relationship_16`(`label_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_16` FOREIGN KEY (`label_id`) REFERENCES `label_` (`label_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `post_label_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post_label
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for post_like
-- ----------------------------
DROP TABLE IF EXISTS `post_like`;
CREATE TABLE `post_like`  (
  `post_like_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `like_time` timestamp NOT NULL,
  PRIMARY KEY (`post_like_id`) USING BTREE,
  INDEX `FK_Relationship_7`(`user_id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_7` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `post_like_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post_like
-- ----------------------------
BEGIN;
INSERT INTO `post_like` VALUES (7, 100, 'BDEB1762-773D-1FCD-F781-E8F9D959677A', '2021-11-07 17:14:25');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int NOT NULL,
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, '普通用户'), (2, '管理员');
COMMIT;

-- ----------------------------
-- Table structure for role_authority
-- ----------------------------
DROP TABLE IF EXISTS `role_authority`;
CREATE TABLE `role_authority`  (
  `role_id` int NOT NULL,
  `authority_id` int NOT NULL,
  PRIMARY KEY (`role_id`, `authority_id`) USING BTREE,
  INDEX `FK_Relationship_4`(`authority_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_3` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_4` FOREIGN KEY (`authority_id`) REFERENCES `authority` (`authority_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role_authority
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int NOT NULL,
  `user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_birthday` date NULL DEFAULT NULL,
  `user_avatar` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_signature` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_sex` int NULL DEFAULT NULL,
  `user_school` int NULL DEFAULT NULL,
  `role_id` int NOT NULL,
  `register_time` datetime NOT NULL,
  `recent_login` timestamp NULL DEFAULT NULL,
  `fans_number` int NULL DEFAULT 0,
  `attention_number` int NULL DEFAULT 0,
  `user_email` varchar(50)  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `FK_Relationship_5`(`role_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_5` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (100, 'lx', '100', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-01 19:29:34', NULL, 0, 0), (101, 'ch', '101', NULL, NULL, NULL, NULL, NULL, 1, '2021-11-04 17:27:28', NULL, 0, 0), (102, 'cy', '102', NULL, NULL, NULL, NULL, NULL, 1, '2021-11-03 16:35:02', NULL, 0, 0), (103, 'qed', '103', NULL, NULL, NULL, NULL, NULL, 1, '2021-11-02 16:35:24', NULL, 0, 0), (104, 'yzr', '104', NULL, NULL, NULL, NULL, NULL, 1, '2021-11-03 16:35:48', NULL, 0, 0), (105, 'zcj', '105', NULL, NULL, NULL, NULL, NULL, 1, '2021-11-01 16:36:00', NULL, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for user_label
-- ----------------------------
DROP TABLE IF EXISTS `user_label`;
CREATE TABLE `user_label`  (
  `user_id` int NOT NULL,
  `label_id` int NOT NULL,
  `number` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`, `label_id`) USING BTREE,
  INDEX `FK_Relationship_15`(`label_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_14` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_15` FOREIGN KEY (`label_id`) REFERENCES `label_` (`label_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_label
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for worker
-- ----------------------------
DROP TABLE IF EXISTS `worker`;
CREATE TABLE `worker`  (
  `worker_id` int NOT NULL AUTO_INCREMENT,
  `worker_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `entry_time` datetime NOT NULL,
  PRIMARY KEY (`worker_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of worker
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for school
-- ----------------------------

DROP TABLE IF EXISTS `school`;
CREATE TABLE `school`  (
  `id` int(11) NOT NULL,
  `school_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `school_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `department` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `other` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of school
-- ----------------------------

INSERT INTO `school` VALUES (1, '4111010001', '北京大学', '11', '北京市', '1101', '北京市', '本科', '教育部', '');
INSERT INTO `school` VALUES (2, '4111010002', '中国人民大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (3, '4111010003', '清华大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (4, '4111010004', '北京交通大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (5, '4111010005', '北京工业大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (6, '4111010006', '北京航空航天大学', '11', '北京市', '1101', '北京市', '本科', '工业和信息化部', NULL);
INSERT INTO `school` VALUES (7, '4111010007', '北京理工大学', '11', '北京市', '1101', '北京市', '本科', '工业和信息化部', NULL);
INSERT INTO `school` VALUES (8, '4111010008', '北京科技大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (9, '4111010009', '北方工业大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (10, '4111010010', '北京化工大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (11, '4111010011', '北京工商大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (12, '4111010012', '北京服装学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (13, '4111010013', '北京邮电大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (14, '4111010015', '北京印刷学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (15, '4111010016', '北京建筑大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (16, '4111010017', '北京石油化工学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (17, '4111010018', '北京电子科技学院', '11', '北京市', '1101', '北京市', '本科', '中央办公厅', NULL);
INSERT INTO `school` VALUES (18, '4111010019', '中国农业大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (19, '4111010020', '北京农学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (20, '4111010022', '北京林业大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (21, '4111010023', '北京协和医学院', '11', '北京市', '1101', '北京市', '本科', '国家卫生和计划生育委员会', NULL);
INSERT INTO `school` VALUES (22, '4111010025', '首都医科大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (23, '4111010026', '北京中医药大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (24, '4111010027', '北京师范大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (25, '4111010028', '首都师范大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (26, '4111010029', '首都体育学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (27, '4111010030', '北京外国语大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (28, '4111010031', '北京第二外国语学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (29, '4111010032', '北京语言大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (30, '4111010033', '中国传媒大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (31, '4111010034', '中央财经大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (32, '4111010036', '对外经济贸易大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (33, '4111010037', '北京物资学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (34, '4111010038', '首都经济贸易大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (35, '4111010040', '外交学院', '11', '北京市', '1101', '北京市', '本科', '外交部', NULL);
INSERT INTO `school` VALUES (36, '4111010041', '中国人民公安大学', '11', '北京市', '1101', '北京市', '本科', '公安部', NULL);
INSERT INTO `school` VALUES (37, '4111010042', '国际关系学院', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (38, '4111010043', '北京体育大学', '11', '北京市', '1101', '北京市', '本科', '国家体育总局', NULL);
INSERT INTO `school` VALUES (39, '4111010045', '中央音乐学院', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (40, '4111010046', '中国音乐学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (41, '4111010047', '中央美术学院', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (42, '4111010048', '中央戏剧学院', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (43, '4111010049', '中国戏曲学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (44, '4111010050', '北京电影学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (45, '4111010051', '北京舞蹈学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (46, '4111010052', '中央民族大学', '11', '北京市', '1101', '北京市', '本科', '国家民委', NULL);
INSERT INTO `school` VALUES (47, '4111010053', '中国政法大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (48, '4111010054', '华北电力大学', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (49, '4111011149', '中华女子学院', '11', '北京市', '1101', '北京市', '本科', '中华妇女联合会', NULL);
INSERT INTO `school` VALUES (50, '4111011232', '北京信息科技大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (51, '4111011413', '中国矿业大学（北京）', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (52, '4111011414', '中国石油大学（北京）', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (53, '4111011415', '中国地质大学（北京）', '11', '北京市', '1101', '北京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (54, '4111011417', '北京联合大学', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (55, '4111011418', '北京城市学院', '11', '北京市', '1101', '北京市', '本科', '北京市教委', '民办');
INSERT INTO `school` VALUES (56, '4111011625', '中国青年政治学院', '11', '北京市', '1101', '北京市', '本科', '共青团中央', NULL);
INSERT INTO `school` VALUES (57, '4111011831', '首钢工学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (58, '4111012453', '中国劳动关系学院', '11', '北京市', '1101', '北京市', '本科', '中华全国总工会', NULL);
INSERT INTO `school` VALUES (59, '4111012802', '北京吉利学院', '11', '北京市', '1101', '北京市', '本科', '北京市教委', '民办');
INSERT INTO `school` VALUES (60, '4111013629', '首都师范大学科德学院', '11', '北京市', '1101', '北京市', '本科', '北京市教委', '民办');
INSERT INTO `school` VALUES (61, '4111013630', '北京工商大学嘉华学院', '11', '北京市', '1101', '北京市', '本科', '北京市教委', '民办');
INSERT INTO `school` VALUES (62, '4111013901', '北京邮电大学世纪学院', '11', '北京市', '1101', '北京市', '本科', '北京市教委', '民办');
INSERT INTO `school` VALUES (63, '4111013904', '北京工业大学耿丹学院', '11', '北京市', '1101', '北京市', '本科', '北京市教委', '民办');
INSERT INTO `school` VALUES (64, '4111014019', '北京警察学院', '11', '北京市', '1101', '北京市', '本科', '北京市', NULL);
INSERT INTO `school` VALUES (65, '4111014201', '北京第二外国语学院中瑞酒店管理学院', '11', '北京市', '1101', '北京市', '本科', '北京市教委', '民办');
INSERT INTO `school` VALUES (66, '4111014430', '中国科学院大学', '11', '北京市', '1101', '北京市', '本科', '中国科学院', NULL);
INSERT INTO `school` VALUES (67, '4111014596', '中国社会科学院大学', '11', '北京市', '1101', '北京市', '本科', '中国社会科学院', NULL);
INSERT INTO `school` VALUES (68, '4111010853', '北京工业职业技术学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (69, '4111010857', '北京信息职业技术学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (70, '4111010858', '北京电子科技职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (71, '4111011090', '北京京北职业技术学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (72, '4111011092', '北京交通职业技术学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (73, '4111011626', '北京青年政治学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (74, '4111012448', '北京农业职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (75, '4111012451', '北京政法职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (76, '4111012561', '北京财贸职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (77, '4111012564', '北京北大方正软件职业技术\n学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (78, '4111012565', '北京经贸职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (79, '4111012566', '北京经济技术职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (80, '4111012567', '北京戏曲艺术职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (81, '4111012568', '北京汇佳职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (82, '4111012733', '北京科技经营管理学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (83, '4111013703', '北京科技职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (84, '4111013728', '北京培黎职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (85, '4111014073', '北京经济管理职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (86, '4111014075', '北京劳动保障职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (87, '4111014139', '北京社会管理职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (88, '4111014140', '北京艺术传媒职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (89, '4111014215', '北京体育职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (90, '4111014279', '北京交通运输职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (91, '4111014395', '北京卫生职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市', NULL);
INSERT INTO `school` VALUES (92, '4111014588', '北京网络职业学院', '11', '北京市', '1101', '北京市', '专科', '北京市教委', '民办');
INSERT INTO `school` VALUES (93, '4112010055', '南开大学', '12', '天津市', '1201', '天津市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (94, '4112010056', '天津大学', '12', '天津市', '1201', '天津市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (95, '4112010057', '天津科技大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (96, '4112010058', '天津工业大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (97, '4112010059', '中国民航大学', '12', '天津市', '1201', '天津市', '本科', '交通运输部', NULL);
INSERT INTO `school` VALUES (98, '4112010060', '天津理工大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (99, '4112010061', '天津农学院', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (100, '4112010062', '天津医科大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (101, '4112010063', '天津中医药大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (102, '4112010065', '天津师范大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (103, '4112010066', '天津职业技术师范大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (104, '4112010068', '天津外国语大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (105, '4112010069', '天津商业大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (106, '4112010070', '天津财经大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (107, '4112010071', '天津体育学院', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (108, '4112010072', '天津音乐学院', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (109, '4112010073', '天津美术学院', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (110, '4112010792', '天津城建大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (111, '4112010859', '天津天狮学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (112, '4112012105', '天津中德应用技术大学', '12', '天津市', '1201', '天津市', '本科', '天津市', NULL);
INSERT INTO `school` VALUES (113, '4112013658', '天津外国语大学滨海外事学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (114, '4112013659', '天津体育学院运动与文化艺术\n学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (115, '4112013660', '天津商业大学宝德学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (116, '4112013661', '天津医科大学临床医学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (117, '4112013663', '南开大学滨海学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (118, '4112013896', '天津师范大学津沽学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (119, '4112013897', '天津理工大学中环信息学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (120, '4112013898', '北京科技大学天津学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (121, '4112014038', '天津大学仁爱学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (122, '4112014087', '天津财经大学珠江学院', '12', '天津市', '1201', '天津市', '本科', '天津市教委', '民办');
INSERT INTO `school` VALUES (123, '4112011032', '天津市职业大学', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (124, '4112012484', '天津滨海职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (125, '4112012487', '天津工程职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (126, '4112012535', '天津青年职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (127, '4112012719', '天津渤海职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (128, '4112012720', '天津电子信息职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (129, '4112012721', '天津机电职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (130, '4112012722', '天津现代职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (131, '4112012723', '天津公安警官职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (132, '4112012732', '天津轻工职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (133, '4112012788', '天津商务职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (134, '4112012803', '天津国土资源和房屋职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (135, '4112012880', '天津医学高等专科学校', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (136, '4112012881', '天津开发区职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (137, '4112012882', '天津艺术职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (138, '4112012883', '天津交通职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (139, '4112013700', '天津冶金职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (140, '4112013701', '天津石油职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (141, '4112013702', '天津城市职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (142, '4112013863', '天津铁道职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (143, '4112013911', '天津工艺美术职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (144, '4112014020', '天津城市建设管理职业技术\n学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (145, '4112014021', '天津生物工程职业技术学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (146, '4112014022', '天津海运职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (147, '4112014102', '天津广播影视职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (148, '4112014599', '天津体育职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市', NULL);
INSERT INTO `school` VALUES (149, '4112014600', '天津滨海汽车工程职业学院', '12', '天津市', '1201', '天津市', '专科', '天津市教委', '民办');
INSERT INTO `school` VALUES (150, '4113010075', '河北大学', '13', '河北省', '1306', '保定市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (151, '4113010076', '河北工程大学', '13', '河北省', '1304', '邯郸市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (152, '4113010077', '河北地质大学', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (153, '4113010080', '河北工业大学', '12', '天津市', '1201', '天津市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (154, '4113010081', '华北理工大学', '13', '河北省', '1302', '唐山市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (155, '4113010082', '河北科技大学', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (156, '4113010084', '河北建筑工程学院', '13', '河北省', '1307', '张家口市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (157, '4113010085', '河北水利电力学院', '13', '河北省', '1309', '沧州市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (158, '4113010086', '河北农业大学', '13', '河北省', '1306', '保定市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (159, '4113010089', '河北医科大学', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (160, '4113010092', '河北北方学院', '13', '河北省', '1307', '张家口市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (161, '4113010093', '承德医学院', '13', '河北省', '1308', '承德市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (162, '4113010094', '河北师范大学', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (163, '4113010096', '保定学院', '13', '河北省', '1306', '保定市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (164, '4113010098', '河北民族师范学院', '13', '河北省', '1308', '承德市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (165, '4113010099', '唐山师范学院', '13', '河北省', '1302', '唐山市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (166, '4113010100', '廊坊师范学院', '13', '河北省', '1310', '廊坊市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (167, '4113010101', '衡水学院', '13', '河北省', '1311', '衡水市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (168, '4113010102', '石家庄学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (169, '4113010103', '邯郸学院', '13', '河北省', '1304', '邯郸市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (170, '4113010104', '邢台学院', '13', '河北省', '1305', '邢台市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (171, '4113010105', '沧州师范学院', '13', '河北省', '1309', '沧州市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (172, '4113010107', '石家庄铁道大学', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (173, '4113010216', '燕山大学', '13', '河北省', '1303', '秦皇岛市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (174, '4113010798', '河北科技师范学院', '13', '河北省', '1303', '秦皇岛市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (175, '4113011033', '唐山学院', '13', '河北省', '1302', '唐山市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (176, '4113011104', '华北科技学院', '13', '河北省', '1310', '廊坊市', '本科', '国家安全生产监督管理总局', NULL);
INSERT INTO `school` VALUES (177, '4113011105', '中国人民武装警察部队学院', '13', '河北省', '1310', '廊坊市', '本科', '公安部', NULL);
INSERT INTO `school` VALUES (178, '4113011236', '河北体育学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (179, '4113011420', '河北金融学院', '13', '河北省', '1306', '保定市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (180, '4113011629', '北华航天工业学院', '13', '河北省', '1310', '廊坊市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (181, '4113011775', '防灾科技学院', '13', '河北省', '1310', '廊坊市', '本科', '中国地震局', NULL);
INSERT INTO `school` VALUES (182, '4113011832', '河北经贸大学', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (183, '4113011903', '中央司法警官学院', '13', '河北省', '1306', '保定市', '本科', '司法部', NULL);
INSERT INTO `school` VALUES (184, '4113012784', '河北传媒学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (185, '4113012796', '河北工程技术学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (186, '4113013075', '河北美术学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (187, '4113013391', '河北科技学院', '13', '河北省', '1306', '保定市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (188, '4113013402', '河北外国语学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (189, '4113013404', '河北大学工商学院', '13', '河北省', '1306', '保定市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (190, '4113013408', '华北理工大学轻工学院', '13', '河北省', '1302', '唐山市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (191, '4113013409', '河北科技大学理工学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (192, '4113013411', '河北师范大学汇华学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (193, '4113013414', '河北经贸大学经济管理学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (194, '4113013415', '河北医科大学临床学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (195, '4113013417', '华北电力大学科技学院', '13', '河北省', '1306', '保定市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (196, '4113013578', '河北工程大学科信学院', '13', '河北省', '1304', '邯郸市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (197, '4113013584', '河北工业大学城市学院', '13', '河北省', '1310', '廊坊市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (198, '4113013592', '燕山大学里仁学院', '13', '河北省', '1303', '秦皇岛市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (199, '4113013593', '石家庄铁道大学四方学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (200, '4113013594', '河北地质大学华信学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (201, '4113013595', '河北农业大学现代科技学院', '13', '河北省', '1306', '保定市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (202, '4113013596', '华北理工大学冀唐学院', '13', '河北省', '1302', '唐山市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (203, '4113013891', '中国地质大学长城学院', '13', '河北省', '1306', '保定市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (204, '4113013895', '燕京理工学院', '13', '河北省', '1310', '廊坊市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (205, '4113013899', '北京中医药大学东方学院', '13', '河北省', '1310', '廊坊市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (206, '4113014202', '北京交通大学海滨学院', '13', '河北省', '1309', '沧州市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (207, '4113014225', '河北东方学院', '13', '河北省', '1310', '廊坊市', '本科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (208, '4113014432', '河北中医学院', '13', '河北省', '1301', '石家庄市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (209, '4113014458', '张家口学院', '13', '河北省', '1307', '张家口市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (210, '4213051721', '河北环境工程学院', '13', '河北省', '1303', '秦皇岛市', '本科', '河北省', NULL);
INSERT INTO `school` VALUES (211, '4113010873', '河北工业职业技术学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (212, '4113011034', '邯郸职业技术学院', '13', '河北省', '1304', '邯郸市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (213, '4113011238', '石家庄职业技术学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (214, '4113011423', '张家口职业技术学院', '13', '河北省', '1307', '张家口市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (215, '4113011777', '承德石油高等专科学校', '13', '河北省', '1308', '承德市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (216, '4113011821', '邢台职业技术学院', '13', '河北省', '1305', '邢台市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (217, '4113012352', '河北软件职业技术学院', '13', '河北省', '1306', '保定市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (218, '4113012367', '河北石油职业技术学院', '13', '河北省', '1310', '廊坊市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (219, '4113012389', '河北建材职业技术学院', '13', '河北省', '1303', '秦皇岛市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (220, '4113012408', '河北政法职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (221, '4113012415', '沧州职业技术学院', '13', '河北省', '1309', '沧州市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (222, '4113012418', '河北能源职业技术学院', '13', '河北省', '1302', '唐山市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (223, '4113012424', '石家庄铁路职业技术学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (224, '4113012543', '保定职业技术学院', '13', '河北省', '1306', '保定市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (225, '4113012773', '秦皇岛职业技术学院', '13', '河北省', '1303', '秦皇岛市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (226, '4113012782', '石家庄工程职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (227, '4113012783', '石家庄城市经济职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (228, '4113012785', '唐山职业技术学院', '13', '河北省', '1302', '唐山市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (229, '4113012786', '衡水职业技术学院', '13', '河北省', '1311', '衡水市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (230, '4113012787', '唐山工业职业技术学院', '13', '河北省', '1302', '唐山市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (231, '4113012884', '邢台医学高等专科学校', '13', '河北省', '1305', '邢台市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (232, '4113012885', '河北省艺术职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (233, '4113012887', '河北旅游职业学院', '13', '河北省', '1308', '承德市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (234, '4113013070', '石家庄财经职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (235, '4113013071', '河北交通职业技术学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (236, '4113013072', '河北化工医药职业技术学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (237, '4113013073', '石家庄信息工程职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (238, '4113013074', '河北对外经贸职业学院', '13', '河北省', '1303', '秦皇岛市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (239, '4113013392', '保定电力职业技术学院', '13', '河北省', '1306', '保定市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (240, '4113013393', '河北机电职业技术学院', '13', '河北省', '1305', '邢台市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (241, '4113013394', '渤海石油职业学院', '13', '河北省', '1309', '沧州市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (242, '4113013395', '廊坊职业技术学院', '13', '河北省', '1310', '廊坊市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (243, '4113013396', '唐山科技职业技术学院', '13', '河北省', '1302', '唐山市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (244, '4113013397', '石家庄邮电职业技术学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (245, '4113013398', '河北公安警察职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (246, '4113013399', '石家庄工商职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (247, '4113013400', '石家庄理工职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (248, '4113013403', '石家庄科技信息职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (249, '4113013690', '河北司法警官职业学院', '13', '河北省', '1304', '邯郸市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (250, '4113013779', '沧州医学高等专科学校', '13', '河北省', '1309', '沧州市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (251, '4113013822', '河北女子职业技术学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (252, '4113014018', '石家庄医学高等专科学校', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (253, '4113014047', '石家庄经济职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (254, '4113014103', '冀中职业学院', '13', '河北省', '1306', '保定市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (255, '4113014158', '石家庄人民医学高等专科学校', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (256, '4113014185', '石家庄科技工程职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (257, '4113014208', '河北劳动关系职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (258, '4113014213', '石家庄科技职业学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (259, '4113014259', '泊头职业学院', '13', '河北省', '1309', '沧州市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (260, '4113014260', '宣化科技职业学院', '13', '河北省', '1307', '张家口市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (261, '4113014280', '廊坊燕京职业技术学院', '13', '河北省', '1310', '廊坊市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (262, '4113014281', '承德护理职业学院', '13', '河北省', '1308', '承德市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (263, '4113014328', '石家庄幼儿师范高等专科学校', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (264, '4113014335', '廊坊卫生职业学院', '13', '河北省', '1310', '廊坊市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (265, '4113014396', '河北轨道运输职业技术学院', '13', '河北省', '1301', '石家庄市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (266, '4113014460', '保定幼儿师范高等专科学校', '13', '河北省', '1306', '保定市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (267, '4113014471', '河北工艺美术职业学院', '13', '河北省', '1306', '保定市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (268, '4113014472', '渤海理工职业学院', '13', '河北省', '1309', '沧州市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (269, '4113014586', '唐山幼儿师范高等专科学校', '13', '河北省', '1302', '唐山市', '专科', '河北省', NULL);
INSERT INTO `school` VALUES (270, '4113014601', '曹妃甸职业技术学院', '13', '河北省', '1302', '唐山市', '专科', '河北省教育厅', '民办');
INSERT INTO `school` VALUES (271, '4114010108', '山西大学', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (272, '4114010109', '太原科技大学', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (273, '4114010110', '中北大学', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (274, '4114010112', '太原理工大学', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (275, '4114010113', '山西农业大学', '14', '山西省', '1407', '晋中市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (276, '4114010114', '山西医科大学', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (277, '4114010117', '长治医学院', '14', '山西省', '1404', '长治市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (278, '4114010118', '山西师范大学', '14', '山西省', '1410', '临汾市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (279, '4114010119', '太原师范学院', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (280, '4114010120', '山西大同大学', '14', '山西省', '1402', '大同市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (281, '4114010121', '晋中学院', '14', '山西省', '1407', '晋中市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (282, '4114010122', '长治学院', '14', '山西省', '1404', '长治市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (283, '4114010123', '运城学院', '14', '山西省', '1408', '运城市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (284, '4114010124', '忻州师范学院', '14', '山西省', '1409', '忻州市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (285, '4114010125', '山西财经大学', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (286, '4114010809', '山西中医药大学', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (287, '4114010812', '吕梁学院', '14', '山西省', '1411', '吕梁市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (288, '4114011242', '太原学院', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (289, '4114012111', '山西警察学院', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (290, '4114012779', '山西应用科技学院', '14', '山西省', '1401', '太原市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (291, '4114013533', '山西大学商务学院', '14', '山西省', '1401', '太原市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (292, '4114013534', '太原理工大学现代科技学院', '14', '山西省', '1401', '太原市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (293, '4114013535', '山西农业大学信息学院', '14', '山西省', '1407', '晋中市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (294, '4114013537', '山西师范大学现代文理学院', '14', '山西省', '1410', '临汾市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (295, '4114013538', '中北大学信息商务学院', '14', '山西省', '1401', '太原市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (296, '4114013597', '太原科技大学华科学院', '14', '山西省', '1401', '太原市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (297, '4114013598', '山西医科大学晋祠学院', '14', '山西省', '1401', '太原市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (298, '4114013608', '山西财经大学华商学院', '14', '山西省', '1401', '太原市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (299, '4114013691', '山西工商学院', '14', '山西省', '1401', '太原市', '本科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (300, '4114014101', '太原工业学院', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (301, '4114014434', '山西传媒学院', '14', '山西省', '1401', '太原市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (302, '4114014527', '山西工程技术学院', '14', '山西省', '1403', '阳泉市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (303, '4214051189', '山西能源学院', '14', '山西省', '1407', '晋中市', '本科', '山西省', NULL);
INSERT INTO `school` VALUES (304, '4114011630', '山西省财政税务专科学校', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (305, '4114012388', '长治职业技术学院', '14', '山西省', '1404', '长治市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (306, '4114012704', '山西艺术职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (307, '4114012774', '晋城职业技术学院', '14', '山西省', '1405', '晋城市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (308, '4114012775', '山西建筑职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (309, '4114012776', '山西药科职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (310, '4114012777', '山西工程职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (311, '4114012778', '山西交通职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (312, '4114012780', '大同煤炭职业技术学院', '14', '山西省', '1402', '大同市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (313, '4114012888', '山西机电职业技术学院', '14', '山西省', '1404', '长治市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (314, '4114012889', '山西戏剧职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (315, '4114012890', '山西财贸职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (316, '4114012891', '山西林业职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (317, '4114012892', '山西水利职业技术学院', '14', '山西省', '1408', '运城市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (318, '4114012893', '阳泉职业技术学院', '14', '山西省', '1403', '阳泉市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (319, '4114013171', '临汾职业技术学院', '14', '山西省', '1410', '临汾市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (320, '4114013528', '山西职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (321, '4114013529', '山西煤炭职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (322, '4114013530', '山西金融职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (323, '4114013532', '太原城市职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (324, '4114013541', '山西信息职业技术学院', '14', '山西省', '1410', '临汾市', '专科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (325, '4114013692', '山西体育职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (326, '4114013693', '山西警官职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (327, '4114013694', '山西国际商务职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (328, '4114013695', '潞安职业技术学院', '14', '山西省', '1404', '长治市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (329, '4114013696', '太原旅游职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (330, '4114013697', '山西旅游职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (331, '4114013698', '山西管理职业学院', '14', '山西省', '1410', '临汾市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (332, '4114013745', '山西电力职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (333, '4114013821', '忻州职业技术学院', '14', '山西省', '1409', '忻州市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (334, '4114013862', '山西同文职业技术学院', '14', '山西省', '1407', '晋中市', '专科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (335, '4114013913', '晋中职业技术学院', '14', '山西省', '1407', '晋中市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (336, '4114013914', '山西华澳商贸职业学院', '14', '山西省', '1407', '晋中市', '专科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (337, '4114013934', '山西运城农业职业技术学院', '14', '山西省', '1408', '运城市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (338, '4114014093', '运城幼儿师范高等专科学校', '14', '山西省', '1408', '运城市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (339, '4114014105', '山西老区职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (340, '4114014177', '山西经贸职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (341, '4114014186', '朔州职业技术学院', '14', '山西省', '1406', '朔州市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (342, '4114014226', '运城职业技术学院', '14', '山西省', '1408', '运城市', '专科', '山西省教育厅', '民办');
INSERT INTO `school` VALUES (343, '4114014247', '山西轻工职业技术学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (344, '4114014270', '晋中师范高等专科学校', '14', '山西省', '1407', '晋中市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (345, '4114014271', '阳泉师范高等专科学校', '14', '山西省', '1403', '阳泉市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (346, '4114014336', '山西青年职业学院', '14', '山西省', '1401', '太原市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (347, '4114014397', '运城护理职业学院', '14', '山西省', '1408', '运城市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (348, '4114014461', '运城师范高等专科学校', '14', '山西省', '1408', '运城市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (349, '4114014462', '朔州师范高等专科学校', '14', '山西省', '1406', '朔州市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (350, '4114014500', '吕梁职业技术学院', '14', '山西省', '1411', '吕梁市', '专科', '山西省', NULL);
INSERT INTO `school` VALUES (351, '4115010126', '内蒙古大学', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (352, '4115010127', '内蒙古科技大学', '15', '内蒙古自治区', '1502', '包头市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (353, '4115010128', '内蒙古工业大学', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (354, '4115010129', '内蒙古农业大学', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (355, '4115010132', '内蒙古医科大学', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (356, '4115010135', '内蒙古师范大学', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (357, '4115010136', '内蒙古民族大学', '15', '内蒙古自治区', '1505', '通辽市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (358, '4115010138', '赤峰学院', '15', '内蒙古自治区', '1504', '赤峰市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (359, '4115010139', '内蒙古财经大学', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (360, '4115010819', '呼伦贝尔学院', '15', '内蒙古自治区', '1507', '呼伦贝尔市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (361, '4115011427', '集宁师范学院', '15', '内蒙古自治区', '1509', '乌兰察布市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (362, '4115011631', '河套学院', '15', '内蒙古自治区', '1508', '巴彦淖尔市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (363, '4115011709', '呼和浩特民族学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (364, '4115014199', '内蒙古大学创业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (365, '4115014205', '内蒙古师范大学鸿德学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (366, '4115014531', '内蒙古艺术学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (367, '4115014532', '鄂尔多斯应用技术学院', '15', '内蒙古自治区', '1506', '鄂尔多斯市', '本科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (368, '4115010871', '内蒙古建筑职业技术学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (369, '4115011429', '内蒙古丰州职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (370, '4115012057', '包头职业技术学院', '15', '内蒙古自治区', '1502', '包头市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (371, '4115012443', '兴安职业技术学院', '15', '内蒙古自治区', '1522', '兴安盟', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (372, '4115012670', '呼和浩特职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (373, '4115012671', '包头轻工职业技术学院', '15', '内蒙古自治区', '1502', '包头市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (374, '4115012673', '内蒙古电子信息职业技术学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (375, '4115012674', '内蒙古机电职业技术学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (376, '4115012675', '内蒙古化工职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (377, '4115012676', '内蒙古商贸职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (378, '4115012677', '锡林郭勒职业学院', '15', '内蒙古自治区', '1525', '锡林郭勒盟', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (379, '4115012797', '内蒙古警察职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (380, '4115012894', '内蒙古体育职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (381, '4115013699', '乌兰察布职业学院', '15', '内蒙古自治区', '1509', '乌兰察布市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (382, '4115013740', '通辽职业学院', '15', '内蒙古自治区', '1505', '通辽市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (383, '4115013741', '科尔沁艺术职业学院', '15', '内蒙古自治区', '1505', '通辽市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (384, '4115013824', '内蒙古交通职业技术学院', '15', '内蒙古自治区', '1504', '赤峰市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (385, '4115013864', '包头钢铁职业技术学院', '15', '内蒙古自治区', '1502', '包头市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (386, '4115013915', '乌海职业技术学院', '15', '内蒙古自治区', '1503', '乌海市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (387, '4115014048', '内蒙古科技职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (388, '4115014049', '内蒙古北方职业技术学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (389, '4115014050', '赤峰职业技术学院', '15', '内蒙古自治区', '1504', '赤峰市', '专科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (390, '4115014051', '内蒙古经贸外语职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (391, '4115014187', '包头铁道职业技术学院', '15', '内蒙古自治区', '1502', '包头市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (392, '4115014219', '乌兰察布医学高等专科学校', '15', '内蒙古自治区', '1509', '乌兰察布市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (393, '4115014248', '鄂尔多斯职业学院', '15', '内蒙古自治区', '1506', '鄂尔多斯市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (394, '4115014282', '内蒙古工业职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (395, '4115014283', '呼伦贝尔职业技术学院', '15', '内蒙古自治区', '1507', '呼伦贝尔市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (396, '4115014285', '满洲里俄语职业学院', '15', '内蒙古自治区', '1507', '呼伦贝尔市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (397, '4115014337', '内蒙古能源职业学院', '15', '内蒙古自治区', '1501', '呼和浩特市', '专科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (398, '4115014338', '赤峰工业职业技术学院', '15', '内蒙古自治区', '1504', '赤峰市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (399, '4115014339', '阿拉善职业技术学院', '15', '内蒙古自治区', '1529', '阿拉善盟', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (400, '4115014387', '内蒙古美术职业学院', '15', '内蒙古自治区', '1508', '巴彦淖尔市', '专科', '内蒙古自治区教育厅', '民办');
INSERT INTO `school` VALUES (401, '4115014463', '内蒙古民族幼儿师范\n高等专科学校', '15', '内蒙古自治区', '1506', '鄂尔多斯市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (402, '4115014501', '鄂尔多斯生态环境职业学院', '15', '内蒙古自治区', '1506', '鄂尔多斯市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (403, '4115014539', '扎兰屯职业学院', '15', '内蒙古自治区', '1507', '呼伦贝尔市', '专科', '内蒙古自治区', NULL);
INSERT INTO `school` VALUES (404, '4121010140', '辽宁大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (405, '4121010141', '大连理工大学', '21', '辽宁省', '2102', '大连市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (406, '4121010142', '沈阳工业大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (407, '4121010143', '沈阳航空航天大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (408, '4121010144', '沈阳理工大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (409, '4121010145', '东北大学', '21', '辽宁省', '2101', '沈阳市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (410, '4121010146', '辽宁科技大学', '21', '辽宁省', '2103', '鞍山市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (411, '4121010147', '辽宁工程技术大学', '21', '辽宁省', '2109', '阜新市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (412, '4121010148', '辽宁石油化工大学', '21', '辽宁省', '2104', '抚顺市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (413, '4121010149', '沈阳化工大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (414, '4121010150', '大连交通大学', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (415, '4121010151', '大连海事大学', '21', '辽宁省', '2102', '大连市', '本科', '交通运输部', NULL);
INSERT INTO `school` VALUES (416, '4121010152', '大连工业大学', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (417, '4121010153', '沈阳建筑大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (418, '4121010154', '辽宁工业大学', '21', '辽宁省', '2107', '锦州市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (419, '4121010157', '沈阳农业大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (420, '4121010158', '大连海洋大学', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (421, '4121010159', '中国医科大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (422, '4121010160', '锦州医科大学', '21', '辽宁省', '2107', '锦州市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (423, '4121010161', '大连医科大学', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (424, '4121010162', '辽宁中医药大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (425, '4121010163', '沈阳药科大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (426, '4121010164', '沈阳医学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (427, '4121010165', '辽宁师范大学', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (428, '4121010166', '沈阳师范大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (429, '4121010167', '渤海大学', '21', '辽宁省', '2107', '锦州市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (430, '4121010169', '鞍山师范学院', '21', '辽宁省', '2103', '鞍山市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (431, '4121010172', '大连外国语大学', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (432, '4121010173', '东北财经大学', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (433, '4121010175', '中国刑事警察学院', '21', '辽宁省', '2101', '沈阳市', '本科', '公安部', NULL);
INSERT INTO `school` VALUES (434, '4121010176', '沈阳体育学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (435, '4121010177', '沈阳音乐学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (436, '4121010178', '鲁迅美术学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (437, '4121010841', '辽宁对外经贸学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (438, '4121011035', '沈阳大学', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (439, '4121011258', '大连大学', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (440, '4121011430', '辽宁科技学院', '21', '辽宁省', '2105', '本溪市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (441, '4121011432', '辽宁警察学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (442, '4121011632', '沈阳工程学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (443, '4121011779', '辽东学院', '21', '辽宁省', '2106', '丹东市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (444, '4121012026', '大连民族大学', '21', '辽宁省', '2102', '大连市', '本科', '国家民委', NULL);
INSERT INTO `school` VALUES (445, '4121013198', '大连理工大学城市学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (446, '4121013199', '沈阳工业大学工程学院', '21', '辽宁省', '2110', '辽阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (447, '4121013200', '沈阳航空航天大学北方科技\n学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (448, '4121013201', '沈阳工学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (449, '4121013203', '大连工业大学艺术与信息工程\n学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (450, '4121013207', '大连科技学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (451, '4121013208', '沈阳城市建设学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (452, '4121013211', '中国医科大学临床医药学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (453, '4121013212', '大连医科大学中山学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (454, '4121013213', '锦州医科大学医疗学院', '21', '辽宁省', '2107', '锦州市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (455, '4121013215', '辽宁师范大学海华学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (456, '4121013217', '辽宁理工学院', '21', '辽宁省', '2107', '锦州市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (457, '4121013218', '大连财经学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (458, '4121013220', '沈阳城市学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (459, '4121013583', '辽宁石油化工大学顺华能源\n学院', '21', '辽宁省', '2104', '抚顺市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (460, '4121013599', '大连艺术学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (461, '4121013609', '辽宁中医药大学杏林学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (462, '4121013610', '辽宁何氏医学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (463, '4121013621', '沈阳科技学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (464, '4121013631', '大连东软信息学院', '21', '辽宁省', '2102', '大连市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (465, '4121013900', '辽宁财贸学院', '21', '辽宁省', '2114', '葫芦岛市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (466, '4121013957', '辽宁传媒学院', '21', '辽宁省', '2101', '沈阳市', '本科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (467, '4121014435', '营口理工学院', '21', '辽宁省', '2108', '营口市', '本科', '辽宁省', NULL);
INSERT INTO `school` VALUES (468, '4121010171', '朝阳师范高等专科学校', '21', '辽宁省', '2113', '朝阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (469, '4121010179', '抚顺师范高等专科学校', '21', '辽宁省', '2104', '抚顺市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (470, '4121010180', '锦州师范高等专科学校', '21', '辽宁省', '2107', '锦州市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (471, '4121010181', '营口职业技术学院', '21', '辽宁省', '2108', '营口市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (472, '4121010182', '铁岭师范高等专科学校', '21', '辽宁省', '2112', '铁岭市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (473, '4121010845', '大连职业技术学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (474, '4121010957', '辽宁农业职业技术学院', '21', '辽宁省', '2108', '营口市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (475, '4121011037', '抚顺职业技术学院', '21', '辽宁省', '2104', '抚顺市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (476, '4121011249', '辽阳职业技术学院', '21', '辽宁省', '2110', '辽阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (477, '4121011250', '阜新高等专科学校', '21', '辽宁省', '2109', '阜新市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (478, '4121011500', '辽宁省交通高等专科学校', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (479, '4121011735', '辽宁税务高等专科学校', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (480, '4121012063', '盘锦职业技术学院', '21', '辽宁省', '2111', '盘锦市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (481, '4121012590', '沈阳航空职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (482, '4121012591', '辽宁体育运动职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (483, '4121012592', '辽宁职业学院', '21', '辽宁省', '2112', '铁岭市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (484, '4121012593', '辽宁林业职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (485, '4121012594', '沈阳职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (486, '4121012595', '辽宁理工职业学院', '21', '辽宁省', '2107', '锦州市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (487, '4121012730', '大连商务职业学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (488, '4121012895', '辽宁金融职业学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (489, '4121012896', '辽宁轨道交通职业学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (490, '4121012897', '辽宁广告职业学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (491, '4121012898', '辽宁机电职业技术学院', '21', '辽宁省', '2106', '丹东市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (492, '4121012899', '辽宁经济职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (493, '4121012900', '辽宁石化职业技术学院', '21', '辽宁省', '2107', '锦州市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (494, '4121012931', '渤海船舶职业学院', '21', '辽宁省', '2114', '葫芦岛市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (495, '4121013958', '大连软件职业学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (496, '4121013959', '大连翻译职业学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (497, '4121013960', '辽宁商贸职业学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (498, '4121013961', '大连枫叶职业技术学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (499, '4121014076', '辽宁装备制造职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (500, '4121014077', '辽河石油职业技术学院', '21', '辽宁省', '2111', '盘锦市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (501, '4121014106', '辽宁地质工程职业学院', '21', '辽宁省', '2106', '丹东市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (502, '4121014188', '辽宁铁道职业技术学院', '21', '辽宁省', '2107', '锦州市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (503, '4121014189', '辽宁建筑职业学院', '21', '辽宁省', '2110', '辽阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (504, '4121014209', '大连航运职业技术学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (505, '4121014227', '大连装备制造职业技术学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (506, '4121014228', '大连汽车职业技术学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (507, '4121014240', '辽宁现代服务职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (508, '4121014286', '辽宁冶金职业技术学院', '21', '辽宁省', '2105', '本溪市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (509, '4121014287', '辽宁工程职业学院', '21', '辽宁省', '2112', '铁岭市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (510, '4121014288', '辽宁城市建设职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (511, '4121014289', '辽宁医药职业学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (512, '4121014290', '铁岭卫生职业学院', '21', '辽宁省', '2112', '铁岭市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (513, '4121014385', '沈阳北软信息职业技术学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省教育厅', '民办');
INSERT INTO `school` VALUES (514, '4121014398', '辽宁政法职业学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (515, '4121014464', '辽宁民族师范高等专科学校', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (516, '4121014473', '辽宁轻工职业学院', '21', '辽宁省', '2102', '大连市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (517, '4121014474', '辽宁水利职业学院', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (518, '4121014526', '辽宁特殊教育师范高等专科\n学校', '21', '辽宁省', '2101', '沈阳市', '专科', '辽宁省', NULL);
INSERT INTO `school` VALUES (519, '4122010183', '吉林大学', '22', '吉林省', '2201', '长春市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (520, '4122010184', '延边大学', '22', '吉林省', '2224', '延边朝鲜族\n自治州', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (521, '4122010186', '长春理工大学', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (522, '4122010188', '东北电力大学', '22', '吉林省', '2202', '吉林市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (523, '4122010190', '长春工业大学', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (524, '4122010191', '吉林建筑大学', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (525, '4122010192', '吉林化工学院', '22', '吉林省', '2202', '吉林市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (526, '4122010193', '吉林农业大学', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (527, '4122010199', '长春中医药大学', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (528, '4122010200', '东北师范大学', '22', '吉林省', '2201', '长春市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (529, '4122010201', '北华大学', '22', '吉林省', '2202', '吉林市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (530, '4122010202', '通化师范学院', '22', '吉林省', '2205', '通化市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (531, '4122010203', '吉林师范大学', '22', '吉林省', '2203', '四平市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (532, '4122010204', '吉林工程技术师范学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (533, '4122010205', '长春师范大学', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (534, '4122010206', '白城师范学院', '22', '吉林省', '2208', '白城市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (535, '4122010207', '吉林财经大学', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (536, '4122010208', '吉林体育学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (537, '4122010209', '吉林艺术学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (538, '4122010964', '吉林华桥外国语学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (539, '4122011261', '吉林工商学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (540, '4122011437', '长春工程学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (541, '4122011439', '吉林农业科技学院', '22', '吉林省', '2202', '吉林市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (542, '4122011441', '吉林警察学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (543, '4122011726', '长春大学', '22', '吉林省', '2201', '长春市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (544, '4122013600', '长春光华学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (545, '4122013601', '长春工业大学人文信息学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (546, '4122013602', '长春理工大学光电信息学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (547, '4122013603', '长春财经学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (548, '4122013604', '吉林建筑大学城建学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (549, '4122013605', '长春建筑学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (550, '4122013606', '长春科技学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (551, '4122013607', '吉林动画学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (552, '4122013622', '吉林师范大学博达学院', '22', '吉林省', '2203', '四平市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (553, '4122013623', '长春大学旅游学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (554, '4122013662', '东北师范大学人文学院', '22', '吉林省', '2201', '长春市', '本科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (555, '4122013706', '吉林医药学院', '22', '吉林省', '2202', '吉林市', '本科', '吉林省', NULL);
INSERT INTO `school` VALUES (556, '3622000335', '长春师范高等专科学校', '22', '吉林省', '2201', '长春市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (557, '4122010847', '辽源职业技术学院', '22', '吉林省', '2204', '辽源市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (558, '4122011044', '四平职业大学', '22', '吉林省', '2203', '四平市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (559, '4122011436', '长春汽车工业高等专科学校', '22', '吉林省', '2201', '长春市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (560, '4122011440', '长春金融高等专科学校', '22', '吉林省', '2201', '长春市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (561, '4122011823', '长春医学高等专科学校', '22', '吉林省', '2201', '长春市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (562, '4122012049', '吉林交通职业技术学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (563, '4122012306', '长春东方职业学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (564, '4122012901', '吉林司法警官职业学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (565, '4122012902', '吉林电子信息职业技术学院', '22', '吉林省', '2202', '吉林市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (566, '4122012903', '吉林工业职业技术学院', '22', '吉林省', '2202', '吉林市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (567, '4122012904', '吉林工程职业学院', '22', '吉林省', '2203', '四平市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (568, '4122013161', '长春职业技术学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (569, '4122013743', '白城医学高等专科学校', '22', '吉林省', '2208', '白城市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (570, '4122013916', '长春信息技术职业学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (571, '4122013917', '松原职业技术学院', '22', '吉林省', '2207', '松原市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (572, '4122014052', '吉林铁道职业技术学院', '22', '吉林省', '2202', '吉林市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (573, '4122014107', '白城职业技术学院', '22', '吉林省', '2208', '白城市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (574, '4122014190', '长白山职业技术学院', '22', '吉林省', '2206', '白山市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (575, '4122014291', '吉林科技职业技术学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (576, '4122014340', '延边职业技术学院', '22', '吉林省', '2224', '延边朝鲜族\n自治州', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (577, '4122014426', '吉林城市职业技术学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (578, '4122014567', '吉林职业技术学院', '22', '吉林省', '2224', '延边朝鲜族\n自治州', '专科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (579, '4122014602', '吉林水利电力职业学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省', NULL);
INSERT INTO `school` VALUES (580, '4122014603', '长春健康职业学院', '22', '吉林省', '2201', '长春市', '专科', '吉林省教育厅', '民办');
INSERT INTO `school` VALUES (581, '4123010212', '黑龙江大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (582, '4123010213', '哈尔滨工业大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '工业和信息化部', NULL);
INSERT INTO `school` VALUES (583, '4123010214', '哈尔滨理工大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (584, '4123010217', '哈尔滨工程大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '工业和信息化部', NULL);
INSERT INTO `school` VALUES (585, '4123010219', '黑龙江科技大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (586, '4123010220', '东北石油大学', '23', '黑龙江省', '2306', '大庆市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (587, '4123010222', '佳木斯大学', '23', '黑龙江省', '2308', '佳木斯市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (588, '4123010223', '黑龙江八一农垦大学', '23', '黑龙江省', '2306', '大庆市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (589, '4123010224', '东北农业大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (590, '4123010225', '东北林业大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (591, '4123010226', '哈尔滨医科大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (592, '4123010228', '黑龙江中医药大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (593, '4123010229', '牡丹江医学院', '23', '黑龙江省', '2310', '牡丹江市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (594, '4123010231', '哈尔滨师范大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (595, '4123010232', '齐齐哈尔大学', '23', '黑龙江省', '2302', '齐齐哈尔市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (596, '4123010233', '牡丹江师范学院', '23', '黑龙江省', '2310', '牡丹江市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (597, '4123010234', '哈尔滨学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (598, '4123010235', '大庆师范学院', '23', '黑龙江省', '2306', '大庆市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (599, '4123010236', '绥化学院', '23', '黑龙江省', '2312', '绥化市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (600, '4123010240', '哈尔滨商业大学', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (601, '4123010242', '哈尔滨体育学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (602, '4123010245', '哈尔滨金融学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (603, '4123011230', '齐齐哈尔医学院', '23', '黑龙江省', '2302', '齐齐哈尔市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (604, '4123011445', '黑龙江工业学院', '23', '黑龙江省', '2303', '鸡西市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (605, '4123011446', '黑龙江东方学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (606, '4123011635', '哈尔滨信息工程学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (607, '4123011802', '黑龙江工程学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (608, '4123012729', '齐齐哈尔工程学院', '23', '黑龙江省', '2302', '齐齐哈尔市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (609, '4123013296', '黑龙江外国语学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (610, '4123013298', '黑龙江财经学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (611, '4123013299', '哈尔滨石油学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (612, '4123013300', '黑龙江工商学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (613, '4123013301', '哈尔滨远东理工学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (614, '4123013303', '哈尔滨剑桥学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (615, '4123013304', '黑龙江工程学院昆仑旅游学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (616, '4123013306', '哈尔滨广厦学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (617, '4123013307', '哈尔滨华德学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (618, '4123013744', '黑河学院', '23', '黑龙江省', '2311', '黑河市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (619, '4123014560', '哈尔滨音乐学院', '23', '黑龙江省', '2301', '哈尔滨市', '本科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (620, '4123010238', '齐齐哈尔高等师范专科学校', '23', '黑龙江省', '2302', '齐齐哈尔市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (621, '4123010872', '伊春职业学院', '23', '黑龙江省', '2307', '伊春市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (622, '4123011046', '牡丹江大学', '23', '黑龙江省', '2310', '牡丹江市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (623, '4123011449', '黑龙江职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (624, '4123012053', '黑龙江建筑职业技术学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (625, '4123012490', '黑龙江艺术职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (626, '4123012718', '大庆职业学院', '23', '黑龙江省', '2306', '大庆市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (627, '4123012724', '黑龙江林业职业技术学院', '23', '黑龙江省', '2310', '牡丹江市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (628, '4123012725', '黑龙江农业职业技术学院', '23', '黑龙江省', '2308', '佳木斯市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (629, '4123012726', '黑龙江农业工程职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (630, '4123012727', '黑龙江农垦职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (631, '4123012728', '黑龙江司法警官职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (632, '4123012905', '鹤岗师范高等专科学校', '23', '黑龙江省', '2304', '鹤岗市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (633, '4123012906', '哈尔滨电力职业技术学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (634, '4123012907', '哈尔滨铁道职业技术学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (635, '4123012908', '大兴安岭职业学院', '23', '黑龙江省', '2327', '大兴安岭地区', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (636, '4123012910', '黑龙江农业经济职业学院', '23', '黑龙江省', '2310', '牡丹江市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (637, '4123012911', '哈尔滨职业技术学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (638, '4123013302', '哈尔滨传媒职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (639, '4123013447', '黑龙江生物科技职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (640, '4123013448', '黑龙江商业职业学院', '23', '黑龙江省', '2310', '牡丹江市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (641, '4123013449', '黑龙江公安警官职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (642, '4123013450', '黑龙江信息技术职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (643, '4123013451', '哈尔滨城市职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (644, '4123013453', '黑龙江农垦科技职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (645, '4123013729', '黑龙江旅游职业技术学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (646, '4123013730', '黑龙江三江美术职业学院', '23', '黑龙江省', '2308', '佳木斯市', '专科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (647, '4123013731', '黑龙江生态工程职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (648, '4123013732', '黑龙江能源职业学院', '23', '黑龙江省', '2305', '双鸭山市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (649, '4123013918', '七台河职业学院', '23', '黑龙江省', '2309', '七台河市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (650, '4123013935', '黑龙江民族职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (651, '4123014017', '大庆医学高等专科学校', '23', '黑龙江省', '2306', '大庆市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (652, '4123014053', '黑龙江交通职业技术学院', '23', '黑龙江省', '2302', '齐齐哈尔市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (653, '4123014055', '哈尔滨应用职业技术学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (654, '4123014095', '黑龙江幼儿师范高等专科学校', '23', '黑龙江省', '2310', '牡丹江市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (655, '4123014108', '哈尔滨科学技术职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (656, '4123014109', '黑龙江粮食职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (657, '4123014178', '佳木斯职业学院', '23', '黑龙江省', '2308', '佳木斯市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (658, '4123014272', '黑龙江护理高等专科学校', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (659, '4123014400', '齐齐哈尔理工职业学院', '23', '黑龙江省', '2302', '齐齐哈尔市', '专科', '黑龙江省教育厅', '民办');
INSERT INTO `school` VALUES (660, '4123014425', '哈尔滨幼儿师范高等专科学校', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (661, '4123014540', '黑龙江冰雪体育职业学院', '23', '黑龙江省', '2301', '哈尔滨市', '专科', '黑龙江省', NULL);
INSERT INTO `school` VALUES (662, '4131010246', '复旦大学', '31', '上海市', '3101', '上海市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (663, '4131010247', '同济大学', '31', '上海市', '3101', '上海市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (664, '4131010248', '上海交通大学', '31', '上海市', '3101', '上海市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (665, '4131010251', '华东理工大学', '31', '上海市', '3101', '上海市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (666, '4131010252', '上海理工大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (667, '4131010254', '上海海事大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (668, '4131010255', '东华大学', '31', '上海市', '3101', '上海市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (669, '4131010256', '上海电力学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (670, '4131010259', '上海应用技术大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (671, '4131010262', '上海健康医学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (672, '4131010264', '上海海洋大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (673, '4131010268', '上海中医药大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (674, '4131010269', '华东师范大学', '31', '上海市', '3101', '上海市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (675, '4131010270', '上海师范大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (676, '4131010271', '上海外国语大学', '31', '上海市', '3101', '上海市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (677, '4131010272', '上海财经大学', '31', '上海市', '3101', '上海市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (678, '4131010273', '上海对外经贸大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (679, '4131010274', '上海海关学院', '31', '上海市', '3101', '上海市', '本科', '海关总署', NULL);
INSERT INTO `school` VALUES (680, '4131010276', '华东政法大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (681, '4131010277', '上海体育学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (682, '4131010278', '上海音乐学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (683, '4131010279', '上海戏剧学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (684, '4131010280', '上海大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (685, '4131010283', '上海公安学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (686, '4131010856', '上海工程技术大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (687, '4131011047', '上海立信会计金融学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (688, '4131011458', '上海电机学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (689, '4131011833', '上海杉达学院', '31', '上海市', '3101', '上海市', '本科', '上海市教委', '民办');
INSERT INTO `school` VALUES (690, '4131011835', '上海政法学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (691, '4131012044', '上海第二工业大学', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (692, '4131012050', '上海商学院', '31', '上海市', '3101', '上海市', '本科', '上海市', NULL);
INSERT INTO `school` VALUES (693, '4131012799', '上海建桥学院', '31', '上海市', '3101', '上海市', '本科', '上海市教委', '民办');
INSERT INTO `school` VALUES (694, '4131012914', '上海兴伟学院', '31', '上海市', '3101', '上海市', '本科', '上海市教委', '民办');
INSERT INTO `school` VALUES (695, '4131013632', '上海视觉艺术学院', '31', '上海市', '3101', '上海市', '本科', '上海市教委', '民办');
INSERT INTO `school` VALUES (696, '4131013636', '上海外国语大学贤达经济人文\n学院', '31', '上海市', '3101', '上海市', '本科', '上海市教委', '民办');
INSERT INTO `school` VALUES (697, '4131013893', '上海师范大学天华学院', '31', '上海市', '3101', '上海市', '本科', '上海市教委', '民办');
INSERT INTO `school` VALUES (698, '4131014423', '上海科技大学', '31', '上海市', '3101', '上海市', '本科', '上海市\n中国科学院', NULL);
INSERT INTO `school` VALUES (699, '4131016404', '上海纽约大学', '31', '上海市', '3101', '上海市', '本科', '上海市教委', '中外合作办学');
INSERT INTO `school` VALUES (700, '4131010275', '上海旅游高等专科学校', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (701, '4131010851', '上海东海职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (702, '4131010852', '上海工商职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (703, '4131011733', '上海出版印刷高等专科学校', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (704, '4131012493', '上海行健职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (705, '4131012495', '上海城建职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (706, '4131012497', '上海交通职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (707, '4131012498', '上海海事职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (708, '4131012499', '上海电子信息职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (709, '4131012583', '上海震旦职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (710, '4131012584', '上海民远职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (711, '4131012585', '上海欧华职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (712, '4131012586', '上海思博职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (713, '4131012587', '上海立达职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (714, '4131012588', '上海工艺美术职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (715, '4131012798', '上海济光职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (716, '4131012800', '上海工商外国语职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (717, '4131012801', '上海科学技术职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (718, '4131012912', '上海农林职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (719, '4131012913', '上海邦德职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (720, '4131012915', '上海中侨职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (721, '4131013747', '上海电影艺术职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (722, '4131013907', '上海中华职业技术学院', '31', '上海市', '3101', '上海市', '专科', '上海市教委', '民办');
INSERT INTO `school` VALUES (723, '4131014023', '上海工会管理职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (724, '4131014179', '上海体育职业学院', '31', '上海市', '3101', '上海市', '专科', '上海市', NULL);
INSERT INTO `school` VALUES (725, '4131014394', '上海民航职业技术学院', '31', '上海市', '3101', '上海市', '专科', '交通运输部', NULL);
INSERT INTO `school` VALUES (726, '4132010284', '南京大学', '32', '江苏省', '3201', '南京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (727, '4132010285', '苏州大学', '32', '江苏省', '3205', '苏州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (728, '4132010286', '东南大学', '32', '江苏省', '3201', '南京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (729, '4132010287', '南京航空航天大学', '32', '江苏省', '3201', '南京市', '本科', '工业和信息化部', NULL);
INSERT INTO `school` VALUES (730, '4132010288', '南京理工大学', '32', '江苏省', '3201', '南京市', '本科', '工业和信息化部', NULL);
INSERT INTO `school` VALUES (731, '4132010289', '江苏科技大学', '32', '江苏省', '3211', '镇江市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (732, '4132010290', '中国矿业大学', '32', '江苏省', '3203', '徐州市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (733, '4132010291', '南京工业大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (734, '4132010292', '常州大学', '32', '江苏省', '3204', '常州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (735, '4132010293', '南京邮电大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (736, '4132010294', '河海大学', '32', '江苏省', '3201', '南京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (737, '4132010295', '江南大学', '32', '江苏省', '3202', '无锡市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (738, '4132010298', '南京林业大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (739, '4132010299', '江苏大学', '32', '江苏省', '3211', '镇江市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (740, '4132010300', '南京信息工程大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (741, '4132010304', '南通大学', '32', '江苏省', '3206', '南通市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (742, '4132010305', '盐城工学院', '32', '江苏省', '3209', '盐城市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (743, '4132010307', '南京农业大学', '32', '江苏省', '3201', '南京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (744, '4132010312', '南京医科大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (745, '4132010313', '徐州医科大学', '32', '江苏省', '3203', '徐州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (746, '4132010315', '南京中医药大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (747, '4132010316', '中国药科大学', '32', '江苏省', '3201', '南京市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (748, '4132010319', '南京师范大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (749, '4132010320', '江苏师范大学', '32', '江苏省', '3203', '徐州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (750, '4132010323', '淮阴师范学院', '32', '江苏省', '3208', '淮安市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (751, '4132010324', '盐城师范学院', '32', '江苏省', '3209', '盐城市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (752, '4132010327', '南京财经大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (753, '4132010329', '江苏警官学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (754, '4132010330', '南京体育学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (755, '4132010331', '南京艺术学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (756, '4132010332', '苏州科技大学', '32', '江苏省', '3205', '苏州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (757, '4132010333', '常熟理工学院', '32', '江苏省', '3205', '苏州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (758, '4132011049', '淮阴工学院', '32', '江苏省', '3208', '淮安市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (759, '4132011055', '常州工学院', '32', '江苏省', '3204', '常州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (760, '4132011117', '扬州大学', '32', '江苏省', '3210', '扬州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (761, '4132011122', '三江学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (762, '4132011276', '南京工程学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (763, '4132011287', '南京审计大学', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (764, '4132011460', '南京晓庄学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (765, '4132011463', '江苏理工学院', '32', '江苏省', '3204', '常州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (766, '4132011641', '淮海工学院', '32', '江苏省', '3207', '连云港市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (767, '4132011998', '徐州工程学院', '32', '江苏省', '3203', '徐州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (768, '4132012048', '南京特殊教育师范学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (769, '4132012056', '南通理工学院', '32', '江苏省', '3206', '南通市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (770, '4132012213', '南京森林警察学院', '32', '江苏省', '3201', '南京市', '本科', '国家林业局', NULL);
INSERT INTO `school` VALUES (771, '4132012689', '东南大学成贤学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (772, '4132012917', '泰州学院', '32', '江苏省', '3212', '泰州市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (773, '4132013571', '无锡太湖学院', '32', '江苏省', '3202', '无锡市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (774, '4132013573', '金陵科技学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (775, '4132013579', '中国矿业大学徐海学院', '32', '江苏省', '3203', '徐州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (776, '4132013646', '南京大学金陵学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (777, '4132013654', '南京理工大学紫金学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (778, '4132013655', '南京航空航天大学金城学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (779, '4132013687', '中国传媒大学南广学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (780, '4132013842', '南京理工大学泰州科技学院', '32', '江苏省', '3212', '泰州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (781, '4132013843', '南京师范大学泰州学院', '32', '江苏省', '3212', '泰州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (782, '4132013905', '南京工业大学浦江学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (783, '4132013906', '南京师范大学中北学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (784, '4132013980', '南京医科大学康达学院', '32', '江苏省', '3207', '连云港市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (785, '4132013981', '南京中医药大学翰林学院', '32', '江苏省', '3212', '泰州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (786, '4132013982', '南京信息工程大学滨江学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (787, '4132013983', '苏州大学文正学院', '32', '江苏省', '3205', '苏州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (788, '4132013984', '苏州大学应用技术学院', '32', '江苏省', '3205', '苏州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (789, '4132013985', '苏州科技大学天平学院', '32', '江苏省', '3205', '苏州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (790, '4132013986', '江苏大学京江学院', '32', '江苏省', '3211', '镇江市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (791, '4132013987', '扬州大学广陵学院', '32', '江苏省', '3210', '扬州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (792, '4132013988', '江苏师范大学科文学院', '32', '江苏省', '3203', '徐州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (793, '4132013989', '南京邮电大学通达学院', '32', '江苏省', '3210', '扬州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (794, '4132013990', '南京财经大学红山学院', '32', '江苏省', '3211', '镇江市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (795, '4132013991', '江苏科技大学苏州理工学院', '32', '江苏省', '320582', '张家港市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (796, '4132013992', '常州大学怀德学院', '32', '江苏省', '3212', '泰州市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (797, '4132013993', '南通大学杏林学院', '32', '江苏省', '3206', '南通市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (798, '4132013994', '南京审计大学金审学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (799, '4132014160', '宿迁学院', '32', '江苏省', '3213', '宿迁市', '本科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (800, '4132014436', '江苏第二师范学院', '32', '江苏省', '3201', '南京市', '本科', '江苏省', NULL);
INSERT INTO `school` VALUES (801, '4132016403', '西交利物浦大学', '32', '江苏省', '3205', '苏州市', '本科', '江苏省教育厅', '中外合作办学');
INSERT INTO `school` VALUES (802, '4132016406', '昆山杜克大学', '32', '江苏省', '320583', '昆山市', '本科', '江苏省教育厅', '中外合作办学');
INSERT INTO `school` VALUES (803, '3632000466', '盐城幼儿师范高等专科学校', '32', '江苏省', '3209', '盐城市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (804, '3632000583', '苏州幼儿师范高等专科学校', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (805, '4132010826', '明达职业技术学院', '32', '江苏省', '3209', '盐城市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (806, '4132010848', '无锡职业技术学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (807, '4132010849', '江苏建筑职业技术学院', '32', '江苏省', '3203', '徐州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (808, '4132010850', '南京工业职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (809, '4132010958', '江苏工程职业技术学院', '32', '江苏省', '3206', '南通市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (810, '4132010960', '苏州工艺美术职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (811, '4132011050', '连云港职业技术学院', '32', '江苏省', '3207', '连云港市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (812, '4132011051', '镇江市高等专科学校', '32', '江苏省', '3211', '镇江市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (813, '4132011052', '南通职业大学', '32', '江苏省', '3206', '南通市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (814, '4132011054', '苏州职业大学', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (815, '4132011288', '沙洲职业工学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (816, '4132011462', '扬州市职业大学', '32', '江苏省', '3210', '扬州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (817, '4132011585', '连云港师范高等专科学校', '32', '江苏省', '3207', '连云港市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (818, '4132012047', '江苏经贸职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (819, '4132012054', '九州职业技术学院', '32', '江苏省', '3203', '徐州市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (820, '4132012078', '硅湖职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (821, '4132012106', '泰州职业技术学院', '32', '江苏省', '3212', '泰州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (822, '4132012317', '常州信息职业技术学院', '32', '江苏省', '3204', '常州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (823, '4132012678', '江苏联合职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (824, '4132012679', '江苏海事职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (825, '4132012680', '应天职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (826, '4132012681', '无锡科技职业学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (827, '4132012682', '江苏医药职业学院', '32', '江苏省', '3209', '盐城市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (828, '4132012683', '扬州环境资源职业技术学院', '32', '江苏省', '3210', '扬州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (829, '4132012684', '南通科技职业学院', '32', '江苏省', '3206', '南通市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (830, '4132012685', '苏州经贸职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (831, '4132012686', '苏州工业职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (832, '4132012687', '苏州托普信息职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (833, '4132012688', '苏州卫生职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (834, '4132012702', '无锡商业职业技术学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (835, '4132012703', '南通航运职业技术学院', '32', '江苏省', '3206', '南通市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (836, '4132012804', '南京交通职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (837, '4132012805', '淮安信息职业技术学院', '32', '江苏省', '3208', '淮安市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (838, '4132012806', '江苏农牧科技职业学院', '32', '江苏省', '3212', '泰州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (839, '4132012807', '常州纺织服装职业技术学院', '32', '江苏省', '3204', '常州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (840, '4132012808', '苏州农业职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (841, '4132012809', '苏州工业园区职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (842, '4132012918', '太湖创意职业技术学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (843, '4132012919', '炎黄职业技术学院', '32', '江苏省', '3208', '淮安市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (844, '4132012920', '南京科技职业学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (845, '4132012921', '正德职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (846, '4132012922', '钟山职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (847, '4132012923', '无锡南洋职业技术学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (848, '4132013017', '江南影视艺术职业学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (849, '4132013100', '金肯职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (850, '4132013101', '常州轻工职业技术学院', '32', '江苏省', '3204', '常州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (851, '4132013102', '常州工程职业技术学院', '32', '江苏省', '3204', '常州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (852, '4132013103', '江苏农林职业技术学院', '32', '江苏省', '3211', '镇江市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (853, '4132013104', '江苏食品药品职业技术学院', '32', '江苏省', '3208', '淮安市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (854, '4132013105', '建东职业技术学院', '32', '江苏省', '3204', '常州市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (855, '4132013106', '南京铁道职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (856, '4132013107', '徐州工业职业技术学院', '32', '江苏省', '3203', '徐州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (857, '4132013108', '江苏信息职业技术学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (858, '4132013110', '宿迁职业技术学院', '32', '江苏省', '3213', '宿迁市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (859, '4132013112', '南京信息职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (860, '4132013113', '江海职业技术学院', '32', '江苏省', '3210', '扬州市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (861, '4132013114', '常州机电职业技术学院', '32', '江苏省', '3204', '常州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (862, '4132013137', '江阴职业技术学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (863, '4132013748', '无锡城市职业技术学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (864, '4132013749', '无锡工艺职业技术学院', '32', '江苏省', '3202', '无锡市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (865, '4132013750', '金山职业技术学院', '32', '江苏省', '3211', '镇江市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (866, '4132013751', '苏州健雄职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (867, '4132013752', '盐城工业职业技术学院', '32', '江苏省', '3209', '盐城市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (868, '4132013753', '江苏财经职业技术学院', '32', '江苏省', '3208', '淮安市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (869, '4132013754', '扬州工业职业技术学院', '32', '江苏省', '3210', '扬州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (870, '4132013962', '苏州百年职业学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省教育厅', '中外合作办学');
INSERT INTO `school` VALUES (871, '4132013963', '昆山登云科技职业学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (872, '4132013964', '南京视觉艺术职业学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (873, '4132014000', '江苏城市职业学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (874, '4132014001', '南京城市职业学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (875, '4132014056', '南京机电职业技术学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (876, '4132014163', '苏州高博软件技术职业学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (877, '4132014180', '南京旅游职业学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (878, '4132014255', '江苏卫生健康职业学院', '32', '江苏省', '3201', '南京市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (879, '4132014256', '苏州信息职业技术学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (880, '4132014293', '宿迁泽达职业技术学院', '32', '江苏省', '3213', '宿迁市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (881, '4132014295', '苏州工业园区服务外包\n职业学院', '32', '江苏省', '3205', '苏州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (882, '4132014329', '徐州幼儿师范高等专科学校', '32', '江苏省', '3203', '徐州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (883, '4132014401', '徐州生物工程职业技术学院', '32', '江苏省', '3203', '徐州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (884, '4132014475', '江苏商贸职业学院', '32', '江苏省', '3206', '南通市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (885, '4132014493', '南通师范高等专科学校', '32', '江苏省', '3206', '南通市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (886, '4132014528', '扬州中瑞酒店职业学院', '32', '江苏省', '3210', '扬州市', '专科', '江苏省教育厅', '民办');
INSERT INTO `school` VALUES (887, '4132014541', '江苏护理职业学院', '32', '江苏省', '3208', '淮安市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (888, '4132014542', '江苏财会职业学院', '32', '江苏省', '3207', '连云港市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (889, '4132014543', '江苏城乡建设职业学院', '32', '江苏省', '3204', '常州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (890, '4132014568', '江苏航空职业技术学院', '32', '江苏省', '3211', '镇江市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (891, '4132014589', '江苏安全技术职业学院', '32', '江苏省', '3203', '徐州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (892, '4132014604', '江苏旅游职业学院', '32', '江苏省', '3210', '扬州市', '专科', '江苏省', NULL);
INSERT INTO `school` VALUES (893, '4133010335', '浙江大学', '33', '浙江省', '3301', '杭州市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (894, '4133010336', '杭州电子科技大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (895, '4133010337', '浙江工业大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (896, '4133010338', '浙江理工大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (897, '4133010340', '浙江海洋大学', '33', '浙江省', '3309', '舟山市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (898, '4133010341', '浙江农林大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (899, '4133010343', '温州医科大学', '33', '浙江省', '3303', '温州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (900, '4133010344', '浙江中医药大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (901, '4133010345', '浙江师范大学', '33', '浙江省', '3307', '金华市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (902, '4133010346', '杭州师范大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (903, '4133010347', '湖州师范学院', '33', '浙江省', '3305', '湖州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (904, '4133010349', '绍兴文理学院', '33', '浙江省', '3306', '绍兴市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (905, '4133010350', '台州学院', '33', '浙江省', '3310', '台州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (906, '4133010351', '温州大学', '33', '浙江省', '3303', '温州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (907, '4133010352', '丽水学院', '33', '浙江省', '3311', '丽水市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (908, '4133010353', '浙江工商大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (909, '4133010354', '嘉兴学院', '33', '浙江省', '3304', '嘉兴市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (910, '4133010355', '中国美术学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (911, '4133010356', '中国计量大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (912, '4133010829', '公安海警学院', '33', '浙江省', '3302', '宁波市', '本科', '公安部', NULL);
INSERT INTO `school` VALUES (913, '4133010876', '浙江万里学院', '33', '浙江省', '3302', '宁波市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (914, '4133011057', '浙江科技学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (915, '4133011058', '宁波工程学院', '33', '浙江省', '3302', '宁波市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (916, '4133011481', '浙江水利水电学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (917, '4133011482', '浙江财经大学', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (918, '4133011483', '浙江警察学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (919, '4133011488', '衢州学院', '33', '浙江省', '3308', '衢州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (920, '4133011646', '宁波大学', '33', '浙江省', '3302', '宁波市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (921, '4133011647', '浙江传媒学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (922, '4133011842', '浙江树人学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (923, '4133012792', '浙江越秀外国语学院', '33', '浙江省', '3306', '绍兴市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (924, '4133013001', '宁波大红鹰学院', '33', '浙江省', '3302', '宁波市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (925, '4133013021', '浙江大学城市学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (926, '4133013022', '浙江大学宁波理工学院', '33', '浙江省', '3302', '宁波市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (927, '4133013023', '杭州医学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (928, '4133013275', '浙江工业大学之江学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (929, '4133013276', '浙江师范大学行知学院', '33', '浙江省', '3307', '金华市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (930, '4133013277', '宁波大学科学技术学院', '33', '浙江省', '3302', '宁波市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (931, '4133013279', '杭州电子科技大学信息工程\n学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (932, '4133013280', '浙江理工大学科技与艺术\n学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (933, '4133013282', '浙江海洋大学东海科学技术\n学院', '33', '浙江省', '3309', '舟山市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (934, '4133013283', '浙江农林大学暨阳学院', '33', '浙江省', '3306', '绍兴市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (935, '4133013284', '温州医科大学仁济学院', '33', '浙江省', '3303', '温州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (936, '4133013285', '浙江中医药大学滨江学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (937, '4133013286', '杭州师范大学钱江学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (938, '4133013287', '湖州师范学院求真学院', '33', '浙江省', '3305', '湖州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (939, '4133013288', '绍兴文理学院元培学院', '33', '浙江省', '3306', '绍兴市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (940, '4133013289', '温州大学瓯江学院', '33', '浙江省', '3303', '温州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (941, '4133013290', '浙江工商大学杭州商学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (942, '4133013291', '嘉兴学院南湖学院', '33', '浙江省', '3304', '嘉兴市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (943, '4133013292', '中国计量大学现代科技学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (944, '4133013294', '浙江财经大学东方学院', '33', '浙江省', '3304', '嘉兴市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (945, '4133013637', '温州商学院', '33', '浙江省', '3303', '温州市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (946, '4133014206', '同济大学浙江学院', '33', '浙江省', '3304', '嘉兴市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (947, '4133014207', '上海财经大学浙江学院', '33', '浙江省', '3307', '金华市', '本科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (948, '4133014275', '浙江外国语学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (949, '4133014535', '浙江音乐学院', '33', '浙江省', '3301', '杭州市', '本科', '浙江省', NULL);
INSERT INTO `school` VALUES (950, '4133016301', '宁波诺丁汉大学', '33', '浙江省', '3302', '宁波市', '本科', '浙江省教育厅', '中外合作办学');
INSERT INTO `school` VALUES (951, '4133016405', '温州肯恩大学', '33', '浙江省', '3303', '温州市', '本科', '浙江省教育厅', '中外合作办学');
INSERT INTO `school` VALUES (952, '4133010863', '宁波职业技术学院', '33', '浙江省', '3302', '宁波市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (953, '4133010864', '温州职业技术学院', '33', '浙江省', '3303', '温州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (954, '4133012036', '浙江交通职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (955, '4133012061', '金华职业技术学院', '33', '浙江省', '3307', '金华市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (956, '4133012645', '宁波城市职业技术学院', '33', '浙江省', '3302', '宁波市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (957, '4133012646', '浙江电力职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (958, '4133012647', '浙江同济科技职业学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (959, '4133012789', '浙江工商职业技术学院', '33', '浙江省', '3302', '宁波市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (960, '4133012790', '台州职业技术学院', '33', '浙江省', '3310', '台州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (961, '4133012791', '浙江工贸职业技术学院', '33', '浙江省', '3303', '温州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (962, '4133012860', '浙江医药高等专科学校', '33', '浙江省', '3302', '宁波市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (963, '4133012861', '浙江机电职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (964, '4133012862', '浙江建设职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (965, '4133012863', '浙江艺术职业学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (966, '4133012864', '浙江经贸职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (967, '4133012865', '浙江商业职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (968, '4133012866', '浙江经济职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (969, '4133012867', '浙江旅游职业学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (970, '4133012868', '浙江育英职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (971, '4133012869', '浙江警官职业学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (972, '4133012870', '浙江金融职业学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (973, '4133012871', '浙江工业职业技术学院', '33', '浙江省', '3306', '绍兴市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (974, '4133012872', '杭州职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (975, '4133012874', '嘉兴职业技术学院', '33', '浙江省', '3304', '嘉兴市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (976, '4133012875', '湖州职业技术学院', '33', '浙江省', '3305', '湖州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (977, '4133012876', '绍兴职业技术学院', '33', '浙江省', '3306', '绍兴市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (978, '4133012877', '衢州职业技术学院', '33', '浙江省', '3308', '衢州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (979, '4133012878', '丽水职业技术学院', '33', '浙江省', '3311', '丽水市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (980, '4133013002', '浙江东方职业技术学院', '33', '浙江省', '3303', '温州市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (981, '4133013003', '义乌工商职业技术学院', '33', '浙江省', '3307', '金华市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (982, '4133013025', '浙江纺织服装职业技术学院', '33', '浙江省', '3302', '宁波市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (983, '4133013026', '杭州科技职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (984, '4133013027', '浙江长征职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (985, '4133013028', '嘉兴南洋职业技术学院', '33', '浙江省', '3304', '嘉兴市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (986, '4133013029', '浙江广厦建设职业技术学院', '33', '浙江省', '3307', '金华市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (987, '4133013030', '杭州万向职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (988, '4133013688', '浙江邮电职业技术学院', '33', '浙江省', '3306', '绍兴市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (989, '4133013742', '宁波卫生职业技术学院', '33', '浙江省', '3302', '宁波市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (990, '4133013746', '台州科技职业学院', '33', '浙江省', '3310', '台州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (991, '4133013853', '浙江国际海运职业技术学院', '33', '浙江省', '3309', '舟山市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (992, '4133013854', '浙江体育职业技术学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (993, '4133014088', '温州科技职业学院', '33', '浙江省', '3303', '温州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (994, '4133014089', '浙江汽车职业技术学院', '33', '浙江省', '3310', '台州市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (995, '4133014090', '浙江横店影视职业学院', '33', '浙江省', '3307', '金华市', '专科', '浙江省教育厅', '民办');
INSERT INTO `school` VALUES (996, '4133014269', '浙江农业商贸职业学院', '33', '浙江省', '3306', '绍兴市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (997, '4133014431', '浙江特殊教育职业学院', '33', '浙江省', '3301', '杭州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (998, '4133014492', '浙江安防职业技术学院', '33', '浙江省', '3303', '温州市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (999, '4133016408', '浙江舟山群岛新区旅游与健康\n职业学院', '33', '浙江省', '3309', '舟山市', '专科', '浙江省', NULL);
INSERT INTO `school` VALUES (1000, '4134010357', '安徽大学', '34', '安徽省', '3401', '合肥市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1001, '4134010358', '中国科学技术大学', '34', '安徽省', '3401', '合肥市', '本科', '中国科学院', NULL);
INSERT INTO `school` VALUES (1002, '4134010359', '合肥工业大学', '34', '安徽省', '3401', '合肥市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1003, '4134010360', '安徽工业大学', '34', '安徽省', '3405', '马鞍山市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1004, '4134010361', '安徽理工大学', '34', '安徽省', '3404', '淮南市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1005, '4134010363', '安徽工程大学', '34', '安徽省', '3402', '芜湖市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1006, '4134010364', '安徽农业大学', '34', '安徽省', '3401', '合肥市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1007, '4134010366', '安徽医科大学', '34', '安徽省', '3401', '合肥市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1008, '4134010367', '蚌埠医学院', '34', '安徽省', '3403', '蚌埠市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1009, '4134010368', '皖南医学院', '34', '安徽省', '3402', '芜湖市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1010, '4134010369', '安徽中医药大学', '34', '安徽省', '3401', '合肥市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1011, '4134010370', '安徽师范大学', '34', '安徽省', '3402', '芜湖市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1012, '4134010371', '阜阳师范学院', '34', '安徽省', '3412', '阜阳市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1013, '4134010372', '安庆师范大学', '34', '安徽省', '3408', '安庆市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1014, '4134010373', '淮北师范大学', '34', '安徽省', '3406', '淮北市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1015, '4134010375', '黄山学院', '34', '安徽省', '3410', '黄山市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1016, '4134010376', '皖西学院', '34', '安徽省', '3415', '六安市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1017, '4134010377', '滁州学院', '34', '安徽省', '3411', '滁州市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1018, '4134010378', '安徽财经大学', '34', '安徽省', '3403', '蚌埠市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1019, '4134010379', '宿州学院', '34', '安徽省', '3413', '宿州市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1020, '4134010380', '巢湖学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1021, '4134010381', '淮南师范学院', '34', '安徽省', '3404', '淮南市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1022, '4134010383', '铜陵学院', '34', '安徽省', '3407', '铜陵市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1023, '4134010878', '安徽建筑大学', '34', '安徽省', '3401', '合肥市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1024, '4134010879', '安徽科技学院', '34', '安徽省', '3411', '滁州市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1025, '4134010959', '安徽三联学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1026, '4134011059', '合肥学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1027, '4134011305', '蚌埠学院', '34', '安徽省', '3403', '蚌埠市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1028, '4134011306', '池州学院', '34', '安徽省', '3417', '池州市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1029, '4134012216', '安徽新华学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1030, '4134012810', '安徽文达信息工程学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1031, '4134012926', '亳州学院', '34', '安徽省', '3416', '亳州市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1032, '4134013065', '安徽外国语学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1033, '4134013611', '安徽财经大学商学院', '34', '安徽省', '3403', '蚌埠市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1034, '4134013612', '安徽大学江淮学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1035, '4134013613', '安徽信息工程学院', '34', '安徽省', '3402', '芜湖市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1036, '4134013614', '安徽工业大学工商学院', '34', '安徽省', '3405', '马鞍山市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1037, '4134013615', '安徽建筑大学城市建设学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1038, '4134013616', '安徽农业大学经济技术学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1039, '4134013617', '安徽师范大学皖江学院', '34', '安徽省', '3402', '芜湖市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1040, '4134013618', '安徽医科大学临床医学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1041, '4134013619', '阜阳师范学院信息工程学院', '34', '安徽省', '3412', '阜阳市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1042, '4134013620', '淮北师范大学信息学院', '34', '安徽省', '3406', '淮北市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1043, '4134014098', '合肥师范学院', '34', '安徽省', '3401', '合肥市', '本科', '安徽省', NULL);
INSERT INTO `school` VALUES (1044, '4134014203', '河海大学文天学院', '34', '安徽省', '3405', '马鞍山市', '本科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1045, '4134010869', '安徽职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1046, '4134010963', '淮北职业技术学院', '34', '安徽省', '3406', '淮北市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1047, '4134011061', '芜湖职业技术学院', '34', '安徽省', '3402', '芜湖市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1048, '4134011308', '淮南联合大学', '34', '安徽省', '3404', '淮南市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1049, '4134012072', '安徽商贸职业技术学院', '34', '安徽省', '3402', '芜湖市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1050, '4134012073', '安徽水利水电职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1051, '4134012074', '阜阳职业技术学院', '34', '安徽省', '3412', '阜阳市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1052, '4134012217', '铜陵职业技术学院', '34', '安徽省', '3407', '铜陵市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1053, '4134012218', '民办万博科技职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1054, '4134012219', '安徽警官职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1055, '4134012220', '淮南职业技术学院', '34', '安徽省', '3404', '淮南市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1056, '4134012334', '安徽工业经济职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1057, '4134012410', '合肥通用职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1058, '4134012811', '安徽工贸职业技术学院', '34', '安徽省', '3404', '淮南市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1059, '4134012812', '宿州职业技术学院', '34', '安徽省', '3413', '宿州市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1060, '4134012813', '六安职业技术学院', '34', '安徽省', '3415', '六安市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1061, '4134012814', '安徽电子信息职业技术学院', '34', '安徽省', '3403', '蚌埠市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1062, '4134012815', '民办合肥经济技术职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1063, '4134012816', '安徽交通职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1064, '4134012817', '安徽体育运动职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1065, '4134012924', '安徽中医药高等专科学校', '34', '安徽省', '3402', '芜湖市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1066, '4134012925', '安徽医学高等专科学校', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1067, '4134013058', '合肥职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1068, '4134013059', '滁州职业技术学院', '34', '安徽省', '3411', '滁州市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1069, '4134013060', '池州职业技术学院', '34', '安徽省', '3417', '池州市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1070, '4134013061', '宣城职业技术学院', '34', '安徽省', '3418', '宣城市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1071, '4134013062', '安徽广播影视职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1072, '4134013064', '民办合肥滨湖职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1073, '4134013336', '安徽电气工程职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1074, '4134013337', '安徽冶金科技职业学院', '34', '安徽省', '3405', '马鞍山市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1075, '4134013338', '安徽城市管理职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1076, '4134013339', '安徽机电职业技术学院', '34', '安徽省', '3402', '芜湖市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1077, '4134013340', '安徽工商职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1078, '4134013341', '安徽中澳科技职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1079, '4134013342', '阜阳科技职业学院', '34', '安徽省', '3412', '阜阳市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1080, '4134013343', '亳州职业技术学院', '34', '安徽省', '3416', '亳州市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1081, '4134013344', '安徽国防科技职业学院', '34', '安徽省', '3415', '六安市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1082, '4134013345', '安庆职业技术学院', '34', '安徽省', '3408', '安庆市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1083, '4134013346', '安徽艺术职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1084, '4134013760', '马鞍山师范高等专科学校', '34', '安徽省', '3405', '马鞍山市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1085, '4134013845', '安徽财贸职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1086, '4134013846', '安徽国际商务职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1087, '4134013847', '安徽公安职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1088, '4134013848', '安徽林业职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1089, '4134013849', '安徽审计职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1090, '4134013850', '安徽新闻出版职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1091, '4134013851', '安徽邮电职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1092, '4134013852', '安徽工业职业技术学院', '34', '安徽省', '3407', '铜陵市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1093, '4134014058', '民办合肥财经职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1094, '4134014096', '安庆医药高等专科学校', '34', '安徽省', '3408', '安庆市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1095, '4134014132', '安徽涉外经济职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1096, '4134014133', '安徽绿海商务职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1097, '4134014135', '合肥共达职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1098, '4134014137', '蚌埠经济技术职业学院', '34', '安徽省', '3403', '蚌埠市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1099, '4134014165', '民办安徽旅游职业学院', '34', '安徽省', '3412', '阜阳市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1100, '4134014191', '徽商职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1101, '4134014192', '马鞍山职业技术学院', '34', '安徽省', '3405', '马鞍山市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1102, '4134014210', '安徽现代信息工程职业学院', '34', '安徽省', '3415', '六安市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1103, '4134014229', '安徽矿业职业技术学院', '34', '安徽省', '3406', '淮北市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1104, '4134014230', '合肥信息技术职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1105, '4134014273', '桐城师范高等专科学校', '34', '安徽省', '3408', '安庆市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1106, '4134014296', '黄山职业技术学院', '34', '安徽省', '3410', '黄山市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1107, '4134014297', '滁州城市职业学院', '34', '安徽省', '3411', '滁州市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1108, '4134014298', '安徽汽车职业技术学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1109, '4134014299', '皖西卫生职业学院', '34', '安徽省', '3415', '六安市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1110, '4134014330', '合肥幼儿师范高等专科学校', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1111, '4134014341', '安徽长江职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1112, '4134014342', '安徽扬子职业技术学院', '34', '安徽省', '3402', '芜湖市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1113, '4134014378', '安徽黄梅戏艺术职业学院', '34', '安徽省', '3408', '安庆市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1114, '4134014418', '安徽粮食工程职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1115, '4134014419', '安徽卫生健康职业学院', '34', '安徽省', '3417', '池州市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1116, '4134014420', '合肥科技职业学院', '34', '安徽省', '3401', '合肥市', '专科', '安徽省教育厅', '民办');
INSERT INTO `school` VALUES (1117, '4134014502', '皖北卫生职业学院', '34', '安徽省', '3413', '宿州市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1118, '4134014536', '阜阳幼儿师范高等专科学校', '34', '安徽省', '3412', '阜阳市', '专科', '安徽省', NULL);
INSERT INTO `school` VALUES (1119, '4135010384', '厦门大学', '35', '福建省', '3502', '厦门市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1120, '4135010385', '华侨大学', '35', '福建省', '3505', '泉州市', '本科', '国务院侨办', NULL);
INSERT INTO `school` VALUES (1121, '4135010386', '福州大学', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1122, '4135010388', '福建工程学院', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1123, '4135010389', '福建农林大学', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1124, '4135010390', '集美大学', '35', '福建省', '3502', '厦门市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1125, '4135010392', '福建医科大学', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1126, '4135010393', '福建中医药大学', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1127, '4135010394', '福建师范大学', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1128, '4135010395', '闽江学院', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1129, '4135010397', '武夷学院', '35', '福建省', '3507', '南平市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1130, '4135010398', '宁德师范学院', '35', '福建省', '3509', '宁德市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1131, '4135010399', '泉州师范学院', '35', '福建省', '3505', '泉州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1132, '4135010402', '闽南师范大学', '35', '福建省', '3506', '漳州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1133, '4135011062', '厦门理工学院', '35', '福建省', '3502', '厦门市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1134, '4135011311', '三明学院', '35', '福建省', '3504', '三明市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1135, '4135011312', '龙岩学院', '35', '福建省', '3508', '龙岩市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1136, '4135011313', '福建商学院', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1137, '4135011495', '福建警察学院', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1138, '4135011498', '莆田学院', '35', '福建省', '3503', '莆田市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1139, '4135011784', '仰恩大学', '35', '福建省', '3505', '泉州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1140, '4135012631', '厦门医学院', '35', '福建省', '3502', '厦门市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1141, '4135012709', '厦门华厦学院', '35', '福建省', '3502', '厦门市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1142, '4135012710', '闽南理工学院', '35', '福建省', '3505', '泉州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1143, '4135012992', '福建师范大学闽南科技学院', '35', '福建省', '3505', '泉州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1144, '4135012993', '福建农林大学东方学院', '35', '福建省', '3501', '福州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1145, '4135013115', '厦门工学院', '35', '福建省', '3502', '厦门市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1146, '4135013468', '阳光学院', '35', '福建省', '3501', '福州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1147, '4135013469', '厦门大学嘉庚学院', '35', '福建省', '3506', '漳州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1148, '4135013470', '福州大学至诚学院', '35', '福建省', '3501', '福州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1149, '4135013471', '集美大学诚毅学院', '35', '福建省', '3502', '厦门市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1150, '4135013472', '福建师范大学协和学院', '35', '福建省', '3501', '福州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1151, '4135013762', '福州外语外贸学院', '35', '福建省', '3501', '福州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1152, '4135013763', '福建江夏学院', '35', '福建省', '3501', '福州市', '本科', '福建省', NULL);
INSERT INTO `school` VALUES (1153, '4135013766', '泉州信息工程学院', '35', '福建省', '3505', '泉州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1154, '4135013773', '福州理工学院', '35', '福建省', '3501', '福州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1155, '4135014046', '福建农林大学金山学院', '35', '福建省', '3501', '福州市', '本科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1156, '4135010866', '福建船政交通职业学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1157, '4135011314', '漳州职业技术学院', '35', '福建省', '3506', '漳州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1158, '4135011315', '闽西职业技术学院', '35', '福建省', '3508', '龙岩市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1159, '4135011317', '黎明职业大学', '35', '福建省', '3505', '泉州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1160, '4135011499', '福建华南女子职业学院', '35', '福建省', '3501', '福州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1161, '4135011502', '福州职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1162, '4135012625', '福建林业职业技术学院', '35', '福建省', '3507', '南平市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1163, '4135012626', '福建信息职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1164, '4135012627', '福建水利电力职业技术学院', '35', '福建省', '3504', '三明市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1165, '4135012628', '福建电力职业技术学院', '35', '福建省', '3505', '泉州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1166, '4135012629', '厦门海洋职业技术学院', '35', '福建省', '3502', '厦门市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1167, '4135012630', '福建农业职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1168, '4135012633', '福建卫生职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1169, '4135012634', '泉州医学高等专科学校', '35', '福建省', '3505', '泉州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1170, '4135012708', '福州英华职业学院', '35', '福建省', '3501', '福州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1171, '4135012711', '泉州纺织服装职业学院', '35', '福建省', '3505', '泉州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1172, '4135012927', '泉州华光职业学院', '35', '福建省', '3505', '泉州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1173, '4135012928', '泉州理工职业学院', '35', '福建省', '3505', '泉州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1174, '4135013733', '福建警官职业学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1175, '4135013764', '闽北职业技术学院', '35', '福建省', '3507', '南平市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1176, '4135013765', '福州黎明职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1177, '4135013767', '厦门演艺职业学院', '35', '福建省', '3502', '厦门市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1178, '4135013768', '厦门华天涉外职业技术学院', '35', '福建省', '3502', '厦门市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1179, '4135013769', '福州科技职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1180, '4135013770', '泉州经贸职业技术学院', '35', '福建省', '3505', '泉州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1181, '4135013771', '福建对外经济贸易\n职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1182, '4135013772', '湄洲湾职业技术学院', '35', '福建省', '3503', '莆田市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1183, '4135013969', '福建生物工程职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1184, '4135013970', '福建艺术职业学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1185, '4135013972', '福建幼儿师范高等专科学校', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1186, '4135013973', '厦门城市职业学院', '35', '福建省', '3502', '厦门市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1187, '4135013975', '泉州工艺美术职业学院', '35', '福建省', '3505', '泉州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1188, '4135013976', '三明医学科技职业学院', '35', '福建省', '3504', '三明市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1189, '4135013977', '宁德职业技术学院', '35', '福建省', '3509', '宁德市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1190, '4135013978', '福州软件职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1191, '4135013979', '厦门兴才职业技术学院', '35', '福建省', '3502', '厦门市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1192, '4135014059', '厦门软件职业技术学院', '35', '福建省', '3502', '厦门市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1193, '4135014060', '福建体育职业技术学院', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1194, '4135014110', '漳州城市职业学院', '35', '福建省', '3506', '漳州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1195, '4135014111', '厦门南洋职业学院', '35', '福建省', '3502', '厦门市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1196, '4135014112', '厦门东海职业技术学院', '35', '福建省', '3502', '厦门市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1197, '4135014113', '漳州科技职业学院', '35', '福建省', '3506', '漳州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1198, '4135014115', '漳州理工职业学院', '35', '福建省', '3506', '漳州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1199, '4135014116', '武夷山职业学院', '35', '福建省', '3507', '南平市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1200, '4135014117', '漳州卫生职业学院', '35', '福建省', '3506', '漳州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1201, '4135014231', '泉州海洋职业学院', '35', '福建省', '3505', '泉州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1202, '4135014232', '泉州轻工职业学院', '35', '福建省', '3505', '泉州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1203, '4135014257', '厦门安防科技职业学院', '35', '福建省', '3502', '厦门市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1204, '4135014331', '泉州幼儿师范高等专科学校', '35', '福建省', '3505', '泉州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1205, '4135014490', '闽江师范高等专科学校', '35', '福建省', '3501', '福州市', '专科', '福建省', NULL);
INSERT INTO `school` VALUES (1206, '4135014503', '泉州工程职业技术学院', '35', '福建省', '3505', '泉州市', '专科', '福建省教育厅', '民办');
INSERT INTO `school` VALUES (1207, '4135016411', '福州墨尔本理工职业学院', '35', '福建省', '3501', '福州市', '专科', '福建省教育厅', '中外合作办学');
INSERT INTO `school` VALUES (1208, '4136010403', '南昌大学', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1209, '4136010404', '华东交通大学', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1210, '4136010405', '东华理工大学', '36', '江西省', '3610', '抚州市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1211, '4136010406', '南昌航空大学', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1212, '4136010407', '江西理工大学', '36', '江西省', '3607', '赣州市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1213, '4136010408', '景德镇陶瓷大学', '36', '江西省', '3602', '景德镇市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1214, '4136010410', '江西农业大学', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1215, '4136010412', '江西中医药大学', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1216, '4136010413', '赣南医学院', '36', '江西省', '3607', '赣州市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1217, '4136010414', '江西师范大学', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1218, '4136010416', '上饶师范学院', '36', '江西省', '3611', '上饶市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1219, '4136010417', '宜春学院', '36', '江西省', '3609', '宜春市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1220, '4136010418', '赣南师范大学', '36', '江西省', '3607', '赣州市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1221, '4136010419', '井冈山大学', '36', '江西省', '3608', '吉安市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1222, '4136010421', '江西财经大学', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1223, '4136010846', '江西科技学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1224, '4136010894', '景德镇学院', '36', '江西省', '3602', '景德镇市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1225, '4136010895', '萍乡学院', '36', '江西省', '3603', '萍乡市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1226, '4136011318', '江西科技师范大学', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1227, '4136011319', '南昌工程学院', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1228, '4136011504', '江西警察学院', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1229, '4136011508', '新余学院', '36', '江西省', '3605', '新余市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1230, '4136011843', '九江学院', '36', '江西省', '3604', '九江市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1231, '4136012766', '江西工程学院', '36', '江西省', '3605', '新余市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1232, '4136012795', '南昌理工学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1233, '4136012938', '江西应用科技学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1234, '4136013418', '江西服装学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1235, '4136013421', '南昌工学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1236, '4136013429', '南昌大学科学技术学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1237, '4136013430', '南昌大学共青学院', '36', '江西省', '3604', '九江市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1238, '4136013431', '华东交通大学理工学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1239, '4136013432', '东华理工大学长江学院', '36', '江西省', '3610', '抚州市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1240, '4136013433', '南昌航空大学科技学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1241, '4136013434', '江西理工大学应用科学学院', '36', '江西省', '3607', '赣州市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1242, '4136013435', '景德镇陶瓷大学科技艺术学院', '36', '江西省', '3602', '景德镇市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1243, '4136013436', '江西农业大学南昌商学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1244, '4136013437', '江西中医药大学科技学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1245, '4136013438', '江西师范大学科学技术学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1246, '4136013439', '赣南师范大学科技学院', '36', '江西省', '3607', '赣州市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1247, '4136013440', '江西科技师范大学理工学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1248, '4136013441', '江西财经大学现代经济管理\n学院', '36', '江西省', '3601', '南昌市', '本科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1249, '4136013774', '豫章师范学院', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1250, '4136014437', '南昌师范学院', '36', '江西省', '3601', '南昌市', '本科', '江西省', NULL);
INSERT INTO `school` VALUES (1251, '3636000312', '上饶幼儿师范高等专科学校', '36', '江西省', '3611', '上饶市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1252, '3636000519', '抚州幼儿师范高等专科学校', '36', '江西省', '3610', '抚州市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1253, '4136010839', '江西工业职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1254, '4136010888', '江西医学高等专科学校', '36', '江西省', '3611', '上饶市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1255, '4136011505', '九江职业大学', '36', '江西省', '3604', '九江市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1256, '4136011785', '九江职业技术学院', '36', '江西省', '3604', '九江市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1257, '4136012929', '江西司法警官职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1258, '4136012930', '江西陶瓷工艺美术职业技术\n学院', '36', '江西省', '3602', '景德镇市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1259, '4136012932', '江西旅游商贸职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1260, '4136012933', '江西电力职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1261, '4136012934', '江西环境工程职业学院', '36', '江西省', '3607', '赣州市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1262, '4136012936', '江西艺术职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1263, '4136012937', '鹰潭职业技术学院', '36', '江西省', '3606', '鹰潭市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1264, '4136012939', '江西信息应用职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1265, '4136012940', '江西交通职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1266, '4136012941', '江西财经职业学院', '36', '江西省', '3604', '九江市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1267, '4136012942', '江西应用技术职业学院', '36', '江西省', '3607', '赣州市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1268, '4136012943', '江西现代职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1269, '4136012944', '江西工业工程职业技术学院', '36', '江西省', '3603', '萍乡市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1270, '4136012976', '江西机电职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1271, '4136013419', '江西科技职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1272, '4136013420', '南昌职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1273, '4136013422', '江西外语外贸职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1274, '4136013423', '江西工业贸易职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1275, '4136013424', '宜春职业技术学院', '36', '江西省', '3609', '宜春市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1276, '4136013425', '江西应用工程职业学院', '36', '江西省', '3603', '萍乡市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1277, '4136013426', '江西生物科技职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1278, '4136013427', '江西建设职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1279, '4136013428', '抚州职业技术学院', '36', '江西省', '3610', '抚州市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1280, '4136013775', '江西中医药高等专科学校', '36', '江西省', '3610', '抚州市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1281, '4136013776', '江西先锋软件职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1282, '4136013866', '江西经济管理职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1283, '4136013867', '江西制造职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1284, '4136013868', '江西工程职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1285, '4136013869', '江西青年职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1286, '4136013870', '上饶职业技术学院', '36', '江西省', '3611', '上饶市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1287, '4136013871', '江西航空职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1288, '4136013872', '江西农业工程职业学院', '36', '江西省', '3609', '宜春市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1289, '4136013873', '赣西科技职业学院', '36', '江西省', '3605', '新余市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1290, '4136013965', '江西卫生职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1291, '4136014166', '江西新能源科技职业学院', '36', '江西省', '3605', '新余市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1292, '4136014167', '江西枫林涉外经贸职业学院', '36', '江西省', '3604', '九江市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1293, '4136014168', '江西泰豪动漫职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1294, '4136014241', '江西冶金职业技术学院', '36', '江西省', '3605', '新余市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1295, '4136014249', '江西管理职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1296, '4136014250', '江西传媒职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1297, '4136014321', '江西工商职业技术学院', '36', '江西省', '3601', '南昌市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1298, '4136014402', '景德镇陶瓷职业技术学院', '36', '江西省', '3602', '景德镇市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1299, '4136014403', '共青科技职业学院', '36', '江西省', '3604', '九江市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1300, '4136014465', '赣州师范高等专科学校', '36', '江西省', '3607', '赣州市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1301, '4136014476', '江西水利职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1302, '4136014494', '宜春幼儿师范高等专科学校', '36', '江西省', '3609', '宜春市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1303, '4136014504', '吉安职业技术学院', '36', '江西省', '3608', '吉安市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1304, '4136014505', '江西洪州职业学院', '36', '江西省', '3609', '宜春市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1305, '4136014537', '江西师范高等专科学校', '36', '江西省', '3606', '鹰潭市', '专科', '江西省       ', NULL);
INSERT INTO `school` VALUES (1306, '4136014544', '南昌影视传播职业学院', '36', '江西省', '3601', '南昌市', '专科', '江西省教育厅', '民办');
INSERT INTO `school` VALUES (1307, '4136014569', '赣南卫生健康职业学院', '36', '江西省', '3607', '赣州市', '专科', '江西省', NULL);
INSERT INTO `school` VALUES (1308, '4137010422', '山东大学', '37', '山东省', '3701', '济南市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1309, '4137010423', '中国海洋大学', '37', '山东省', '3702', '青岛市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1310, '4137010424', '山东科技大学', '37', '山东省', '3702', '青岛市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1311, '4137010425', '中国石油大学（华东）', '37', '山东省', '3702', '青岛市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1312, '4137010426', '青岛科技大学', '37', '山东省', '3702', '青岛市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1313, '4137010427', '济南大学', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1314, '4137010429', '青岛理工大学', '37', '山东省', '3702', '青岛市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1315, '4137010430', '山东建筑大学', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1316, '4137010431', '齐鲁工业大学', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1317, '4137010433', '山东理工大学', '37', '山东省', '3703', '淄博市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1318, '4137010434', '山东农业大学', '37', '山东省', '3709', '泰安市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1319, '4137010435', '青岛农业大学', '37', '山东省', '3702', '青岛市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1320, '4137010438', '潍坊医学院', '37', '山东省', '3707', '潍坊市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1321, '4137010439', '泰山医学院', '37', '山东省', '3709', '泰安市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1322, '4137010440', '滨州医学院', '37', '山东省', '3716', '滨州市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1323, '4137010441', '山东中医药大学', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1324, '4137010443', '济宁医学院', '37', '山东省', '3708', '济宁市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1325, '4137010445', '山东师范大学', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1326, '4137010446', '曲阜师范大学', '37', '山东省', '3708', '济宁市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1327, '4137010447', '聊城大学', '37', '山东省', '3715', '聊城市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1328, '4137010448', '德州学院', '37', '山东省', '3714', '德州市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1329, '4137010449', '滨州学院', '37', '山东省', '3716', '滨州市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1330, '4137010451', '鲁东大学', '37', '山东省', '3706', '烟台市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1331, '4137010452', '临沂大学', '37', '山东省', '3713', '临沂市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1332, '4137010453', '泰山学院', '37', '山东省', '3709', '泰安市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1333, '4137010454', '济宁学院', '37', '山东省', '3708', '济宁市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1334, '4137010455', '菏泽学院', '37', '山东省', '3717', '菏泽市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1335, '4137010456', '山东财经大学', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1336, '4137010457', '山东体育学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1337, '4137010458', '山东艺术学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1338, '4137010825', '齐鲁医药学院', '37', '山东省', '3703', '淄博市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1339, '4137010868', '青岛滨海学院', '37', '山东省', '3702', '青岛市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1340, '4137010904', '枣庄学院', '37', '山东省', '3704', '枣庄市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1341, '4137010908', '山东工艺美术学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1342, '4137011065', '青岛大学', '37', '山东省', '3702', '青岛市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1343, '4137011066', '烟台大学', '37', '山东省', '3706', '烟台市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1344, '4137011067', '潍坊学院', '37', '山东省', '3707', '潍坊市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1345, '4137011324', '山东警察学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1346, '4137011510', '山东交通学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1347, '4137011688', '山东工商学院', '37', '山东省', '3706', '烟台市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1348, '4137012331', '山东女子学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1349, '4137012332', '烟台南山学院', '37', '山东省', '3706', '烟台市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1350, '4137012843', '潍坊科技学院', '37', '山东省', '3707', '潍坊市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1351, '4137013006', '山东英才学院', '37', '山东省', '3701', '济南市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1352, '4137013015', '青岛恒星科技学院', '37', '山东省', '3702', '青岛市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1353, '4137013320', '青岛黄海学院', '37', '山东省', '3702', '青岛市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1354, '4137013322', '山东现代学院', '37', '山东省', '3701', '济南市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1355, '4137013324', '山东协和学院', '37', '山东省', '3701', '济南市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1356, '4137013359', '烟台大学文经学院', '37', '山东省', '3706', '烟台市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1357, '4137013373', '聊城大学东昌学院', '37', '山东省', '3715', '聊城市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1358, '4137013378', '青岛理工大学琴岛学院', '37', '山东省', '3702', '青岛市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1359, '4137013379', '山东师范大学历山学院', '37', '山东省', '3701', '济南市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1360, '4137013383', '山东财经大学燕山学院', '37', '山东省', '3701', '济南市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1361, '4137013386', '中国石油大学胜利学院', '37', '山东省', '3705', '东营市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1362, '4137013624', '山东科技大学泰山科技学院', '37', '山东省', '3709', '泰安市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1363, '4137013857', '山东华宇工学院', '37', '山东省', '3714', '德州市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1364, '4137013995', '青岛工学院', '37', '山东省', '3702', '青岛市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1365, '4137013997', '青岛农业大学海都学院', '37', '山东省', '3706', '烟台市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1366, '4137013998', '齐鲁理工学院', '37', '山东省', '3701', '济南市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1367, '4137013999', '山东财经大学东方学院', '37', '山东省', '3709', '泰安市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1368, '4137014002', '济南大学泉城学院', '37', '山东省', '3701', '济南市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1369, '4137014100', '山东政法学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1370, '4137014276', '齐鲁师范学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1371, '4137014277', '山东青年政治学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1372, '4137014327', '北京电影学院现代创意媒体\n学院', '37', '山东省', '3702', '青岛市', '本科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1373, '4137014438', '山东管理学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1374, '4137014439', '山东农业工程学院', '37', '山东省', '3701', '济南市', '本科', '山东省', NULL);
INSERT INTO `school` VALUES (1375, '4137010442', '山东医学高等专科学校', '37', '山东省', '3713', '临沂市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1376, '4137010444', '菏泽医学专科学校', '37', '山东省', '3717', '菏泽市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1377, '4137010832', '山东商业职业技术学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1378, '4137011827', '山东电力高等专科学校', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1379, '4137012062', '日照职业技术学院', '37', '山东省', '3711', '日照市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1380, '4137012070', '曲阜远东职业技术学院', '37', '山东省', '3708', '济宁市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1381, '4137012324', '青岛职业技术学院', '37', '山东省', '3702', '青岛市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1382, '4137012326', '威海职业学院', '37', '山东省', '3710', '威海市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1383, '4137012328', '山东职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1384, '4137012329', '山东劳动职业技术学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1385, '4137012330', '莱芜职业技术学院', '37', '山东省', '3712', '莱芜市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1386, '4137012335', '济宁职业技术学院', '37', '山东省', '3708', '济宁市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1387, '4137012391', '潍坊职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1388, '4137012396', '烟台职业学院', '37', '山东省', '3706', '烟台市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1389, '4137012440', '东营职业学院', '37', '山东省', '3705', '东营市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1390, '4137012441', '聊城职业技术学院', '37', '山东省', '3715', '聊城市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1391, '4137012818', '滨州职业学院', '37', '山东省', '3716', '滨州市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1392, '4137012819', '山东科技职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1393, '4137012841', '山东服装职业学院', '37', '山东省', '3709', '泰安市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1394, '4137012842', '德州科技职业学院', '37', '山东省', '3714', '德州市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1395, '4137012844', '山东力明科技职业学院', '37', '山东省', '3709', '泰安市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1396, '4137012945', '山东圣翰财贸职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1397, '4137012946', '山东水利职业学院', '37', '山东省', '3711', '日照市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1398, '4137012947', '山东畜牧兽医职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1399, '4137013005', '青岛飞洋职业技术学院', '37', '山东省', '3702', '青岛市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1400, '4137013007', '东营科技职业学院', '37', '山东省', '3705', '东营市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1401, '4137013008', '山东交通职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1402, '4137013009', '淄博职业学院', '37', '山东省', '3703', '淄博市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1403, '4137013010', '山东外贸职业学院', '37', '山东省', '3702', '青岛市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1404, '4137013011', '青岛酒店管理职业技术学院', '37', '山东省', '3702', '青岛市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1405, '4137013012', '山东信息职业技术学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1406, '4137013014', '青岛港湾职业技术学院', '37', '山东省', '3702', '青岛市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1407, '4137013316', '山东胜利职业学院', '37', '山东省', '3705', '东营市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1408, '4137013317', '山东经贸职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1409, '4137013318', '山东工业职业学院', '37', '山东省', '3703', '淄博市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1410, '4137013319', '山东化工职业学院', '37', '山东省', '3703', '淄博市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1411, '4137013321', '青岛求实职业技术学院', '37', '山东省', '3702', '青岛市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1412, '4137013323', '济南职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1413, '4137013355', '烟台工程职业技术学院', '37', '山东省', '3706', '烟台市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1414, '4137013356', '山东凯文科技职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1415, '4137013387', '山东外国语职业学院', '37', '山东省', '3711', '日照市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1416, '4137013388', '潍坊工商职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1417, '4137013389', '德州职业技术学院', '37', '山东省', '3714', '德州市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1418, '4137013390', '枣庄科技职业学院', '37', '山东省', '3704', '枣庄市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1419, '4137013777', '淄博师范高等专科学校', '37', '山东省', '3703', '淄博市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1420, '4137013778', '山东中医药高等专科学校', '37', '山东省', '3706', '烟台市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1421, '4137013855', '济南工程职业技术学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1422, '4137013856', '山东电子职业技术学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1423, '4137013858', '山东旅游职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1424, '4137013859', '山东铝业职业学院', '37', '山东省', '3703', '淄博市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1425, '4137013860', '山东杏林科技职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1426, '4137013861', '泰山职业技术学院', '37', '山东省', '3709', '泰安市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1427, '4137013874', '山东外事翻译职业学院', '37', '山东省', '3710', '威海市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1428, '4137013966', '山东药品食品职业学院', '37', '山东省', '3710', '威海市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1429, '4137014078', '山东商务职业学院', '37', '山东省', '3706', '烟台市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1430, '4137014079', '山东轻工职业学院', '37', '山东省', '3703', '淄博市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1431, '4137014080', '山东城市建设职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1432, '4137014081', '烟台汽车工程职业学院', '37', '山东省', '3706', '烟台市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1433, '4137014082', '山东司法警官职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1434, '4137014118', '菏泽家政职业学院', '37', '山东省', '3717', '菏泽市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1435, '4137014193', '山东传媒职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1436, '4137014195', '临沂职业学院', '37', '山东省', '3713', '临沂市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1437, '4137014196', '枣庄职业学院', '37', '山东省', '3704', '枣庄市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1438, '4137014242', '山东理工职业学院', '37', '山东省', '3708', '济宁市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1439, '4137014261', '山东文化产业职业学院', '37', '山东省', '3706', '烟台市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1440, '4137014320', '青岛远洋船员职业学院', '37', '山东省', '3702', '青岛市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1441, '4137014332', '济南幼儿师范高等专科学校', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1442, '4137014343', '济南护理职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1443, '4137014345', '泰山护理职业学院', '37', '山东省', '3709', '泰安市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1444, '4137014346', '山东海事职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1445, '4137014347', '潍坊护理职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1446, '4137014379', '潍坊工程职业学院', '37', '山东省', '3707', '潍坊市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1447, '4137014477', '菏泽职业学院', '37', '山东省', '3717', '菏泽市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1448, '4137014506', '山东艺术设计职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1449, '4137014507', '威海海洋职业学院', '37', '山东省', '3710', '威海市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1450, '4137014545', '山东特殊教育职业学院', '37', '山东省', '3701', '济南市', '专科', '山东省', NULL);
INSERT INTO `school` VALUES (1451, '4137014570', '烟台黄金职业学院', '37', '山东省', '3706', '烟台市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1452, '4137014605', '日照航海工程职业学院', '37', '山东省', '3711', '日照市', '专科', '山东省教育厅', '民办');
INSERT INTO `school` VALUES (1453, '4141010078', '华北水利水电大学', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1454, '4141010459', '郑州大学', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1455, '4141010460', '河南理工大学', '41', '河南省', '4108', '焦作市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1456, '4141010462', '郑州轻工业学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1457, '4141010463', '河南工业大学', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1458, '4141010464', '河南科技大学', '41', '河南省', '4103', '洛阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1459, '4141010465', '中原工学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1460, '4141010466', '河南农业大学', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1461, '4141010467', '河南科技学院', '41', '河南省', '4107', '新乡市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1462, '4141010469', '河南牧业经济学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1463, '4141010471', '河南中医药大学', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1464, '4141010472', '新乡医学院', '41', '河南省', '4107', '新乡市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1465, '4141010475', '河南大学', '41', '河南省', '4102', '开封市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1466, '4141010476', '河南师范大学', '41', '河南省', '4107', '新乡市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1467, '4141010477', '信阳师范学院', '41', '河南省', '4115', '信阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1468, '4141010478', '周口师范学院', '41', '河南省', '4116', '周口市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1469, '4141010479', '安阳师范学院', '41', '河南省', '4105', '安阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1470, '4141010480', '许昌学院', '41', '河南省', '4110', '许昌市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1471, '4141010481', '南阳师范学院', '41', '河南省', '4113', '南阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1472, '4141010482', '洛阳师范学院', '41', '河南省', '4103', '洛阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1473, '4141010483', '商丘师范学院', '41', '河南省', '4114', '商丘市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1474, '4141010484', '河南财经政法大学', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1475, '4141010485', '郑州航空工业管理学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1476, '4141010918', '黄淮学院', '41', '河南省', '4117', '驻马店市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1477, '4141010919', '平顶山学院', '41', '河南省', '4104', '平顶山市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1478, '4141011068', '郑州工程技术学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1479, '4141011070', '洛阳理工学院', '41', '河南省', '4103', '洛阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1480, '4141011071', '新乡学院', '41', '河南省', '4107', '新乡市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1481, '4141011326', '信阳农林学院', '41', '河南省', '4115', '信阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1482, '4141011329', '河南工学院', '41', '河南省', '4107', '新乡市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1483, '4141011330', '安阳工学院', '41', '河南省', '4105', '安阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1484, '4141011517', '河南工程学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1485, '4141011652', '河南财政金融学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1486, '4141011653', '南阳理工学院', '41', '河南省', '4113', '南阳市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1487, '4141011765', '河南城建学院', '41', '河南省', '4104', '平顶山市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1488, '4141011788', '河南警察学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1489, '4141011834', '黄河科技学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1490, '4141012735', '铁道警察学院', '41', '河南省', '4101', '郑州市', '本科', '公安部', NULL);
INSERT INTO `school` VALUES (1491, '4141012746', '郑州科技学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1492, '4141012747', '郑州工业应用技术学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1493, '4141012949', '郑州师范学院', '41', '河南省', '4101', '郑州市', '本科', '河南省', NULL);
INSERT INTO `school` VALUES (1494, '4141013497', '郑州财经学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1495, '4141013498', '黄河交通学院', '41', '河南省', '4108', '焦作市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1496, '4141013500', '商丘工学院', '41', '河南省', '4114', '商丘市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1497, '4141013501', '河南大学民生学院', '41', '河南省', '4102', '开封市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1498, '4141013502', '河南师范大学新联学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1499, '4141013503', '信阳学院', '41', '河南省', '4115', '信阳市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1500, '4141013504', '安阳学院', '41', '河南省', '4105', '安阳市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1501, '4141013505', '新乡医学院三全学院', '41', '河南省', '4107', '新乡市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1502, '4141013506', '河南科技学院新科学院', '41', '河南省', '4107', '新乡市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1503, '4141013507', '郑州工商学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1504, '4141013508', '中原工学院信息商务学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1505, '4141014003', '商丘学院', '41', '河南省', '4114', '商丘市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1506, '4141014040', '郑州成功财经学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1507, '4141014333', '郑州升达经贸管理学院', '41', '河南省', '4101', '郑州市', '本科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1508, '4141010824', '河南职业技术学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1509, '4141010835', '漯河职业技术学院', '41', '河南省', '4111', '漯河市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1510, '4141010842', '三门峡职业技术学院', '41', '河南省', '4112', '三门峡市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1511, '4141010843', '郑州铁路职业技术学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1512, '4141011069', '开封大学', '41', '河南省', '4102', '开封市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1513, '4141011522', '焦作大学', '41', '河南省', '4108', '焦作市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1514, '4141011787', '濮阳职业技术学院', '41', '河南省', '4109', '濮阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1515, '4141011828', '郑州电力高等专科学校', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1516, '4141012058', '黄河水利职业技术学院', '41', '河南省', '4102', '开封市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1517, '4141012067', '许昌职业技术学院', '41', '河南省', '4110', '许昌市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1518, '4141012581', '河南工业和信息化职业学院', '41', '河南省', '4108', '焦作市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1519, '4141012582', '河南水利与环境职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1520, '4141012745', '商丘职业技术学院', '41', '河南省', '4114', '商丘市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1521, '4141012748', '平顶山工业职业技术学院', '41', '河南省', '4104', '平顶山市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1522, '4141012750', '周口职业技术学院', '41', '河南省', '4116', '周口市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1523, '4141012768', '济源职业技术学院', '41', '河南省', '419001', '济源市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1524, '4141012781', '河南司法警官职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1525, '4141012793', '鹤壁职业技术学院', '41', '河南省', '4106', '鹤壁市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1526, '4141012794', '河南工业职业技术学院', '41', '河南省', '4113', '南阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1527, '4141012948', '郑州澍青医学高等专科学校', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1528, '4141012950', '焦作师范高等专科学校', '41', '河南省', '4108', '焦作市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1529, '4141013499', '河南检察职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1530, '4141013564', '河南质量工程职业学院', '41', '河南省', '4104', '平顶山市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1531, '4141013565', '郑州信息科技职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1532, '4141013780', '漯河医学高等专科学校', '41', '河南省', '4111', '漯河市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1533, '4141013781', '南阳医学高等专科学校', '41', '河南省', '4113', '南阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1534, '4141013782', '商丘医学高等专科学校', '41', '河南省', '4114', '商丘市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1535, '4141013783', '郑州电子信息职业技术学院', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1536, '4141013784', '信阳职业技术学院', '41', '河南省', '4115', '信阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1537, '4141013785', '嵩山少林武术职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1538, '4141013786', '郑州工业安全职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1539, '4141013787', '永城职业学院', '41', '河南省', '4114', '商丘市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1540, '4141013788', '河南经贸职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1541, '4141013789', '河南交通职业技术学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1542, '4141013790', '河南农业职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1543, '4141013791', '郑州旅游职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1544, '4141013792', '郑州职业技术学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1545, '4141013885', '河南信息统计职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1546, '4141013889', '河南林业职业学院', '41', '河南省', '4103', '洛阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1547, '4141013936', '河南工业贸易职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1548, '4141014062', '郑州电力职业技术学院', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1549, '4141014169', '周口科技职业学院', '41', '河南省', '4116', '周口市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1550, '4141014181', '河南建筑职业技术学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1551, '4141014233', '漯河食品职业学院', '41', '河南省', '4111', '漯河市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1552, '4141014235', '郑州城市职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1553, '4141014243', '安阳职业技术学院', '41', '河南省', '4105', '安阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1554, '4141014245', '新乡职业技术学院', '41', '河南省', '4107', '新乡市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1555, '4141014251', '驻马店职业技术学院', '41', '河南省', '4117', '驻马店市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1556, '4141014300', '焦作工贸职业学院', '41', '河南省', '4108', '焦作市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1557, '4141014301', '许昌陶瓷职业学院', '41', '河南省', '4110', '许昌市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1558, '4141014302', '郑州理工职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1559, '4141014303', '郑州信息工程职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1560, '4141014305', '长垣烹饪职业技术学院', '41', '河南省', '4107', '新乡市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1561, '4141014306', '开封文化艺术职业学院', '41', '河南省', '4102', '开封市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1562, '4141014307', '河南应用技术职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1563, '4141014308', '河南艺术职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1564, '4141014348', '河南机电职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1565, '4141014349', '河南护理职业学院', '41', '河南省', '4105', '安阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1566, '4141014350', '许昌电气职业学院', '41', '河南省', '4110', '许昌市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1567, '4141014351', '信阳涉外职业技术学院', '41', '河南省', '4115', '信阳市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1568, '4141014352', '鹤壁汽车工程职业学院', '41', '河南省', '4106', '鹤壁市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1569, '4141014353', '南阳职业学院', '41', '河南省', '4113', '南阳市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1570, '4141014380', '郑州商贸旅游职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1571, '4141014382', '河南推拿职业学院', '41', '河南省', '4103', '洛阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1572, '4141014383', '洛阳职业技术学院', '41', '河南省', '4103', '洛阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1573, '4141014391', '郑州幼儿师范高等专科学校', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1574, '4141014392', '安阳幼儿师范高等专科学校', '41', '河南省', '4105', '安阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1575, '4141014405', '郑州黄河护理职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1576, '4141014466', '河南医学高等专科学校', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1577, '4141014478', '郑州财税金融职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1578, '4141014479', '南阳农业职业学院', '41', '河南省', '4113', '南阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1579, '4141014480', '洛阳科技职业学院', '41', '河南省', '4103', '洛阳市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1580, '4141014529', '鹤壁能源化工职业学院', '41', '河南省', '4106', '鹤壁市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1581, '4141014530', '平顶山文化艺术职业学院', '41', '河南省', '4104', '平顶山市', '专科', '河南省教育厅', '民办');
INSERT INTO `school` VALUES (1582, '4141014597', '濮阳医学高等专科学校', '41', '河南省', '4109', '濮阳市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1583, '4141014598', '驻马店幼儿师范高等专科学校', '41', '河南省', '4117', '驻马店市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1584, '4141014606', '三门峡社会管理职业学院', '41', '河南省', '4112', '三门峡市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1585, '4141014607', '河南轻工职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1586, '4141014608', '河南测绘职业学院', '41', '河南省', '4101', '郑州市', '专科', '河南省', NULL);
INSERT INTO `school` VALUES (1587, '4142010486', '武汉大学', '42', '湖北省', '4201', '武汉市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1588, '4142010487', '华中科技大学', '42', '湖北省', '4201', '武汉市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1589, '4142010488', '武汉科技大学', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1590, '4142010489', '长江大学', '42', '湖北省', '4210', '荆州市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1591, '4142010490', '武汉工程大学', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1592, '4142010491', '中国地质大学（武汉）', '42', '湖北省', '4201', '武汉市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1593, '4142010495', '武汉纺织大学', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1594, '4142010496', '武汉轻工大学', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1595, '4142010497', '武汉理工大学', '42', '湖北省', '4201', '武汉市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1596, '4142010500', '湖北工业大学', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1597, '4142010504', '华中农业大学', '42', '湖北省', '4201', '武汉市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1598, '4142010507', '湖北中医药大学', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1599, '4142010511', '华中师范大学', '42', '湖北省', '4201', '武汉市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1600, '4142010512', '湖北大学', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1601, '4142010513', '湖北师范大学', '42', '湖北省', '4202', '黄石市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1602, '4142010514', '黄冈师范学院', '42', '湖北省', '4211', '黄冈市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1603, '4142010517', '湖北民族学院', '42', '湖北省', '4228', '恩施土家族苗族自治州', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1604, '4142010518', '汉江师范学院', '42', '湖北省', '4203', '十堰市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1605, '4142010519', '湖北文理学院', '42', '湖北省', '4206', '襄阳市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1606, '4142010520', '中南财经政法大学', '42', '湖北省', '4201', '武汉市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1607, '4142010522', '武汉体育学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1608, '4142010523', '湖北美术学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1609, '4142010524', '中南民族大学', '42', '湖北省', '4201', '武汉市', '本科', '国家民委', NULL);
INSERT INTO `school` VALUES (1610, '4142010525', '湖北汽车工业学院', '42', '湖北省', '4203', '十堰市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1611, '4142010528', '湖北工程学院', '42', '湖北省', '4209', '孝感市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1612, '4142010920', '湖北理工学院', '42', '湖北省', '4202', '黄石市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1613, '4142010927', '湖北科技学院', '42', '湖北省', '4212', '咸宁市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1614, '4142010929', '湖北医药学院', '42', '湖北省', '4203', '十堰市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1615, '4142011072', '江汉大学', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1616, '4142011075', '三峡大学', '42', '湖北省', '4205', '宜昌市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1617, '4142011332', '湖北警官学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1618, '4142011336', '荆楚理工学院', '42', '湖北省', '4208', '荆门市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1619, '4142011524', '武汉音乐学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1620, '4142011600', '湖北经济学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1621, '4142011654', '武汉商学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1622, '4142011798', '武汉东湖学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1623, '4142011800', '汉口学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1624, '4142012309', '武昌首义学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1625, '4142012310', '武昌理工学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1626, '4142012362', '武汉生物工程学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1627, '4142013188', '武汉晴川学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1628, '4142013234', '湖北大学知行学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1629, '4142013235', '武汉科技大学城市学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1630, '4142013236', '三峡大学科技学院', '42', '湖北省', '4205', '宜昌市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1631, '4142013237', '江汉大学文理学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1632, '4142013238', '湖北工业大学工程技术学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1633, '4142013239', '武汉工程大学邮电与信息工程\n学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1634, '4142013240', '武汉纺织大学外经贸学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1635, '4142013241', '武昌工学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1636, '4142013242', '武汉工商学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1637, '4142013245', '长江大学工程技术学院', '42', '湖北省', '4210', '荆州市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1638, '4142013246', '长江大学文理学院', '42', '湖北省', '4210', '荆州市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1639, '4142013247', '湖北商贸学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1640, '4142013248', '湖北汽车工业学院科技学院', '42', '湖北省', '4203', '十堰市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1641, '4142013249', '湖北医药学院药护学院', '42', '湖北省', '4203', '十堰市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1642, '4142013250', '湖北民族学院科技学院', '42', '湖北省', '4228', '恩施土家族苗族自治州', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1643, '4142013251', '湖北经济学院法商学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1644, '4142013253', '武汉体育学院体育科技学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1645, '4142013256', '湖北师范大学文理学院', '42', '湖北省', '4202', '黄石市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1646, '4142013257', '湖北文理学院理工学院', '42', '湖北省', '4206', '襄阳市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1647, '4142013258', '湖北工程学院新技术学院', '42', '湖北省', '4209', '孝感市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1648, '4142013262', '文华学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1649, '4142013634', '武汉学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1650, '4142013664', '武汉工程科技学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1651, '4142013666', '武汉华夏理工学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1652, '4142013686', '武汉传媒学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1653, '4142014035', '武汉设计工程学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1654, '4142014099', '湖北第二师范学院', '42', '湖北省', '4201', '武汉市', '本科', '湖北省', NULL);
INSERT INTO `school` VALUES (1655, '4142010834', '武汉职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1656, '4142010955', '黄冈职业技术学院', '42', '湖北省', '4211', '黄冈市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1657, '4142010956', '长江职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1658, '4142011074', '荆州理工职业学院', '42', '湖北省', '4210', '荆州市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1659, '4142011334', '湖北工业职业技术学院', '42', '湖北省', '4203', '十堰市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1660, '4142011335', '鄂州职业大学', '42', '湖北省', '4207', '鄂州市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1661, '4142011796', '武汉城市职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1662, '4142012051', '湖北职业技术学院', '42', '湖北省', '4209', '孝感市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1663, '4142012052', '武汉船舶职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1664, '4142012347', '恩施职业技术学院', '42', '湖北省', '4228', '恩施土家族苗族自治州', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1665, '4142012354', '襄阳职业技术学院', '42', '湖北省', '4206', '襄阳市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1666, '4142012369', '武汉工贸职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1667, '4142012737', '荆州职业技术学院', '42', '湖北省', '4210', '荆州市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1668, '4142012738', '武汉工程职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1669, '4142012740', '仙桃职业学院', '42', '湖北省', '429004', '仙桃市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1670, '4142012744', '湖北轻工职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1671, '4142012752', '湖北交通职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1672, '4142012951', '湖北中医药高等专科学校', '42', '湖北省', '4210', '荆州市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1673, '4142012952', '武汉航海职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1674, '4142012977', '武汉铁路职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1675, '4142012978', '武汉软件工程职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1676, '4142012979', '湖北三峡职业技术学院', '42', '湖北省', '4205', '宜昌市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1677, '4142012980', '随州职业技术学院', '42', '湖北省', '4213', '随州市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1678, '4142012981', '武汉电力职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1679, '4142012982', '湖北水利水电职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1680, '4142012983', '湖北城市建设职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1681, '4142012984', '武汉警官职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1682, '4142012985', '湖北生物科技职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1683, '4142012986', '湖北开放职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1684, '4142012987', '武汉科技职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1685, '4142012988', '武汉外语外事职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1686, '4142012989', '武汉信息传播职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1687, '4142012990', '武昌职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1688, '4142012991', '武汉商贸职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1689, '4142013263', '湖北艺术职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1690, '4142013264', '武汉交通职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1691, '4142013265', '咸宁职业技术学院', '42', '湖北省', '4212', '咸宁市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1692, '4142013266', '长江工程职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1693, '4142013793', '江汉艺术职业学院', '42', '湖北省', '429005', '潜江市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1694, '4142013795', '武汉工业职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1695, '4142013796', '武汉民政职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1696, '4142013797', '鄂东职业技术学院', '42', '湖北省', '4211', '黄冈市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1697, '4142013798', '湖北财税职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1698, '4142013799', '黄冈科技职业学院', '42', '湖北省', '4211', '黄冈市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1699, '4142013800', '湖北国土资源职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1700, '4142013801', '湖北生态工程职业技术学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1701, '4142014061', '三峡电力职业学院', '42', '湖北省', '4205', '宜昌市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1702, '4142014119', '湖北科技职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1703, '4142014120', '湖北青年职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1704, '4142014197', '湖北工程职业学院', '42', '湖北省', '4202', '黄石市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1705, '4142014258', '三峡旅游职业技术学院', '42', '湖北省', '4205', '宜昌市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1706, '4142014355', '天门职业学院', '42', '湖北省', '429006', '天门市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1707, '4142014356', '湖北体育职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1708, '4142014357', '襄阳汽车职业技术学院', '42', '湖北省', '4206', '襄阳市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1709, '4142014467', '湖北幼儿师范高等专科学校', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1710, '4142014553', '湖北铁道运输职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1711, '4142014554', '武汉海事职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1712, '4142014555', '长江艺术工程职业学院', '42', '湖北省', '4210', '荆州市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1713, '4142014571', '荆门职业学院', '42', '湖北省', '4208', '荆门市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1714, '4142014590', '武汉铁路桥梁职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省', NULL);
INSERT INTO `school` VALUES (1715, '4142014591', '武汉光谷职业学院', '42', '湖北省', '4201', '武汉市', '专科', '湖北省教育厅', '民办');
INSERT INTO `school` VALUES (1716, '4143010530', '湘潭大学', '43', '湖南省', '4303', '湘潭市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1717, '4143010531', '吉首大学', '43', '湖南省', '4331', '湘西土家族苗族自治州', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1718, '4143010532', '湖南大学', '43', '湖南省', '4301', '长沙市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1719, '4143010533', '中南大学', '43', '湖南省', '4301', '长沙市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1720, '4143010534', '湖南科技大学', '43', '湖南省', '4303', '湘潭市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1721, '4143010536', '长沙理工大学', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1722, '4143010537', '湖南农业大学', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1723, '4143010538', '中南林业科技大学', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1724, '4143010541', '湖南中医药大学', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1725, '4143010542', '湖南师范大学', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1726, '4143010543', '湖南理工学院', '43', '湖南省', '4306', '岳阳市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1727, '4143010545', '湘南学院', '43', '湖南省', '4310', '郴州市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1728, '4143010546', '衡阳师范学院', '43', '湖南省', '4304', '衡阳市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1729, '4143010547', '邵阳学院', '43', '湖南省', '4305', '邵阳市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1730, '4143010548', '怀化学院', '43', '湖南省', '4312', '怀化市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1731, '4143010549', '湖南文理学院', '43', '湖南省', '4307', '常德市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1732, '4143010551', '湖南科技学院', '43', '湖南省', '4311', '永州市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1733, '4143010553', '湖南人文科技学院', '43', '湖南省', '4313', '娄底市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1734, '4143010554', '湖南商学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1735, '4143010555', '南华大学', '43', '湖南省', '4304', '衡阳市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1736, '4143010823', '长沙医学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1737, '4143011077', '长沙学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1738, '4143011342', '湖南工程学院', '43', '湖南省', '4303', '湘潭市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1739, '4143011527', '湖南城市学院', '43', '湖南省', '4309', '益阳市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1740, '4143011528', '湖南工学院', '43', '湖南省', '4304', '衡阳市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1741, '4143011532', '湖南财政经济学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1742, '4143011534', '湖南警察学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1743, '4143011535', '湖南工业大学', '43', '湖南省', '4302', '株洲市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1744, '4143011538', '湖南女子学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1745, '4143012034', '湖南第一师范学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1746, '4143012214', '湖南医药学院', '43', '湖南省', '4312', '怀化市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1747, '4143012303', '湖南涉外经济学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1748, '4143012599', '湘潭大学兴湘学院', '43', '湖南省', '4303', '湘潭市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1749, '4143012604', '湖南工业大学科技学院', '43', '湖南省', '4302', '株洲市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1750, '4143012649', '湖南科技大学潇湘学院', '43', '湖南省', '4303', '湘潭市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1751, '4143012650', '南华大学船山学院', '43', '湖南省', '4304', '衡阳市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1752, '4143012651', '湖南商学院北津学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1753, '4143012652', '湖南师范大学树达学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1754, '4143012653', '湖南农业大学东方科技学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1755, '4143012656', '中南林业科技大学涉外学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1756, '4143012657', '湖南文理学院芙蓉学院', '43', '湖南省', '4307', '常德市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1757, '4143012658', '湖南理工学院南湖学院', '43', '湖南省', '4306', '岳阳市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1758, '4143012659', '衡阳师范学院南岳学院', '43', '湖南省', '4304', '衡阳市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1759, '4143012660', '湖南工程学院应用技术学院', '43', '湖南省', '4303', '湘潭市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1760, '4143012661', '湖南中医药大学湘杏学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1761, '4143012662', '吉首大学张家界学院', '43', '湖南省', '4308', '张家界市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1762, '4143013635', '长沙理工大学城南学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1763, '4143013806', '长沙师范学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省', NULL);
INSERT INTO `school` VALUES (1764, '4143013809', '湖南应用技术学院', '43', '湖南省', '4307', '常德市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1765, '4143013836', '湖南信息学院', '43', '湖南省', '4301', '长沙市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1766, '4143013924', '湖南交通工程学院', '43', '湖南省', '4304', '衡阳市', '本科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1767, '3643000496', '湘中幼儿师范高等专科学校', '43', '湖南省', '4305', '邵阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1768, '4143010827', '长沙民政职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1769, '4143010830', '湖南工业职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1770, '4143010836', '株洲师范高等专科学校', '43', '湖南省', '4302', '株洲市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1771, '4143010865', '湖南信息职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1772, '4143011601', '湖南税务高等专科学校', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1773, '4143011604', '湖南冶金职业技术学院', '43', '湖南省', '4302', '株洲市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1774, '4143012055', '长沙航空职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '空军装备部', NULL);
INSERT INTO `school` VALUES (1775, '4143012300', '湖南大众传媒职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1776, '4143012301', '永州职业技术学院', '43', '湖南省', '4311', '永州市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1777, '4143012302', '湖南铁道职业技术学院', '43', '湖南省', '4302', '株洲市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1778, '4143012304', '湖南科技职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1779, '4143012343', '湖南生物机电职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1780, '4143012397', '湖南交通职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1781, '4143012401', '湖南商务职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1782, '4143012423', '湖南体育职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1783, '4143012425', '湖南工程职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1784, '4143012596', '保险职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1785, '4143012597', '湖南外贸职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1786, '4143012598', '湖南网络工程职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1787, '4143012600', '邵阳职业技术学院', '43', '湖南省', '4305', '邵阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1788, '4143012601', '湖南司法警官职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1789, '4143012603', '长沙商贸旅游职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1790, '4143012739', '湖南环境生物职业技术学院', '43', '湖南省', '4304', '衡阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1791, '4143012845', '湖南邮电职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1792, '4143012846', '湘潭医卫职业技术学院', '43', '湖南省', '4303', '湘潭市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1793, '4143012847', '郴州职业技术学院', '43', '湖南省', '4310', '郴州市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1794, '4143012848', '娄底职业技术学院', '43', '湖南省', '4313', '娄底市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1795, '4143012849', '张家界航空工业职业技术学院', '43', '湖南省', '4308', '张家界市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1796, '4143013031', '长沙环境保护职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1797, '4143013032', '湖南艺术职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1798, '4143013033', '湖南机电职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1799, '4143013036', '长沙职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1800, '4143013037', '怀化职业技术学院', '43', '湖南省', '4312', '怀化市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1801, '4143013038', '岳阳职业技术学院', '43', '湖南省', '4306', '岳阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1802, '4143013039', '常德职业技术学院', '43', '湖南省', '4307', '常德市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1803, '4143013041', '长沙南方职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1804, '4143013042', '潇湘职业学院', '43', '湖南省', '4313', '娄底市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1805, '4143013043', '湖南化工职业技术学院', '43', '湖南省', '4302', '株洲市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1806, '4143013044', '湖南城建职业技术学院', '43', '湖南省', '4303', '湘潭市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1807, '4143013045', '湖南石油化工职业技术学院', '43', '湖南省', '4306', '岳阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1808, '4143013802', '湖南中医药高等专科学校', '43', '湖南省', '4302', '株洲市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1809, '4143013804', '湖南民族职业学院', '43', '湖南省', '4306', '岳阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1810, '4143013805', '湘西民族职业技术学院', '43', '湖南省', '4331', '湘西土家族苗族自治州', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1811, '4143013807', '湖南财经工业职业技术学院', '43', '湖南省', '4304', '衡阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1812, '4143013808', '益阳职业技术学院', '43', '湖南省', '4309', '益阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1813, '4143013921', '湖南工艺美术职业学院', '43', '湖南省', '4309', '益阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1814, '4143013922', '湖南九嶷职业技术学院', '43', '湖南省', '4311', '永州市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1815, '4143013923', '湖南理工职业技术学院', '43', '湖南省', '4303', '湘潭市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1816, '4143013925', '湖南软件职业学院', '43', '湖南省', '4303', '湘潭市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1817, '4143013937', '湖南汽车工程职业学院', '43', '湖南省', '4302', '株洲市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1818, '4143013938', '长沙电力职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1819, '4143013939', '湖南水利水电职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1820, '4143013940', '湖南现代物流职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1821, '4143013941', '湖南高速铁路职业技术学院', '43', '湖南省', '4304', '衡阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1822, '4143013942', '湖南铁路科技职业技术学院', '43', '湖南省', '4302', '株洲市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1823, '4143014025', '湖南安全技术职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1824, '4143014071', '湖南电气职业技术学院', '43', '湖南省', '4303', '湘潭市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1825, '4143014072', '湖南外国语职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1826, '4143014097', '益阳医学高等专科学校', '43', '湖南省', '4309', '益阳市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1827, '4143014121', '湖南都市职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1828, '4143014122', '湖南电子科技职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1829, '4143014182', '湖南国防工业职业技术学院', '43', '湖南省', '4303', '湘潭市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1830, '4143014309', '湖南高尔夫旅游职业学院', '43', '湖南省', '4307', '常德市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1831, '4143014310', '湖南工商职业学院', '43', '湖南省', '4304', '衡阳市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1832, '4143014322', '湖南三一工业职业技术学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1833, '4143014358', '长沙卫生职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1834, '4143014359', '湖南食品药品职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1835, '4143014360', '湖南有色金属职业技术学院', '43', '湖南省', '4302', '株洲市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1836, '4143014406', '湖南吉利汽车职业技术学院', '43', '湖南省', '4303', '湘潭市', '专科', '湖南省教育厅', '民办');
INSERT INTO `school` VALUES (1837, '4143014468', '湖南幼儿师范高等专科学校', '43', '湖南省', '4307', '常德市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1838, '4143014495', '湘南幼儿师范高等专科学校', '43', '湖南省', '4310', '郴州市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1839, '4143014508', '湖南劳动人事职业学院', '43', '湖南省', '4301', '长沙市', '专科', '湖南省', NULL);
INSERT INTO `school` VALUES (1840, '4144010558', '中山大学', '44', '广东省', '4401', '广州市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1841, '4144010559', '暨南大学', '44', '广东省', '4401', '广州市', '本科', '国务院侨办', NULL);
INSERT INTO `school` VALUES (1842, '4144010560', '汕头大学', '44', '广东省', '4405', '汕头市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1843, '4144010561', '华南理工大学', '44', '广东省', '4401', '广州市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (1844, '4144010564', '华南农业大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1845, '4144010566', '广东海洋大学', '44', '广东省', '4408', '湛江市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1846, '4144010570', '广州医科大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1847, '4144010571', '广东医科大学', '44', '广东省', '4408', '湛江市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1848, '4144010572', '广州中医药大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1849, '4144010573', '广东药科大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1850, '4144010574', '华南师范大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1851, '4144010576', '韶关学院', '44', '广东省', '4402', '韶关市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1852, '4144010577', '惠州学院', '44', '广东省', '4413', '惠州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1853, '4144010578', '韩山师范学院', '44', '广东省', '4451', '潮州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1854, '4144010579', '岭南师范学院', '44', '广东省', '4408', '湛江市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1855, '4144010580', '肇庆学院', '44', '广东省', '4412', '肇庆市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1856, '4144010582', '嘉应学院', '44', '广东省', '4414', '梅州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1857, '4144010585', '广州体育学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1858, '4144010586', '广州美术学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1859, '4144010587', '星海音乐学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1860, '4144010588', '广东技术师范学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1861, '4144010590', '深圳大学', '44', '广东省', '4403', '深圳市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1862, '4144010592', '广东财经大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1863, '4144010822', '广东白云学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1864, '4144011078', '广州大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1865, '4144011106', '广州航海学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1866, '4144011110', '广东警官学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1867, '4144011347', '仲恺农业工程学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1868, '4144011349', '五邑大学', '44', '广东省', '4407', '江门市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1869, '4144011540', '广东金融学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1870, '4144011545', '电子科技大学中山学院', '44', '广东省', '4420', '中山市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1871, '4144011656', '广东石油化工学院', '44', '广东省', '4409', '茂名市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1872, '4144011819', '东莞理工学院', '44', '广东省', '4419', '东莞市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1873, '4144011845', '广东工业大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1874, '4144011846', '广东外语外贸大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1875, '4144011847', '佛山科学技术学院', '44', '广东省', '4406', '佛山市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1876, '4144012059', '广东培正学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1877, '4144012121', '南方医科大学', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1878, '4144012574', '广东东软学院', '44', '广东省', '4406', '佛山市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1879, '4144012617', '华南理工大学广州学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1880, '4144012618', '广州大学华软软件学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1881, '4144012619', '中山大学南方学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1882, '4144012620', '广东外语外贸大学南国商学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1883, '4144012621', '广东财经大学华商学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1884, '4144012622', '广东海洋大学寸金学院', '44', '广东省', '4408', '湛江市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1885, '4144012623', '华南农业大学珠江学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1886, '4144012668', '广东技术师范学院天河学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1887, '4144013177', '北京师范大学珠海分校', '44', '广东省', '4404', '珠海市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1888, '4144013656', '广东工业大学华立学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1889, '4144013657', '广州大学松田学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1890, '4144013667', '广州商学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1891, '4144013675', '北京理工大学珠海学院', '44', '广东省', '4404', '珠海市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1892, '4144013684', '吉林大学珠海学院', '44', '广东省', '4404', '珠海市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1893, '4144013714', '广州工商学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1894, '4144013719', '广东科技学院', '44', '广东省', '4419', '东莞市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1895, '4144013720', '广东理工学院', '44', '广东省', '4412', '肇庆市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1896, '4144013844', '东莞理工学院城市学院', '44', '广东省', '4419', '东莞市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1897, '4144013902', '中山大学新华学院', '44', '广东省', '4401', '广州市', '本科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1898, '4144014278', '广东第二师范学院', '44', '广东省', '4401', '广州市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1899, '4144014325', '南方科技大学', '44', '广东省', '4403', '深圳市', '本科', '广东省', NULL);
INSERT INTO `school` VALUES (1900, '4144016401', '北京师范大学-香港浸会大学联合国际学院', '44', '广东省', '4404', '珠海市', '本科', '广东省教育厅', '内地与港澳台地区合作办学');
INSERT INTO `school` VALUES (1901, '4144016407', '香港中文大学（深圳）', '44', '广东省', '4403', '深圳市', '本科', '广东省教育厅', '内地与港澳台地区合作办学');
INSERT INTO `school` VALUES (1902, '4144016409', '深圳北理莫斯科大学', '44', '广东省', '4403', '深圳市', '本科', '广东省教育厅', '中外合作办学');
INSERT INTO `school` VALUES (1903, '4144016410', '广东以色列理工学院', '44', '广东省', '4405', '汕头市', '本科', '广东省教育厅', '中外合作办学');
INSERT INTO `school` VALUES (1904, '4144010831', '顺德职业技术学院', '44', '广东省', '4406', '佛山市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1905, '4144010833', '广东轻工职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1906, '4144010861', '广东交通职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1907, '4144010862', '广东水利电力职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1908, '4144010965', '潮汕职业技术学院', '44', '广东省', '4452', '揭阳市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1909, '4144011113', '深圳职业技术学院', '44', '广东省', '4403', '深圳市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1910, '4144011114', '广东南华工商职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1911, '4144011121', '私立华联学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1912, '4144012040', '广州民航职业技术学院', '44', '广东省', '4401', '广州市', '专科', '交通运输部', NULL);
INSERT INTO `school` VALUES (1913, '4144012046', '广州番禺职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1914, '4144012060', '广东松山职业技术学院', '44', '广东省', '4402', '韶关市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1915, '4144012322', '广东农工商职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1916, '4144012325', '广东新安职业技术学院', '44', '广东省', '4403', '深圳市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1917, '4144012327', '佛山职业技术学院', '44', '广东省', '4406', '佛山市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1918, '4144012572', '广东科学技术职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1919, '4144012573', '广东食品药品职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1920, '4144012575', '广州康大职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1921, '4144012576', '珠海艺术职业学院', '44', '广东省', '4404', '珠海市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1922, '4144012577', '广东行政职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1923, '4144012578', '广东体育职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1924, '4144012736', '广东职业技术学院', '44', '广东省', '4406', '佛山市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1925, '4144012741', '广东建设职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1926, '4144012742', '广东女子职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1927, '4144012743', '广东机电职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1928, '4144012749', '广东岭南职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1929, '4144012765', '汕尾职业技术学院', '44', '广东省', '4415', '汕尾市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1930, '4144012770', '罗定职业技术学院', '44', '广东省', '4453', '云浮市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1931, '4144012771', '阳江职业技术学院', '44', '广东省', '4417', '阳江市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1932, '4144012772', '河源职业技术学院', '44', '广东省', '4416', '河源市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1933, '4144012953', '广东邮电职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1934, '4144012954', '汕头职业技术学院', '44', '广东省', '4405', '汕头市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1935, '4144012956', '揭阳职业技术学院', '44', '广东省', '4452', '揭阳市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1936, '4144012957', '深圳信息职业技术学院', '44', '广东省', '4403', '深圳市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1937, '4144012958', '清远职业技术学院', '44', '广东省', '4418', '清远市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1938, '4144012959', '广东工贸职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1939, '4144012960', '广东司法警官职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1940, '4144012961', '广东亚视演艺职业学院', '44', '广东省', '4419', '东莞市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1941, '4144012962', '广东省外语艺术职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1942, '4144013707', '广东文艺职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1943, '4144013708', '广州体育职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1944, '4144013709', '广州工程技术职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1945, '4144013710', '中山火炬职业技术学院', '44', '广东省', '4420', '中山市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1946, '4144013711', '江门职业技术学院', '44', '广东省', '4407', '江门市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1947, '4144013712', '茂名职业技术学院', '44', '广东省', '4409', '茂名市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1948, '4144013713', '珠海城市职业技术学院', '44', '广东省', '4404', '珠海市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1949, '4144013715', '广州涉外经济职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1950, '4144013716', '广州南洋理工职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1951, '4144013717', '广州科技职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1952, '4144013718', '惠州经济职业技术学院', '44', '广东省', '4413', '惠州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1953, '4144013721', '广东工商职业学院', '44', '广东省', '4412', '肇庆市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1954, '4144013810', '肇庆医学高等专科学校', '44', '广东省', '4412', '肇庆市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1955, '4144013912', '广州现代信息工程职业技术\n学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1956, '4144013919', '广东理工职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1957, '4144013927', '广州华南商贸职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1958, '4144013928', '广州华立科技职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1959, '4144013929', '广州城市职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1960, '4144013930', '广东工程职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1961, '4144013943', '广州铁路职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1962, '4144014063', '广东科贸职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1963, '4144014065', '广州科技贸易职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1964, '4144014066', '中山职业技术学院', '44', '广东省', '4420', '中山市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1965, '4144014123', '广州珠江职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1966, '4144014125', '广州松田职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1967, '4144014126', '广东文理职业学院', '44', '广东省', '4408', '湛江市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1968, '4144014136', '广州城建职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1969, '4144014263', '东莞职业技术学院', '44', '广东省', '4419', '东莞市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1970, '4144014265', '广东南方职业学院', '44', '广东省', '4407', '江门市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1971, '4144014266', '广州华商职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1972, '4144014268', '广州华夏职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1973, '4144014311', '广东环境保护工程职业学院', '44', '广东省', '4406', '佛山市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1974, '4144014361', '广东青年职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1975, '4144014362', '广州东华职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1976, '4144014363', '广东创新科技职业学院', '44', '广东省', '4419', '东莞市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1977, '4144014407', '广东舞蹈戏剧职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1978, '4144014408', '惠州卫生职业技术学院', '44', '广东省', '4413', '惠州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1979, '4144014427', '广东信息工程职业学院', '44', '广东省', '4412', '肇庆市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1980, '4144014509', '广东生态工程职业学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1981, '4144014510', '惠州城市职业学院', '44', '广东省', '4413', '惠州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1982, '4144014511', '广东碧桂园职业学院', '44', '广东省', '4418', '清远市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1983, '4144014533', '公安边防部队高等专科学校', '44', '广东省', '4401', '广州市', '专科', '公安部', NULL);
INSERT INTO `school` VALUES (1984, '4144014556', '广东茂名健康职业学院', '44', '广东省', '4409', '茂名市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1985, '4144014572', '广东酒店管理职业技术学院', '44', '广东省', '4419', '东莞市', '专科', '广东省教育厅', '民办');
INSERT INTO `school` VALUES (1986, '4144014587', '广东茂名幼儿师范专科学校', '44', '广东省', '4409', '茂名市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1987, '4144014592', '广州卫生职业技术学院', '44', '广东省', '4401', '广州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1988, '4144014609', '惠州工程职业学院', '44', '广东省', '4413', '惠州市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1989, '4144014610', '广东江门中医药职业学院', '44', '广东省', '4407', '江门市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1990, '4244050853', '湛江幼儿师范专科学校', '44', '广东省', '4408', '湛江市', '专科', '广东省', NULL);
INSERT INTO `school` VALUES (1991, '4145010593', '广西大学', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (1992, '4145010594', '广西科技大学', '45', '广西壮族自治区', '4502', '柳州市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (1993, '4145010595', '桂林电子科技大学', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (1994, '4145010596', '桂林理工大学', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (1995, '4145010598', '广西医科大学', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (1996, '4145010599', '右江民族医学院', '45', '广西壮族自治区', '4510', '百色市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (1997, '4145010600', '广西中医药大学', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (1998, '4145010601', '桂林医学院', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (1999, '4145010602', '广西师范大学', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2000, '4145010603', '广西师范学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2001, '4145010604', '广西民族师范学院', '45', '广西壮族自治区', '4514', '崇左市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2002, '4145010605', '河池学院', '45', '广西壮族自治区', '4512', '河池市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2003, '4145010606', '玉林师范学院', '45', '广西壮族自治区', '4509', '玉林市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2004, '4145010607', '广西艺术学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2005, '4145010608', '广西民族大学', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2006, '4145010609', '百色学院', '45', '广西壮族自治区', '4510', '百色市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2007, '4145011354', '梧州学院', '45', '广西壮族自治区', '4504', '梧州市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2008, '4145011546', '广西科技师范学院', '45', '广西壮族自治区', '4513', '来宾市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2009, '4145011548', '广西财经学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2010, '4145011549', '南宁学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2011, '4145011607', '钦州学院', '45', '广西壮族自治区', '4507', '钦州市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2012, '4145011825', '桂林航天工业学院', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2013, '4145011837', '桂林旅游学院', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2014, '4145011838', '贺州学院', '45', '广西壮族自治区', '4511', '贺州市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2015, '4145013520', '广西警察学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2016, '4145013524', '北海艺术设计学院', '45', '广西壮族自治区', '4505', '北海市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2017, '4145013638', '广西大学行健文理学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2018, '4145013639', '广西科技大学鹿山学院', '45', '广西壮族自治区', '4502', '柳州市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2019, '4145013640', '广西民族大学相思湖学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2020, '4145013641', '广西师范大学漓江学院', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2021, '4145013642', '广西师范学院师园学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2022, '4145013643', '广西中医药大学赛恩斯新医药\n学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2023, '4145013644', '桂林电子科技大学信息科技\n学院', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2024, '4145013645', '桂林理工大学博文管理学院', '45', '广西壮族自治区', '4503', '桂林市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2025, '4145013830', '广西外国语学院', '45', '广西壮族自治区', '4501', '南宁市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2026, '4145013890', '北京航空航天大学北海学院', '45', '广西壮族自治区', '4505', '北海市', '本科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2027, '4145010867', '广西机电职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2028, '4145011350', '广西体育高等专科学校', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2029, '4145011355', '南宁职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2030, '4145011608', '广西水利电力职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2031, '4145011671', '桂林师范高等专科学校', '45', '广西壮族自治区', '4503', '桂林市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2032, '4145011773', '广西职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2033, '4145012104', '柳州职业技术学院', '45', '广西壮族自治区', '4502', '柳州市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2034, '4145012344', '广西生态工程职业技术学院', '45', '广西壮族自治区', '4502', '柳州市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2035, '4145012356', '广西交通职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2036, '4145012364', '广西工业职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2037, '4145012379', '广西国际商务职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2038, '4145012382', '广西农业职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2039, '4145012392', '柳州铁道职业技术学院', '45', '广西壮族自治区', '4502', '柳州市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2040, '4145013138', '广西建设职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2041, '4145013522', '广西现代职业技术学院', '45', '广西壮族自治区', '4512', '河池市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2042, '4145013523', '北海职业学院', '45', '广西壮族自治区', '4505', '北海市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2043, '4145013526', '桂林山水职业学院', '45', '广西壮族自治区', '4503', '桂林市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2044, '4145013827', '广西经贸职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2045, '4145013828', '广西工商职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2046, '4145013829', '广西演艺职业学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2047, '4145013831', '广西电力职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2048, '4145013920', '广西城市职业学院', '45', '广西壮族自治区', '4514', '崇左市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2049, '4145014026', '广西英华国际职业学院', '45', '广西壮族自治区', '4507', '钦州市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2050, '4145014067', '柳州城市职业学院', '45', '广西壮族自治区', '4502', '柳州市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2051, '4145014068', '百色职业学院', '45', '广西壮族自治区', '4510', '百色市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2052, '4145014127', '广西工程职业学院', '45', '广西壮族自治区', '4510', '百色市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2053, '4145014170', '广西理工职业技术学院', '45', '广西壮族自治区', '4514', '崇左市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2054, '4145014171', '梧州职业学院', '45', '广西壮族自治区', '4504', '梧州市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2055, '4145014211', '广西经济职业学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2056, '4145014220', '广西幼儿师范高等专科学校', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2057, '4145014312', '广西科技职业学院', '45', '广西壮族自治区', '4514', '崇左市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2058, '4145014313', '广西卫生职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2059, '4145014481', '广西培贤国际职业学院', '45', '广西壮族自治区', '4510', '百色市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2060, '4145014512', '广西金融职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2061, '4145014546', '广西中远职业学院', '45', '广西壮族自治区', '4514', '崇左市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2062, '4145014573', '玉柴职业技术学院', '45', '广西壮族自治区', '4509', '玉林市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2063, '4145014574', '广西蓝天航空职业学院', '45', '广西壮族自治区', '4513', '来宾市', '专科', '广西自治区教育厅', '民办');
INSERT INTO `school` VALUES (2064, '4145014611', '广西安全工程职业技术学院', '45', '广西壮族自治区', '4501', '南宁市', '专科', '广西壮族自治区', NULL);
INSERT INTO `school` VALUES (2065, '4146010589', '海南大学', '46', '海南省', '4601', '海口市', '本科', '海南省', NULL);
INSERT INTO `school` VALUES (2066, '4146011100', '海南热带海洋学院', '46', '海南省', '4602', '三亚市', '本科', '海南省', NULL);
INSERT INTO `school` VALUES (2067, '4146011658', '海南师范大学', '46', '海南省', '4601', '海口市', '本科', '海南省', NULL);
INSERT INTO `school` VALUES (2068, '4146011810', '海南医学院', '46', '海南省', '4601', '海口市', '本科', '海南省', NULL);
INSERT INTO `school` VALUES (2069, '4146012308', '海口经济学院', '46', '海南省', '4601', '海口市', '本科', '海南省教育厅', '民办');
INSERT INTO `school` VALUES (2070, '4146013811', '琼台师范学院', '46', '海南省', '4601', '海口市', '本科', '海南省', NULL);
INSERT INTO `school` VALUES (2071, '4146013892', '三亚学院', '46', '海南省', '4602', '三亚市', '本科', '海南省教育厅', '民办');
INSERT INTO `school` VALUES (2072, '4146011999', '海南职业技术学院', '46', '海南省', '4601', '海口市', '专科', '海南省', NULL);
INSERT INTO `school` VALUES (2073, '4146012717', '三亚城市职业学院', '46', '海南省', '4602', '三亚市', '专科', '海南省教育厅', '民办');
INSERT INTO `school` VALUES (2074, '4146013575', '海南软件职业技术学院', '46', '海南省', '469002', '琼海市', '专科', '海南省', NULL);
INSERT INTO `school` VALUES (2075, '4146013576', '海南政法职业学院', '46', '海南省', '4601', '海口市', '专科', '海南省', NULL);
INSERT INTO `school` VALUES (2076, '4146013577', '海南外国语职业学院', '46', '海南省', '469005', '文昌市', '专科', '海南省', NULL);
INSERT INTO `school` VALUES (2077, '4146013875', '海南经贸职业技术学院', '46', '海南省', '4601', '海口市', '专科', '海南省', NULL);
INSERT INTO `school` VALUES (2078, '4146013876', '海南工商职业学院', '46', '海南省', '4601', '海口市', '专科', '海南省教育厅', '民办');
INSERT INTO `school` VALUES (2079, '4146013931', '三亚航空旅游职业学院', '46', '海南省', '4602', '三亚市', '专科', '海南省教育厅', '民办');
INSERT INTO `school` VALUES (2080, '4146014172', '海南科技职业学院', '46', '海南省', '4601', '海口市', '专科', '海南省教育厅', '民办');
INSERT INTO `school` VALUES (2081, '4146014236', '三亚理工职业学院', '46', '海南省', '4602', '三亚市', '专科', '海南省教育厅', '民办');
INSERT INTO `school` VALUES (2082, '4146014575', '海南体育职业技术学院', '46', '海南省', '4601', '海口市', '专科', '海南省', NULL);
INSERT INTO `school` VALUES (2083, '4146014612', '三亚中瑞酒店管理职业学院', '46', '海南省', '4602', '三亚市', '专科', '海南省教育厅', '民办');
INSERT INTO `school` VALUES (2084, '4150010611', '重庆大学', '50', '重庆市', '5001', '重庆市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2085, '4150010617', '重庆邮电大学', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2086, '4150010618', '重庆交通大学', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2087, '4150010631', '重庆医科大学', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2088, '4150010635', '西南大学', '50', '重庆市', '5001', '重庆市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2089, '4150010637', '重庆师范大学', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2090, '4150010642', '重庆文理学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2091, '4150010643', '重庆三峡学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2092, '4150010647', '长江师范学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2093, '4150010650', '四川外国语大学', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2094, '4150010652', '西南政法大学', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2095, '4150010655', '四川美术学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2096, '4150011551', '重庆科技学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2097, '4150011660', '重庆理工大学', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2098, '4150011799', '重庆工商大学', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2099, '4150012608', '重庆工程学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2100, '4150012616', '重庆大学城市科技学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2101, '4150012757', '重庆警察学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2102, '4150013548', '重庆人文科技学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2103, '4150013588', '四川外国语大学重庆南方翻译\n学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2104, '4150013589', '重庆师范大学涉外商贸学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2105, '4150013590', '重庆工商大学融智学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2106, '4150013591', '重庆工商大学派斯学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2107, '4150013627', '重庆邮电大学移通学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2108, '4150014388', '重庆第二师范学院', '50', '重庆市', '5001', '重庆市', '本科', '重庆市', NULL);
INSERT INTO `school` VALUES (2109, '4150010870', '重庆航天职业技术学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2110, '4150011848', '重庆电力高等专科学校', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2111, '4150012215', '重庆工业职业技术学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2112, '4150012605', '重庆三峡职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2113, '4150012606', '重庆工贸职业技术学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2114, '4150012607', '重庆机电职业技术学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2115, '4150012609', '重庆电子工程职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2116, '4150012754', '重庆海联职业技术学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2117, '4150012755', '重庆信息技术职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2118, '4150012756', '重庆传媒职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2119, '4150012758', '重庆城市管理职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2120, '4150012759', '重庆工程职业技术学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2121, '4150012820', '重庆房地产职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2122, '4150013734', '重庆城市职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2123, '4150013735', '重庆水利电力职业技术学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2124, '4150013967', '重庆工商职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2125, '4150013968', '重庆应用技术职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2126, '4150014008', '重庆三峡医药高等专科学校', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2127, '4150014009', '重庆医药高等专科学校', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2128, '4150014069', '重庆青年职业技术学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2129, '4150014128', '重庆财经职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2130, '4150014173', '重庆科创职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2131, '4150014183', '重庆建筑工程职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2132, '4150014237', '重庆电讯职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2133, '4150014238', '重庆能源职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2134, '4150014246', '重庆商务职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2135, '4150014267', '重庆交通职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2136, '4150014315', '重庆化工职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2137, '4150014316', '重庆旅游职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2138, '4150014365', '重庆安全技术职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2139, '4150014366', '重庆公共运输职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2140, '4150014367', '重庆艺术工程职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2141, '4150014368', '重庆轻工职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2142, '4150014369', '重庆电信职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2143, '4150014370', '重庆经贸职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2144, '4150014428', '重庆幼儿师范高等专科学校', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2145, '4150014482', '重庆文化艺术职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市', NULL);
INSERT INTO `school` VALUES (2146, '4150014491', '重庆科技职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2147, '4150014557', '重庆资源与环境保护职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2148, '4150014576', '重庆护理职业学院', '50', '重庆市', '5001', '重庆市', '专科', '重庆市教委', '民办');
INSERT INTO `school` VALUES (2149, '4151010610', '四川大学', '51', '四川省', '5101', '成都市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2150, '4151010613', '西南交通大学', '51', '四川省', '5101', '成都市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2151, '4151010614', '电子科技大学', '51', '四川省', '5101', '成都市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2152, '4151010615', '西南石油大学', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2153, '4151010616', '成都理工大学', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2154, '4151010619', '西南科技大学', '51', '四川省', '5107', '绵阳市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2155, '4151010621', '成都信息工程大学', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2156, '4151010622', '四川理工学院', '51', '四川省', '5103', '自贡市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2157, '4151010623', '西华大学', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2158, '4151010624', '中国民用航空飞行学院', '51', '四川省', '5106', '德阳市', '本科', '交通运输部', NULL);
INSERT INTO `school` VALUES (2159, '4151010626', '四川农业大学', '51', '四川省', '5118', '雅安市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2160, '4151010628', '西昌学院', '51', '四川省', '5134', '凉山彝族\n自治州', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2161, '4151010632', '西南医科大学', '51', '四川省', '5105', '泸州市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2162, '4151010633', '成都中医药大学', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2163, '4151010634', '川北医学院', '51', '四川省', '5113', '南充市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2164, '4151010636', '四川师范大学', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2165, '4151010638', '西华师范大学', '51', '四川省', '5113', '南充市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2166, '4151010639', '绵阳师范学院', '51', '四川省', '5107', '绵阳市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2167, '4151010640', '内江师范学院', '51', '四川省', '5110', '内江市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2168, '4151010641', '宜宾学院', '51', '四川省', '5115', '宜宾市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2169, '4151010644', '四川文理学院', '51', '四川省', '5117', '达州市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2170, '4151010646', '阿坝师范学院', '51', '四川省', '5132', '阿坝藏族羌族自治州', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2171, '4151010649', '乐山师范学院', '51', '四川省', '5111', '乐山市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2172, '4151010651', '西南财经大学', '51', '四川省', '5101', '成都市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2173, '4151010653', '成都体育学院', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2174, '4151010654', '四川音乐学院', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2175, '4151010656', '西南民族大学', '51', '四川省', '5101', '成都市', '本科', '国家民委', NULL);
INSERT INTO `school` VALUES (2176, '4151011079', '成都学院', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2177, '4151011116', '成都工业学院', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2178, '4151011360', '攀枝花学院', '51', '四川省', '5104', '攀枝花市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2179, '4151011552', '四川旅游学院', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2180, '4151011661', '四川民族学院', '51', '四川省', '5133', '甘孜藏族\n自治州', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2181, '4151012212', '四川警察学院', '51', '四川省', '5105', '泸州市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2182, '4151012636', '成都东软学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2183, '4151013665', '电子科技大学成都学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2184, '4151013668', '成都理工大学工程技术学院', '51', '四川省', '5111', '乐山市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2185, '4151013669', '四川传媒学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2186, '4151013670', '成都信息工程大学银杏酒店管理学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2187, '4151013671', '成都文理学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2188, '4151013672', '四川工商学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2189, '4151013673', '四川外国语大学成都学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2190, '4151013705', '成都医学院', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2191, '4151013816', '四川工业科技学院', '51', '四川省', '5106', '德阳市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2192, '4151013903', '四川大学锦城学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2193, '4151014037', '西南财经大学天府学院', '51', '四川省', '5107', '绵阳市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2194, '4151014039', '四川大学锦江学院', '51', '四川省', '5114', '眉山市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2195, '4151014043', '四川文化艺术学院', '51', '四川省', '5107', '绵阳市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2196, '4151014045', '西南科技大学城市学院', '51', '四川省', '5107', '绵阳市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2197, '4151014262', '西南交通大学希望学院', '51', '四川省', '5113', '南充市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2198, '4151014389', '成都师范学院', '51', '四川省', '5101', '成都市', '本科', '四川省', NULL);
INSERT INTO `school` VALUES (2199, '4151014410', '四川电影电视学院', '51', '四川省', '5101', '成都市', '本科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2200, '4151011553', '成都纺织高等专科学校', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2201, '4151011841', '民办四川天一学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2202, '4151012064', '成都航空职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2203, '4151012065', '四川电力职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2204, '4151012635', '成都职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2205, '4151012637', '四川化工职业技术学院', '51', '四川省', '5105', '泸州市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2206, '4151012638', '四川水利职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2207, '4151012639', '南充职业技术学院', '51', '四川省', '5113', '南充市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2208, '4151012640', '内江职业技术学院', '51', '四川省', '5110', '内江市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2209, '4151012641', '四川航天职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2210, '4151012642', '四川邮电职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2211, '4151012751', '四川机电职业技术学院', '51', '四川省', '5104', '攀枝花市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2212, '4151012753', '绵阳职业技术学院', '51', '四川省', '5107', '绵阳市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2213, '4151012761', '四川交通职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2214, '4151012762', '四川工商职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2215, '4151012763', '四川工程职业技术学院', '51', '四川省', '5106', '德阳市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2216, '4151012764', '四川建筑职业技术学院', '51', '四川省', '5106', '德阳市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2217, '4151012767', '达州职业技术学院', '51', '四川省', '5117', '达州市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2218, '4151012963', '四川托普信息技术职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2219, '4151012964', '四川国际标榜职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2220, '4151012965', '成都农业科技职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2221, '4151012966', '宜宾职业技术学院', '51', '四川省', '5115', '宜宾市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2222, '4151012967', '泸州职业技术学院', '51', '四川省', '5105', '泸州市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2223, '4151012968', '眉山职业技术学院', '51', '四川省', '5114', '眉山市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2224, '4151012969', '成都艺术职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2225, '4151012970', '四川职业技术学院', '51', '四川省', '5109', '遂宁市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2226, '4151013048', '乐山职业技术学院', '51', '四川省', '5111', '乐山市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2227, '4151013049', '雅安职业技术学院', '51', '四川省', '5118', '雅安市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2228, '4151013812', '四川商务职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2229, '4151013813', '四川司法警官职业学院', '51', '四川省', '5106', '德阳市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2230, '4151013814', '广安职业技术学院', '51', '四川省', '5116', '广安市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2231, '4151013815', '四川信息职业技术学院', '51', '四川省', '5108', '广元市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2232, '4151014004', '四川文化传媒职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2233, '4151014005', '四川华新现代职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2234, '4151014006', '四川管理职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2235, '4151014007', '四川艺术职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2236, '4151014010', '四川中医药高等专科学校', '51', '四川省', '5107', '绵阳市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2237, '4151014070', '四川科技职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2238, '4151014086', '四川文化产业职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2239, '4151014091', '四川财经职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2240, '4151014175', '四川城市职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2241, '4151014176', '四川现代职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2242, '4151014221', '四川幼儿师范高等专科学校', '51', '四川省', '5107', '绵阳市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2243, '4151014323', '四川长江职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2244, '4151014386', '四川三河职业学院', '51', '四川省', '5105', '泸州市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2245, '4151014393', '川北幼儿师范高等专科学校', '51', '四川省', '5108', '广元市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2246, '4151014409', '四川卫生康复职业学院', '51', '四川省', '5103', '自贡市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2247, '4151014411', '四川汽车职业技术学院', '51', '四川省', '5107', '绵阳市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2248, '4151014483', '巴中职业技术学院', '51', '四川省', '5119', '巴中市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2249, '4151014484', '四川希望汽车职业学院', '51', '四川省', '5120', '资阳市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2250, '4151014485', '四川电子机械职业技术学院', '51', '四川省', '5107', '绵阳市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2251, '4151014486', '四川文轩职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2252, '4151014496', '川南幼儿师范高等专科学校', '51', '四川省', '5110', '内江市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2253, '4151014513', '四川护理职业学院', '51', '四川省', '5106', '德阳市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2254, '4151014514', '成都工业职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2255, '4151014515', '四川西南航空职业学院', '51', '四川省', '5101', '成都市', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2256, '4151014547', '成都工贸职业技术学院', '51', '四川省', '5101', '成都市', '专科', '四川省', NULL);
INSERT INTO `school` VALUES (2257, '4151014548', '四川应用技术职业学院', '51', '四川省', '5134', '	凉山彝族自治州', '专科', '四川省教育厅', '民办');
INSERT INTO `school` VALUES (2258, '4152010657', '贵州大学', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2259, '4152010660', '贵州医科大学', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2260, '4152010661', '遵义医学院', '52', '贵州省', '5203', '遵义市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2261, '4152010662', '贵阳中医学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2262, '4152010663', '贵州师范大学', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2263, '4152010664', '遵义师范学院', '52', '贵州省', '5203', '遵义市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2264, '4152010665', '铜仁学院', '52', '贵州省', '5206', '铜仁市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2265, '4152010666', '兴义民族师范学院', '52', '贵州省', '5223', '黔西南布依族苗族自治州', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2266, '4152010667', '安顺学院', '52', '贵州省', '5204', '安顺市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2267, '4152010668', '贵州工程应用技术学院', '52', '贵州省', '5205', '毕节市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2268, '4152010669', '凯里学院', '52', '贵州省', '5226', '黔东南苗族侗族自治州', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2269, '4152010670', '黔南民族师范学院', '52', '贵州省', '5227', '黔南布依族苗族自治州', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2270, '4152010671', '贵州财经大学', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2271, '4152010672', '贵州民族大学', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2272, '4152010976', '贵阳学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2273, '4152010977', '六盘水师范学院', '52', '贵州省', '5202', '六盘水市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2274, '4152011731', '贵州商学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2275, '4152012107', '贵州警察学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2276, '4152013647', '贵阳中医学院时珍学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2277, '4152013648', '贵州财经大学商务学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2278, '4152013649', '贵州大学科技学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2279, '4152013650', '贵州大学明德学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2280, '4152013651', '贵州民族大学人文科技学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2281, '4152013652', '贵州师范大学求是学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2282, '4152013653', '遵义医学院医学与科技学院', '52', '贵州省', '5203', '遵义市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2283, '4152013676', '贵州医科大学神奇民族医药\n学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2284, '4152014223', '贵州师范学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2285, '4152014440', '贵州理工学院', '52', '贵州省', '5201', '贵阳市', '本科', '贵州省', NULL);
INSERT INTO `school` VALUES (2286, '4152014625', '茅台学院', '52', '贵州省', '5203', '遵义市', '本科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2287, '4152011663', '黔南民族医学高等专科学校', '52', '贵州省', '5227', '黔南布依族苗族自治州', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2288, '4152012222', '贵州交通职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2289, '4152012223', '贵州航天职业技术学院', '52', '贵州省', '5203', '遵义市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2290, '4152012336', '贵州电子信息职业技术学院', '52', '贵州省', '5226', '黔东南苗族侗族自治州', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2291, '4152012821', '安顺职业技术学院', '52', '贵州省', '5204', '安顺市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2292, '4152012822', '黔东南民族职业技术学院', '52', '贵州省', '5226', '黔东南苗族侗族自治州', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2293, '4152012823', '黔南民族职业技术学院', '52', '贵州省', '5227', '黔南布依族苗族自治州', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2294, '4152012824', '遵义职业技术学院', '52', '贵州省', '5203', '遵义市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2295, '4152012850', '贵州城市职业学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2296, '4152013052', '贵州工业职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2297, '4152013053', '贵州电力职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2298, '4152013054', '六盘水职业技术学院', '52', '贵州省', '5202', '六盘水市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2299, '4152013055', '铜仁职业技术学院', '52', '贵州省', '5206', '铜仁市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2300, '4152013817', '黔西南民族职业技术学院', '52', '贵州省', '5223', '黔西南布依族苗族自治州', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2301, '4152013818', '贵州轻工职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2302, '4152014011', '遵义医药高等专科学校', '52', '贵州省', '5203', '遵义市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2303, '4152014083', '贵阳护理职业学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2304, '4152014129', '贵阳职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2305, '4152014198', '毕节职业技术学院', '52', '贵州省', '5205', '毕节市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2306, '4152014252', '贵州职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2307, '4152014371', '贵州盛华职业学院', '52', '贵州省', '5227', '黔南布依族苗族自治州', '专科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2308, '4152014412', '贵州工商职业学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2309, '4152014469', '贵阳幼儿师范高等专科学校', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2310, '4152014470', '铜仁幼儿师范高等专科学校', '52', '贵州省', '5206', '铜仁市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2311, '4152014497', '黔南民族幼儿师范高等专科\n学校', '52', '贵州省', '5227', '黔南布依族苗族自治州', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2312, '4152014499', '毕节医学高等专科学校', '52', '贵州省', '5205', '毕节市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2313, '4152014516', '贵州建设职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2314, '4152014538', '毕节幼儿师范高等专科学校', '52', '贵州省', '5205', '毕节市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2315, '4152014549', '贵州农业职业学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2316, '4152014558', '贵州工程职业学院', '52', '贵州省', '5206', '铜仁市', '专科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2317, '4152014559', '贵州工贸职业学院', '52', '贵州省', '5205', '毕节市', '专科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2318, '4152014577', '贵州水利水电职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2319, '4152014578', '贵州电子商务职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2320, '4152014579', '贵州应用技术职业学院', '52', '贵州省', '5227', '黔南布依族苗族自治州', '专科', '贵州省教育厅', '民办');
INSERT INTO `school` VALUES (2321, '4152014580', '贵州电子科技职业学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2322, '4152014613', '贵州装备制造职业学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2323, '4152014614', '贵州健康职业学院', '52', '贵州省', '5206', '铜仁市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2324, '4152014615', '贵州食品工程职业学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2325, '4152014616', '贵州经贸职业技术学院', '52', '贵州省', '5227', '黔南布依族苗族自治州', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2326, '4152014617', '贵州护理职业技术学院', '52', '贵州省', '5227', '黔南布依族苗族自治州', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2327, '4252050963', '贵州航空职业技术学院', '52', '贵州省', '5201', '贵阳市', '专科', '贵州省', NULL);
INSERT INTO `school` VALUES (2328, '4153010673', '云南大学', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2329, '4153010674', '昆明理工大学', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2330, '4153010676', '云南农业大学', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2331, '4153010677', '西南林业大学', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2332, '4153010678', '昆明医科大学', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2333, '4153010679', '大理大学', '53', '云南省', '5329', '大理白族\n自治州', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2334, '4153010680', '云南中医学院', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2335, '4153010681', '云南师范大学', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2336, '4153010683', '昭通学院', '53', '云南省', '5306', '昭通市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2337, '4153010684', '曲靖师范学院', '53', '云南省', '5303', '曲靖市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2338, '4153010685', '普洱学院', '53', '云南省', '5308', '普洱市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2339, '4153010686', '保山学院', '53', '云南省', '5305', '保山市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2340, '4153010687', '红河学院', '53', '云南省', '5325', '红河哈尼族彝族自治州', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2341, '4153010689', '云南财经大学', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2342, '4153010690', '云南艺术学院', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2343, '4153010691', '云南民族大学', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2344, '4153011390', '玉溪师范学院', '53', '云南省', '5304', '玉溪市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2345, '4153011391', '楚雄师范学院', '53', '云南省', '5323', '楚雄彝族\n自治州', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2346, '4153011392', '云南警官学院', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2347, '4153011393', '昆明学院', '53', '云南省', '5301', '昆明市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2348, '4153011556', '文山学院', '53', '云南省', '5326', '文山壮族苗族自治州', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2349, '4153012560', '云南经济管理学院', '53', '云南省', '5301', '昆明市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2350, '4153013326', '云南大学滇池学院', '53', '云南省', '5301', '昆明市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2351, '4153013328', '云南大学旅游文化学院', '53', '云南省', '5307', '丽江市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2352, '4153013329', '昆明理工大学津桥学院', '53', '云南省', '5301', '昆明市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2353, '4153013330', '云南师范大学商学院', '53', '云南省', '5301', '昆明市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2354, '4153013331', '云南师范大学文理学院', '53', '云南省', '5301', '昆明市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2355, '4153013332', '昆明医科大学海源学院', '53', '云南省', '5301', '昆明市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2356, '4153013333', '云南艺术学院文华学院', '53', '云南省', '5301', '昆明市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2357, '4153013909', '云南工商学院', '53', '云南省', '5301', '昆明市', '本科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2358, '4153014092', '滇西科技师范学院', '53', '云南省', '5309', '临沧市', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2359, '4153014623', '滇西应用技术大学', '53', '云南省', '5329', '大理白族\n自治州', '本科', '云南省', NULL);
INSERT INTO `school` VALUES (2360, '4153011557', '昆明冶金高等专科学校', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2361, '4153012349', '云南国土资源职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2362, '4153012357', '云南交通职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2363, '4153012393', '昆明工业职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2364, '4153012555', '云南农业职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2365, '4153012556', '云南司法警官职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2366, '4153012558', '云南文化艺术职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2367, '4153012559', '云南体育运动职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2368, '4153012825', '云南科技信息职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2369, '4153012826', '西双版纳职业技术学院', '53', '云南省', '5328', '西双版纳傣族自治州', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2370, '4153012851', '昆明艺术职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2371, '4153012971', '玉溪农业职业技术学院', '53', '云南省', '5304', '玉溪市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2372, '4153013136', '云南能源职业技术学院', '53', '云南省', '5303', '曲靖市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2373, '4153013756', '云南国防工业职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2374, '4153013757', '云南机电职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2375, '4153013758', '云南林业职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2376, '4153013759', '云南城市建设职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2377, '4153013761', '云南工程职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2378, '4153014012', '曲靖医学高等专科学校', '53', '云南省', '5303', '曲靖市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2379, '4153014013', '楚雄医药高等专科学校', '53', '云南省', '5320', '楚雄彝族\n自治州', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2380, '4153014014', '保山中医药高等专科学校', '53', '云南省', '5305', '保山市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2381, '4153014015', '丽江师范高等专科学校', '53', '云南省', '5307', '丽江市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2382, '4153014016', '德宏师范高等专科学校', '53', '云南省', '5331', '德宏傣族景颇族自治州', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2383, '4153014032', '云南新兴职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2384, '4153014130', '云南锡业职业技术学院', '53', '云南省', '5325', '红河哈尼族彝族自治州', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2385, '4153014212', '云南经贸外事职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2386, '4153014239', '云南三鑫职业技术学院', '53', '云南省', '5326', '文山壮族苗族自治州', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2387, '4153014253', '德宏职业学院', '53', '云南省', '5331', '德宏傣族景颇族自治州', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2388, '4153014317', '云南商务职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2389, '4153014372', '昆明卫生职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2390, '4153014373', '云南现代职业技术学院', '53', '云南省', '5323', '楚雄彝族\n自治州', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2391, '4153014381', '云南旅游职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2392, '4153014413', '红河卫生职业学院', '53', '云南省', '5325', '红河哈尼族彝族自治州', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2393, '4153014415', '云南外事外语职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省教育厅', '民办');
INSERT INTO `school` VALUES (2394, '4153014487', '大理农林职业技术学院', '53', '云南省', '5329', '大理白族\n自治州', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2395, '4153014534', '公安消防部队高等专科学校', '53', '云南省', '5301', '昆明市', '专科', '公安部', NULL);
INSERT INTO `school` VALUES (2396, '4153014550', '云南财经职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2397, '4153014581', '昆明铁道职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2398, '4153014582', '昭通卫生职业学院', '53', '云南省', '5306', '昭通市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2399, '4153014583', '大理护理职业学院', '53', '云南省', '5329', '大理白族自治州', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2400, '4153014584', '云南水利水电职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2401, '4153014618', '云南轻纺职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2402, '4153014619', '云南特殊教育职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2403, '4153014620', '云南工贸职业技术学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2404, '4153014621', '云南交通运输职业学院', '53', '云南省', '5301', '昆明市', '专科', '云南省', NULL);
INSERT INTO `school` VALUES (2405, '4154010694', '西藏大学', '54', '西藏自治区', '5401', '拉萨市', '本科', '西藏自治区', NULL);
INSERT INTO `school` VALUES (2406, '4154010695', '西藏民族大学', '61', '陕西省', '6104', '咸阳市', '本科', '西藏自治区', NULL);
INSERT INTO `school` VALUES (2407, '4154010696', '西藏藏医学院', '54', '西藏自治区', '5401', '拉萨市', '本科', '西藏自治区', NULL);
INSERT INTO `school` VALUES (2408, '4154010693', '西藏农牧学院', '54', '西藏自治区', '5404', '林芝市', '本科', '西藏自治区', NULL);
INSERT INTO `school` VALUES (2409, '4154010692', '西藏警官高等专科学校', '54', '西藏自治区', '5401', '拉萨市', '专科', '西藏自治区', NULL);
INSERT INTO `school` VALUES (2410, '4154012481', '拉萨师范高等专科学校', '54', '西藏自治区', '5401', '拉萨市', '专科', '西藏自治区', NULL);
INSERT INTO `school` VALUES (2411, '4154014085', '西藏职业技术学院', '54', '西藏自治区', '5401', '拉萨市', '专科', '西藏自治区', NULL);
INSERT INTO `school` VALUES (2412, '4161010697', '西北大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2413, '4161010698', '西安交通大学', '61', '陕西省', '6101', '西安市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2414, '4161010699', '西北工业大学', '61', '陕西省', '6101', '西安市', '本科', '工业和信息化部', NULL);
INSERT INTO `school` VALUES (2415, '4161010700', '西安理工大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2416, '4161010701', '西安电子科技大学', '61', '陕西省', '6101', '西安市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2417, '4161010702', '西安工业大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2418, '4161010703', '西安建筑科技大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2419, '4161010704', '西安科技大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2420, '4161010705', '西安石油大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2421, '4161010708', '陕西科技大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2422, '4161010709', '西安工程大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2423, '4161010710', '长安大学', '61', '陕西省', '6101', '西安市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2424, '4161010712', '西北农林科技大学', '61', '陕西省', '6104', '咸阳市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2425, '4161010716', '陕西中医药大学', '61', '陕西省', '6104', '咸阳市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2426, '4161010718', '陕西师范大学', '61', '陕西省', '6101', '西安市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2427, '4161010719', '延安大学', '61', '陕西省', '6106', '延安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2428, '4161010720', '陕西理工大学', '61', '陕西省', '6107', '汉中市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2429, '4161010721', '宝鸡文理学院', '61', '陕西省', '6103', '宝鸡市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2430, '4161010722', '咸阳师范学院', '61', '陕西省', '6104', '咸阳市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2431, '4161010723', '渭南师范学院', '61', '陕西省', '6105', '渭南市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2432, '4161010724', '西安外国语大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2433, '4161010726', '西北政法大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2434, '4161010727', '西安体育学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2435, '4161010728', '西安音乐学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2436, '4161010729', '西安美术学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2437, '4161011080', '西安文理学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2438, '4161011395', '榆林学院', '61', '陕西省', '6108', '榆林市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2439, '4161011396', '商洛学院', '61', '陕西省', '6110', '商洛市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2440, '4161011397', '安康学院', '61', '陕西省', '6109', '安康市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2441, '4161011400', '西安培华学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2442, '4161011560', '西安财经学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2443, '4161011664', '西安邮电大学', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2444, '4161011736', '西安航空学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2445, '4161011840', '西安医学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2446, '4161012712', '西安欧亚学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2447, '4161012713', '西安外事学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2448, '4161012714', '西安翻译学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2449, '4161012715', '西京学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2450, '4161013121', '西安思源学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2451, '4161013123', '陕西国际商贸学院', '61', '陕西省', '6104', '咸阳市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2452, '4161013125', '陕西服装工程学院', '61', '陕西省', '6104', '咸阳市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2453, '4161013569', '西安交通工程学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2454, '4161013677', '西安交通大学城市学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2455, '4161013678', '西北大学现代学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2456, '4161013679', '西安建筑科技大学华清学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2457, '4161013680', '西安财经学院行知学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2458, '4161013681', '陕西科技大学镐京学院', '61', '陕西省', '6104', '咸阳市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2459, '4161013682', '西安工业大学北方信息工程\n学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2460, '4161013683', '延安大学西安创新学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2461, '4161013685', '西安电子科技大学长安学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2462, '4161013894', '西北工业大学明德学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2463, '4161014034', '长安大学兴华学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2464, '4161014041', '西安理工大学高科学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2465, '4161014042', '西安科技大学高新学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2466, '4161014390', '陕西学前师范学院', '61', '陕西省', '6101', '西安市', '本科', '陕西省', NULL);
INSERT INTO `school` VALUES (2467, '4161010828', '陕西工业职业技术学院', '61', '陕西省', '6104', '咸阳市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2468, '4161010966', '杨凌职业技术学院', '61', '陕西省', '6104', '咸阳市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2469, '4161011826', '西安电力高等专科学校', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2470, '4161012510', '陕西能源职业技术学院', '61', '陕西省', '6104', '咸阳市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2471, '4161012827', '陕西国防工业职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2472, '4161012828', '西安航空职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2473, '4161012829', '陕西财经职业技术学院', '61', '陕西省', '6104', '咸阳市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2474, '4161012830', '陕西交通职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2475, '4161012831', '陕西职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2476, '4161013122', '西安高新科技职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2477, '4161013124', '西安城市建设职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2478, '4161013566', '陕西铁路工程职业技术学院', '61', '陕西省', '6105', '渭南市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2479, '4161013567', '宝鸡职业技术学院', '61', '陕西省', '6103', '宝鸡市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2480, '4161013568', '陕西航空职业技术学院', '61', '陕西省', '6107', '汉中市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2481, '4161013570', '陕西电子信息职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2482, '4161013736', '陕西邮电职业技术学院', '61', '陕西省', '6104', '咸阳市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2483, '4161013737', '西安海棠职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2484, '4161013738', '西安汽车科技职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2485, '4161013739', '西安东方亚太职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2486, '4161013819', '陕西警官职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2487, '4161013932', '陕西经济管理职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2488, '4161013945', '西安铁路职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2489, '4161013946', '咸阳职业技术学院', '61', '陕西省', '6104', '咸阳市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2490, '4161013947', '西安职业技术学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2491, '4161013948', '商洛职业技术学院', '61', '陕西省', '6110', '商洛市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2492, '4161013949', '汉中职业技术学院', '61', '陕西省', '6107', '汉中市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2493, '4161013950', '延安职业技术学院', '61', '陕西省', '6106', '延安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2494, '4161013951', '渭南职业技术学院', '61', '陕西省', '6105', '渭南市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2495, '4161013952', '安康职业技术学院', '61', '陕西省', '6109', '安康市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2496, '4161013953', '铜川职业技术学院', '61', '陕西省', '6102', '铜川市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2497, '4161014028', '陕西青年职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2498, '4161014029', '陕西工商职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2499, '4161014030', '陕西电子科技职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2500, '4161014031', '陕西旅游烹饪职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2501, '4161014222', '西安医学高等专科学校', '61', '陕西省', '6101', '西安市', '专科', '陕西省教育厅', '民办');
INSERT INTO `school` VALUES (2502, '4161014318', '榆林职业技术学院', '61', '陕西省', '6108', '榆林市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2503, '4161014488', '陕西艺术职业学院', '61', '陕西省', '6101', '西安市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2504, '4261050084', '陕西机电职业技术学院', '61', '陕西省', '6103', '宝鸡市', '专科', '陕西省', NULL);
INSERT INTO `school` VALUES (2505, '4162010730', '兰州大学', '62', '甘肃省', '6201', '兰州市', '本科', '教育部', NULL);
INSERT INTO `school` VALUES (2506, '4162010731', '兰州理工大学', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2507, '4162010732', '兰州交通大学', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2508, '4162010733', '甘肃农业大学', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2509, '4162010735', '甘肃中医药大学', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2510, '4162010736', '西北师范大学', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2511, '4162010737', '兰州城市学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2512, '4162010738', '陇东学院', '62', '甘肃省', '6210', '庆阳市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2513, '4162010739', '天水师范学院', '62', '甘肃省', '6205', '天水市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2514, '4162010740', '河西学院', '62', '甘肃省', '6207', '张掖市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2515, '4162010741', '兰州财经大学', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2516, '4162010742', '西北民族大学', '62', '甘肃省', '6201', '兰州市', '本科', '国家民委', NULL);
INSERT INTO `school` VALUES (2517, '4162011406', '甘肃政法学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2518, '4162011561', '甘肃民族师范学院', '60', '甘肃省', '6230', '甘南藏族\n自治州', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2519, '4162011562', '兰州文理学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2520, '4162011805', '甘肃医学院', '62', '甘肃省', '6208', '平凉市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2521, '4162011807', '兰州工业学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2522, '4162013510', '西北师范大学知行学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省教育厅', '民办');
INSERT INTO `school` VALUES (2523, '4162013511', '兰州财经大学陇桥学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省教育厅', '民办');
INSERT INTO `school` VALUES (2524, '4162013512', '兰州财经大学长青学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省教育厅', '民办');
INSERT INTO `school` VALUES (2525, '4162013514', '兰州交通大学博文学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省教育厅', '民办');
INSERT INTO `school` VALUES (2526, '4162013515', '兰州理工大学技术工程学院', '62', '甘肃省', '6201', '兰州市', '本科', '甘肃省教育厅', '民办');
INSERT INTO `school` VALUES (2527, '4162010838', '兰州石化职业技术学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2528, '4162011806', '陇南师范高等专科学校', '62', '甘肃省', '6212', '陇南市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2529, '4162011808', '定西师范高等专科学校', '62', '甘肃省', '6211', '定西市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2530, '4162012511', '甘肃建筑职业技术学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2531, '4162012539', '酒泉职业技术学院', '62', '甘肃省', '6209', '酒泉市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2532, '4162012832', '兰州外语职业学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省教育厅', '民办');
INSERT INTO `school` VALUES (2533, '4162012833', '兰州职业技术学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2534, '4162012834', '甘肃警察职业学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2535, '4162012835', '甘肃林业职业技术学院', '62', '甘肃省', '6205', '天水市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2536, '4162012836', '甘肃工业职业技术学院', '62', '甘肃省', '6205', '天水市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2537, '4162013518', '武威职业学院', '62', '甘肃省', '6206', '武威市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2538, '4162013519', '甘肃交通职业技术学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2539, '4162013933', '兰州资源环境职业技术学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2540, '4162013954', '甘肃农业职业技术学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2541, '4162013955', '甘肃畜牧工程职业技术学院', '62', '甘肃省', '6206', '武威市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2542, '4162014131', '甘肃钢铁职业技术学院', '62', '甘肃省', '6202', '嘉峪关市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2543, '4162014319', '甘肃机电职业技术学院', '62', '甘肃省', '6205', '天水市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2544, '4162014375', '甘肃有色冶金职业技术学院', '62', '甘肃省', '6203', '金昌市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2545, '4162014376', '白银矿冶职业技术学院', '62', '甘肃省', '6204', '白银市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2546, '4162014517', '甘肃卫生职业学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2547, '4162014518', '兰州科技职业学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省教育厅', '民办');
INSERT INTO `school` VALUES (2548, '4162014551', '庆阳职业技术学院', '62', '甘肃省', '6210', '庆阳市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2549, '4162014552', '临夏现代职业学院', '62', '甘肃省', '6229', '	临夏回族自治州', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2550, '4162014593', '甘肃能源化工职业学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2551, '4162014594', '兰州现代职业学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2552, '4162014595', '平凉职业技术学院', '62', '甘肃省', '6208', '平凉市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2553, '4262051378', '甘肃财贸职业学院', '62', '甘肃省', '6201', '兰州市', '专科', '甘肃省', NULL);
INSERT INTO `school` VALUES (2554, '4163010743', '青海大学', '63', '青海省', '6301', '西宁市', '本科', '青海省', NULL);
INSERT INTO `school` VALUES (2555, '4163010746', '青海师范大学', '63', '青海省', '6301', '西宁市', '本科', '青海省', NULL);
INSERT INTO `school` VALUES (2556, '4163010748', '青海民族大学', '63', '青海省', '6301', '西宁市', '本科', '青海省', NULL);
INSERT INTO `school` VALUES (2557, '4163013674', '青海大学昆仑学院', '63', '青海省', '6301', '西宁市', '本科', '青海省教育厅', '民办');
INSERT INTO `school` VALUES (2558, '4163012562', '青海卫生职业技术学院', '63', '青海省', '6301', '西宁市', '专科', '青海省', NULL);
INSERT INTO `school` VALUES (2559, '4163012852', '青海警官职业学院', '63', '青海省', '6301', '西宁市', '专科', '青海省', NULL);
INSERT INTO `school` VALUES (2560, '4163012972', '青海畜牧兽医职业技术学院', '63', '青海省', '6301', '西宁市', '专科', '青海省', NULL);
INSERT INTO `school` VALUES (2561, '4163012973', '青海交通职业技术学院', '63', '青海省', '6301', '西宁市', '专科', '青海省', NULL);
INSERT INTO `school` VALUES (2562, '4163012974', '青海建筑职业技术学院', '63', '青海省', '6301', '西宁市', '专科', '青海省', NULL);
INSERT INTO `school` VALUES (2563, '4163014519', '西宁城市职业技术学院', '63', '青海省', '6301', '西宁市', '专科', '青海省', NULL);
INSERT INTO `school` VALUES (2564, '4163014520', '青海高等职业技术学院', '63', '青海省', '6302', '海东市', '专科', '青海省', NULL);
INSERT INTO `school` VALUES (2565, '4163014521', '青海柴达木职业技术学院', '63', '青海省', '6328', '海西蒙古族藏族自治州', '专科', '青海省', NULL);
INSERT INTO `school` VALUES (2566, '4164010749', '宁夏大学', '64', '宁夏回族自治区', '6401', '银川市', '本科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2567, '4164010752', '宁夏医科大学', '64', '宁夏回族自治区', '6401', '银川市', '本科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2568, '4164010753', '宁夏师范学院', '64', '宁夏回族自治区', '6404', '固原市', '本科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2569, '4164011407', '北方民族大学', '64', '宁夏回族自治区', '6401', '银川市', '本科', '国家民委', NULL);
INSERT INTO `school` VALUES (2570, '4164012544', '宁夏理工学院', '64', '宁夏回族自治区', '6402', '石嘴山市', '本科', '宁夏自治区教育厅', '民办');
INSERT INTO `school` VALUES (2571, '4164013325', '宁夏大学新华学院', '64', '宁夏回族自治区', '6401', '银川市', '本科', '宁夏自治区教育厅', '民办');
INSERT INTO `school` VALUES (2572, '4164013820', '银川能源学院', '64', '宁夏回族自治区', '6401', '银川市', '本科', '宁夏自治区教育厅', '民办');
INSERT INTO `school` VALUES (2573, '4164014200', '中国矿业大学银川学院', '64', '宁夏回族自治区', '6401', '银川市', '本科', '宁夏自治区教育厅', '民办');
INSERT INTO `school` VALUES (2574, '4164012716', '宁夏民族职业技术学院', '64', '宁夏回族自治区', '6403', '吴忠市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2575, '4164012837', '宁夏工业职业学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2576, '4164013086', '宁夏职业技术学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2577, '4164013087', '宁夏工商职业技术学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2578, '4164013088', '宁夏财经职业技术学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2579, '4164013089', '宁夏警官职业学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2580, '4164013151', '宁夏建设职业技术学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2581, '4164014377', '宁夏葡萄酒与防沙治沙职业技术学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2582, '4164014498', '宁夏幼儿师范高等专科学校', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2583, '4164014522', '宁夏艺术职业学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2584, '4164014624', '宁夏体育职业学院', '64', '宁夏回族自治区', '6401', '银川市', '专科', '宁夏回族自治区', NULL);
INSERT INTO `school` VALUES (2585, '4165010755', '新疆大学', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2586, '4165010757', '塔里木大学', '65', '新疆维吾尔自治区', '659002', '阿拉尔市', '本科', '新疆生产建设兵团', NULL);
INSERT INTO `school` VALUES (2587, '4165010758', '新疆农业大学', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2588, '4165010759', '石河子大学', '65', '新疆维吾尔自治区', '659001', '石河子市', '本科', '新疆生产建设兵团', NULL);
INSERT INTO `school` VALUES (2589, '4165010760', '新疆医科大学', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2590, '4165010762', '新疆师范大学', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2591, '4165010763', '喀什大学', '65', '新疆维吾尔自治区', '6531', '喀什地区', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2592, '4165010764', '伊犁师范学院', '65', '新疆维吾尔自治区', '6540', '伊犁哈萨克\n自治州', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2593, '4165010766', '新疆财经大学', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2594, '4165010768', '新疆艺术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2595, '4165010994', '新疆工程学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2596, '4165010997', '昌吉学院', '65', '新疆维吾尔自治区', '6523', '昌吉回族\n自治州', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2597, '4165012734', '新疆警察学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2598, '4165013558', '新疆大学科学技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2599, '4165013559', '新疆农业大学科学技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2600, '4165013560', '新疆医科大学厚博学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2601, '4165013561', '新疆财经大学商务学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '本科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2602, '4165013628', '石河子大学科技学院', '65', '新疆维吾尔自治区', '659001', '石河子市', '本科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2603, '4165010765', '和田师范专科学校', '65', '新疆维吾尔自治区', '6532', '和田地区', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2604, '4165010995', '新疆农业职业技术学院', '65', '新疆维吾尔自治区', '6523', '昌吉回族\n自治州', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2605, '4165011565', '乌鲁木齐职业大学', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2606, '4165011818', '新疆维吾尔医学专科学校', '65', '新疆维吾尔自治区', '6532', '和田地区', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2607, '4165012482', '克拉玛依职业技术学院', '65', '新疆维吾尔自治区', '6502', '克拉玛依市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2608, '4165012513', '新疆机电职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2609, '4165012514', '新疆轻工职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2610, '4165012570', '新疆能源职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2611, '4165012838', '昌吉职业技术学院', '65', '新疆维吾尔自治区', '6523', '昌吉回族\n自治州', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2612, '4165012975', '伊犁职业技术学院', '65', '新疆维吾尔自治区', '6540', '伊犁哈萨克\n自治州', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2613, '4165013093', '阿克苏职业技术学院', '65', '新疆维吾尔自治区', '6529', '阿克苏地区', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2614, '4165013094', '巴音郭楞职业技术学院', '65', '新疆维吾尔自治区', '6528', '巴音郭楞蒙古自治州', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2615, '4165013562', '新疆建设职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2616, '4165013563', '新疆兵团警官高等专科学校', '65', '新疆维吾尔自治区', '659004', '五家渠市', '专科', '新疆生产建设兵团', NULL);
INSERT INTO `school` VALUES (2617, '4165013726', '新疆现代职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2618, '4165013727', '新疆天山职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2619, '4165013926', '新疆交通职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2620, '4165013956', '新疆石河子职业技术学院', '65', '新疆维吾尔自治区', '659001', '石河子市', '专科', '新疆生产建设兵团', NULL);
INSERT INTO `school` VALUES (2621, '4165014138', '新疆职业大学', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2622, '4165014416', '新疆体育职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2623, '4165014417', '新疆应用职业技术学院', '65', '新疆维吾尔自治区', '6540', '伊犁哈萨克\n自治州', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2624, '4165014421', '新疆师范高等专科学校', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2625, '4165014489', '新疆铁道职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2626, '4165014523', '新疆生产建设兵团兴新职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆生产建设兵团', NULL);
INSERT INTO `school` VALUES (2627, '4165014524', '哈密职业技术学院', '65', '新疆维吾尔自治区', '6505', '哈密市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2628, '4165014525', '新疆科技职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆自治区教育厅', '民办');
INSERT INTO `school` VALUES (2629, '4165014585', '吐鲁番职业技术学院', '65', '新疆维吾尔自治区', '6504', '吐鲁番市', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2630, '4165014622', '博尔塔拉职业技术学院', '65', '新疆维吾尔自治区', '6527', '博尔塔拉蒙古自治州', '专科', '新疆维吾尔自治区', NULL);
INSERT INTO `school` VALUES (2631, '4265051060', '新疆工业职业技术学院', '65', '新疆维吾尔自治区', '6501', '乌鲁木齐市', '专科', '新疆维吾尔自治区', NULL);

SET FOREIGN_KEY_CHECKS = 1;
