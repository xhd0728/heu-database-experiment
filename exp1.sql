# 实验一 利用SQL语言完成数据库定义

# 创建数据库
CREATE DATABASE school;

# 创建学生表
CREATE TABLE Student(
	`Sno` VARCHAR(10) PRIMARY KEY,
	`Sname` VARCHAR(20) UNIQUE,
	`Ssex` VARCHAR(2),
	`Sage` SMALLINT,
	`Sdept` VARCHAR(20));
	
# 创建课程表
CREATE TABLE Course(
	`Cno` VARCHAR(10) PRIMARY KEY,
	`Cname` VARCHAR(20) NOT NULL,
	`Cpno` VARCHAR(10),
	`Ccredit` SMALLINT,
	FOREIGN KEY (Cpno) REFERENCES Course (Cno));
	
# 创建学生选课表
CREATE TABLE SC(
	`Sno` VARCHAR(10),
	`Cno` VARCHAR(10),
	`Grade` SMALLINT,
	PRIMARY KEY (Sno, Cno),
	FOREIGN KEY (Sno) REFERENCES Student(Sno),
	FOREIGN KEY (Cno) REFERENCES Course (Cno));

# 向学生表插入数据
INSERT INTO Student (`Sno`, `Sname`, `Ssex`,`Sage`,`Sdept`)
VALUES 
('201215121', '李勇', '男', 20, 'CS'),
('201215122', '刘晨', '女', 19, 'CS'),
('201215123', '王敏', '女', 18, 'MA'),
('201215125', '张立', '男', 19, 'IS');
	
# 向课程表插入数据
INSERT INTO Course (`Cno`,`Cname`,`Cpno`,`Ccredit`)
VALUES
('2', '数学', NULL, 2),
('6', '数据处理', NULL, 2),
('4', '操作系统', '6', 3),
('7', 'PASCAL语言', '6', 4),
('5', '数据结构', '7', 4),
('1', '数据库', '5', 4),
('3', '信息系统', '1', 4);

# 向学生选课表插入数据
INSERT INTO SC (`Sno`, `Cno`, `Grade`)
VALUES
('201215121', '1', 92),
('201215121', '2', 85),
('201215121', '3', 88),
('201215122', '2', 90),
('201215122', '3', 80);