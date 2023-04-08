/*
 Navicat Premium Data Transfer

 Source Server         : SDPcontroller
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : 192.168.32.128:3306
 Source Schema         : sdp

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 04/03/2023 12:28:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for closed_connection
-- ----------------------------
DROP TABLE IF EXISTS `closed_connection`;
CREATE TABLE `closed_connection`  (
  `gateway_sdpid` int NOT NULL,
  `client_sdpid` int NOT NULL,
  `service_id` int NOT NULL,
  `start_timestamp` bigint NOT NULL,
  `end_timestamp` bigint NOT NULL,
  `protocol` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `source_ip` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `source_port` int NOT NULL,
  `destination_ip` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `destination_port` int NOT NULL,
  `nat_destination_ip` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `nat_destination_port` int NOT NULL,
  PRIMARY KEY (`gateway_sdpid`, `client_sdpid`, `start_timestamp`, `source_port`) USING BTREE,
  INDEX `gateway_sdpid`(`gateway_sdpid` ASC) USING BTREE,
  INDEX `client_sdpid`(`client_sdpid` ASC) USING BTREE,
  CONSTRAINT `closed_connection_ibfk_1` FOREIGN KEY (`gateway_sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `closed_connection_ibfk_2` FOREIGN KEY (`client_sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of closed_connection
-- ----------------------------

-- ----------------------------
-- Table structure for controller
-- ----------------------------
DROP TABLE IF EXISTS `controller`;
CREATE TABLE `controller`  (
  `sdpid` int NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `address` varchar(4096) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'ip or url',
  `port` int NOT NULL,
  `gateway_sdpid` int NULL DEFAULT NULL,
  `service_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`sdpid`) USING BTREE,
  INDEX `service_id`(`service_id` ASC) USING BTREE,
  INDEX `gateway_sdpid`(`gateway_sdpid` ASC) USING BTREE,
  CONSTRAINT `controller_ibfk_1` FOREIGN KEY (`sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `controller_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `controller_ibfk_3` FOREIGN KEY (`gateway_sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of controller
-- ----------------------------

-- ----------------------------
-- Table structure for environment
-- ----------------------------
DROP TABLE IF EXISTS `environment`;
CREATE TABLE `environment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `mobile` tinyint(1) NOT NULL,
  `os_group` enum('Android','iOS','Windows','OSX','Linux') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `os_version` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of environment
-- ----------------------------

-- ----------------------------
-- Table structure for gateway
-- ----------------------------
DROP TABLE IF EXISTS `gateway`;
CREATE TABLE `gateway`  (
  `sdpid` int NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `address` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'ip or url',
  `port` int NULL DEFAULT NULL,
  PRIMARY KEY (`sdpid`) USING BTREE,
  CONSTRAINT `gateway_ibfk_1` FOREIGN KEY (`sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway
-- ----------------------------

-- ----------------------------
-- Table structure for gateway_controller
-- ----------------------------
DROP TABLE IF EXISTS `gateway_controller`;
CREATE TABLE `gateway_controller`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `gateway_sdpid` int NOT NULL,
  `controller_sdpid` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gateway_sdpid`(`gateway_sdpid` ASC) USING BTREE,
  INDEX `controller_sdpid`(`controller_sdpid` ASC) USING BTREE,
  CONSTRAINT `gateway_controller_ibfk_1` FOREIGN KEY (`gateway_sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gateway_controller_ibfk_2` FOREIGN KEY (`controller_sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_controller
-- ----------------------------

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `valid` tinyint NOT NULL DEFAULT 1,
  `name` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `Description` varchar(4096) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group
-- ----------------------------

-- ----------------------------
-- Table structure for group_service
-- ----------------------------
DROP TABLE IF EXISTS `group_service`;
CREATE TABLE `group_service`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `service_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `service_id`(`service_id` ASC) USING BTREE,
  INDEX `group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `group_service_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `group_service_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_service
-- ----------------------------

-- ----------------------------
-- Table structure for open_connection
-- ----------------------------
DROP TABLE IF EXISTS `open_connection`;
CREATE TABLE `open_connection`  (
  `gateway_sdpid` int NOT NULL,
  `client_sdpid` int NOT NULL,
  `service_id` int NOT NULL,
  `start_timestamp` bigint NOT NULL,
  `end_timestamp` bigint NOT NULL,
  `protocol` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `source_ip` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `source_port` int NOT NULL,
  `destination_ip` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `destination_port` int NOT NULL,
  `nat_destination_ip` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `nat_destination_port` int NOT NULL,
  `gateway_controller_connection_id` int NOT NULL COMMENT 'Only used to track open conns, not an index to a table',
  PRIMARY KEY (`gateway_controller_connection_id`, `client_sdpid`, `start_timestamp`, `source_port`) USING BTREE,
  INDEX `gateway_sdpid`(`gateway_sdpid` ASC) USING BTREE,
  INDEX `client_sdpid`(`client_sdpid` ASC) USING BTREE,
  INDEX `service_id`(`service_id` ASC) USING BTREE,
  CONSTRAINT `open_connection_ibfk_1` FOREIGN KEY (`gateway_sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `open_connection_ibfk_2` FOREIGN KEY (`client_sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `open_connection_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of open_connection
-- ----------------------------

-- ----------------------------
-- Table structure for refresh_trigger
-- ----------------------------
DROP TABLE IF EXISTS `refresh_trigger`;
CREATE TABLE `refresh_trigger`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `table_name` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `event` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of refresh_trigger
-- ----------------------------
INSERT INTO `refresh_trigger` VALUES (43, '2022-11-28 20:30:59', 'sdpid', 'delete');
INSERT INTO `refresh_trigger` VALUES (44, '2022-11-28 20:38:15', 'service_gateway', 'insert');
INSERT INTO `refresh_trigger` VALUES (45, '2022-11-28 20:38:39', 'service_gateway', 'update');
INSERT INTO `refresh_trigger` VALUES (46, '2022-11-28 20:39:15', 'service_gateway', 'insert');
INSERT INTO `refresh_trigger` VALUES (47, '2022-11-28 20:39:31', 'sdpid_service', 'insert');
INSERT INTO `refresh_trigger` VALUES (48, '2022-11-28 20:39:35', 'sdpid_service', 'update');
INSERT INTO `refresh_trigger` VALUES (49, '2022-11-28 20:39:46', 'sdpid_service', 'insert');

-- ----------------------------
-- Table structure for sdpid
-- ----------------------------
DROP TABLE IF EXISTS `sdpid`;
CREATE TABLE `sdpid`  (
  `sdpid` int NOT NULL AUTO_INCREMENT,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  `type` enum('client','gateway','controller') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT 'client',
  `country` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `state` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `locality` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `org` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `org_unit` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `alt_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `encrypt_key` varchar(2048) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `hmac_key` varchar(2048) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `serial` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `last_cred_update` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `cred_update_due` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int NULL DEFAULT NULL,
  `environment_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`sdpid`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `environment_id`(`environment_id` ASC) USING BTREE,
  CONSTRAINT `sdpid_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `sdpid_ibfk_2` FOREIGN KEY (`environment_id`) REFERENCES `environment` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sdpid
-- ----------------------------
INSERT INTO `sdpid` VALUES (1, 1, 'client', 'US', 'CA', 'la', 'com', 'deee', 'dee', 'dee@qq.com', 'MB/PGLTjr0Afv+1zudQ9pvQNZA0I3ICMDYrrNgnnjZOHXfuANwoUxNaKmOL6WMyJvs2P3w9HzXujac7kFYsAuyw6QHxezxFVVlskQsbAgQkyrI+JZ5+OZCpxmETWnpKVzM6nwWTgEkPUR0NzbPZQeZvbSJKSPvwIrSVilLsCgYAfQt+8WPo4O2udWyaSZFLqWe1hVD8N6XKbxqrmFdN9VFkyV2YZDsta9i93JQEiYEjvTH4NOxk9MEqGBGvlmjQ2UvCE54N3ZN9sf2x4T+1gH0oA6vA0VE+zVn5zjIXg5+r/ZgcDxH1nbc75Ibo6rxDX1MKXz1LFJTuJJXbp1avFMQ==', 'AShq9mDF5VufC3xtrQtWiKbPHOD487Tr5zTwP+kC6IEprrhXa+KjtTwiFZr8+ZTYrAzgHaioN3Y4VbEEK7cCQEMU4n9zX3MQksE0wgIuudfR/igvHMbr7nvGsPPYksMiX+mzi6o959Qua4N7O61PkDNKTuBnyaLX0Kd40DWT8Sw=', '1111', '2023-03-03 14:22:38', '2023-04-03 00:00:00', NULL, NULL);
INSERT INTO `sdpid` VALUES (2, 1, 'controller', 'US', 'CA', 'la', 'com', 'deee', 'dee', 'dee@qq.com', 'tO+rQ7psyqOGlKbXX7n3gLxPeMmEHv7phpg/r++z/Nuac92fKRyiDH4x5pOuRveVkMYUIhn1XoviAkcQVfr1RZXqWiD3oDzsgiFIujRL/pFaNhQ5J4l1PPPPW3NLXBGnUZztXsV3UQogHVvwY9wmbeifJu8XVKUOMiNnRyUCgYBFXPcrlDveQg8xBNReyRWn7hWA8zbIMXUC0cdRUNO2pEvabuQtNvGiQLf3S+e3o9E4KLPlq8ODWkjaZXasD7UvVP78XYDU1APvpaoSqXkYkB2ZDU1sbtj+RVYj/9k1lMRvv/S8Xg0bueg+XNAc5suPx2Md2tbw+6k/yUgye0WHcw==', '/h6W7Qf6uZUXD8er6tdg0TmYoFSet5PMd05em9YoxapppcGLfaxmWsmsM3kS37GAYVQAI9bwvF0fWBZw8s0CQGF9e1/+jmWApqKGqB4QdIxCU+I6EZekvLR0rm9gUGzA2IrjyLixs3CmqlrxrnhJGQHFSK7hS7ALUp5IV4T6qK4=', '1111', '2023-03-01 14:15:35', '2023-04-01 00:00:00', NULL, NULL);
INSERT INTO `sdpid` VALUES (3, 1, 'gateway', 'US', 'CA', 'la', 'com', 'deee', 'dee', 'dee@qq.com', 'jzWzh2MfS476M26oNorxl9iq0gLWwjJ0FZzelgYtGuScOZL/OWRpnS2xxTSB8OLqHJHih+m7G4FwQDYtjSHFj26xECO/9DjremqP5ITGk91E90vD4HnNr06KWd2S8jACSfz7yUIwK8kU+sVOd+ByvZjQeCUgDSOvGT6EAQKBgQD0QkF79G125/2izXuuMDDILcera82CNT5/ANvDWBkE5TTa09gGvqiN1ZvqUW/FB7OJ1h5wDujBRgwion/Z/vpg/DsUNz2+m1U/Plcbqlr1AvrF1kCLFRvg+JTg5sRfScryZp//pzXG1uss6pSNAVKDs0xLTJdhND2kIknTLT7BoA==', 'etYGMrKkPf8Ig9T0LdUD3deRbDVy43zlyCtOtGWmXrAdo8u82+y9A4D6BgDLC4BAXv8gBklYB3d68ln89XkCQDahl6Qq+fh5KwqxBLN5lS/n/NPYWYdFSzLq3sjMGCMPpIdlr/OnCtbDQxJtLyhUJngx18y7weYPvgrzR7CKCU0=', '1111', '2023-03-03 14:22:13', '2023-04-03 00:00:00', NULL, NULL);

-- ----------------------------
-- Table structure for sdpid_service
-- ----------------------------
DROP TABLE IF EXISTS `sdpid_service`;
CREATE TABLE `sdpid_service`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sdpid` int NOT NULL,
  `service_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `service_id`(`service_id` ASC) USING BTREE,
  INDEX `sdpid`(`sdpid` ASC) USING BTREE,
  CONSTRAINT `sdpid_service_ibfk_1` FOREIGN KEY (`sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sdpid_service_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sdpid_service
-- ----------------------------
INSERT INTO `sdpid_service` VALUES (1, 1, 2);
INSERT INTO `sdpid_service` VALUES (2, 1, 2);

-- ----------------------------
-- Table structure for service
-- ----------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `description` varchar(4096) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service
-- ----------------------------
INSERT INTO `service` VALUES (1, 'controller', 'controller');
INSERT INTO `service` VALUES (2, 'gateway', 'SDP gateway');

-- ----------------------------
-- Table structure for service_gateway
-- ----------------------------
DROP TABLE IF EXISTS `service_gateway`;
CREATE TABLE `service_gateway`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_id` int NOT NULL,
  `gateway_sdpid` int NOT NULL,
  `protocol` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'TCP, UDP',
  `port` int UNSIGNED NOT NULL,
  `nat_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT '1.1.1.1   internal IP address',
  `nat_port` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `service_id`(`service_id` ASC) USING BTREE,
  INDEX `gateway_sdpid`(`gateway_sdpid` ASC) USING BTREE,
  CONSTRAINT `service_gateway_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `service_gateway_ibfk_2` FOREIGN KEY (`gateway_sdpid`) REFERENCES `sdpid` (`sdpid`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service_gateway
-- ----------------------------
INSERT INTO `service_gateway` VALUES (1, 2, 3, 'tcp', 22, '', 0);
INSERT INTO `service_gateway` VALUES (2, 1, 2, 'tcp', 5000, '', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `last_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `first_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `country` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `state` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `locality` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `org` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `org_unit` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `alt_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `user_group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_group
-- ----------------------------

-- ----------------------------
-- Triggers structure for table group
-- ----------------------------
DROP TRIGGER IF EXISTS `group_after_delete`;
delimiter ;;
CREATE TRIGGER `group_after_delete` AFTER DELETE ON `group` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'group',
        event = 'delete';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table group_service
-- ----------------------------
DROP TRIGGER IF EXISTS `group_service_after_insert`;
delimiter ;;
CREATE TRIGGER `group_service_after_insert` AFTER INSERT ON `group_service` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'group_service',
        event = 'insert';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table group_service
-- ----------------------------
DROP TRIGGER IF EXISTS `group_service_after_update`;
delimiter ;;
CREATE TRIGGER `group_service_after_update` AFTER UPDATE ON `group_service` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'group_service',
        event = 'update';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table group_service
-- ----------------------------
DROP TRIGGER IF EXISTS `group_service_after_delete`;
delimiter ;;
CREATE TRIGGER `group_service_after_delete` AFTER DELETE ON `group_service` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'group_service',
        event = 'delete';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sdpid
-- ----------------------------
DROP TRIGGER IF EXISTS `sdpid_after_update`;
delimiter ;;
CREATE TRIGGER `sdpid_after_update` AFTER UPDATE ON `sdpid` FOR EACH ROW BEGIN
IF OLD.user_id != NEW.user_id OR
   OLD.valid != NEW.valid THEN
    INSERT INTO refresh_trigger
    SET table_name = 'sdpid',
        event = 'update';
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sdpid
-- ----------------------------
DROP TRIGGER IF EXISTS `sdpid_after_delete`;
delimiter ;;
CREATE TRIGGER `sdpid_after_delete` AFTER DELETE ON `sdpid` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'sdpid',
        event = 'delete';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sdpid_service
-- ----------------------------
DROP TRIGGER IF EXISTS `sdpid_service_after_insert`;
delimiter ;;
CREATE TRIGGER `sdpid_service_after_insert` AFTER INSERT ON `sdpid_service` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'sdpid_service',
        event = 'insert';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sdpid_service
-- ----------------------------
DROP TRIGGER IF EXISTS `sdpid_service_after_update`;
delimiter ;;
CREATE TRIGGER `sdpid_service_after_update` AFTER UPDATE ON `sdpid_service` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'sdpid_service',
        event = 'update';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sdpid_service
-- ----------------------------
DROP TRIGGER IF EXISTS `sdpid_service_after_delete`;
delimiter ;;
CREATE TRIGGER `sdpid_service_after_delete` AFTER DELETE ON `sdpid_service` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'sdpid_service',
        event = 'delete';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table service
-- ----------------------------
DROP TRIGGER IF EXISTS `service_after_delete`;
delimiter ;;
CREATE TRIGGER `service_after_delete` AFTER DELETE ON `service` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'service',
        event = 'delete';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table service_gateway
-- ----------------------------
DROP TRIGGER IF EXISTS `service_gateway_after_insert`;
delimiter ;;
CREATE TRIGGER `service_gateway_after_insert` AFTER INSERT ON `service_gateway` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'service_gateway',
        event = 'insert';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table service_gateway
-- ----------------------------
DROP TRIGGER IF EXISTS `service_gateway_after_update`;
delimiter ;;
CREATE TRIGGER `service_gateway_after_update` AFTER UPDATE ON `service_gateway` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'service_gateway',
        event = 'update';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table service_gateway
-- ----------------------------
DROP TRIGGER IF EXISTS `service_gateway_after_delete`;
delimiter ;;
CREATE TRIGGER `service_gateway_after_delete` AFTER DELETE ON `service_gateway` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'service_gateway',
        event = 'delete';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user
-- ----------------------------
DROP TRIGGER IF EXISTS `user_after_delete`;
delimiter ;;
CREATE TRIGGER `user_after_delete` AFTER DELETE ON `user` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'user',
        event = 'delete';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user_group
-- ----------------------------
DROP TRIGGER IF EXISTS `user_group_after_insert`;
delimiter ;;
CREATE TRIGGER `user_group_after_insert` AFTER INSERT ON `user_group` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'user_group',
        event = 'insert';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user_group
-- ----------------------------
DROP TRIGGER IF EXISTS `user_group_after_update`;
delimiter ;;
CREATE TRIGGER `user_group_after_update` AFTER UPDATE ON `user_group` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'user_group',
        event = 'update';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user_group
-- ----------------------------
DROP TRIGGER IF EXISTS `user_group_after_delete`;
delimiter ;;
CREATE TRIGGER `user_group_after_delete` AFTER DELETE ON `user_group` FOR EACH ROW BEGIN
    INSERT INTO refresh_trigger
    SET table_name = 'user_group',
        event = 'delete';
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
