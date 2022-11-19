# 实验二 利用SQL语言完成数据库维护

# 实验题目1
# 向学生表插入数据
INSERT INTO Student (`Sno`, `Sname`, `Ssex`,`Sage`,`Sdept`)
VALUES 
('201215126', '小明', '男', 20, 'CS'),
('201215127', '小红', '女', 19, 'CS');
	
# 向课程表插入数据
INSERT INTO Course (`Cno`,`Cname`,`Cpno`,`Ccredit`)
VALUES
('8', '语文', NULL, 4),
('9', '英语', NULL, 5);

# 向学生选课表插入数据
INSERT INTO SC (`Sno`, `Cno`, `Grade`)
VALUES
('201215126', '8', 75),
('201215127', '9', 85);

# 实验题目2
# 将201215121的年龄改为22岁
UPDATE Student
SET Sage=22
WHERE Sno='201215121';

# 将所有学生的年龄增加1岁
UPDATE Student
SET Sage=Sage+1;

# 将计算机科学系全体学生的成绩置零
UPDATE SC
SET Grade=0
WHERE Sno IN
	(SELECT Sno
	FROM Student
	WHERE Sdept='CS');
	
# 实验题目3
# 删除学号为201215128的学生记录
# 先创建一个201215128的学生记录
INSERT INTO Student (`Sno`, `Sname`, `Ssex`,`Sage`,`Sdept`) VALUE ('201215128', '小王', '男', 20, 'CS');
# 删除这条记录
DELETE
FROM Student
WHERE Sno='201215128';

#删除所有的学生选课记录
DELETE
FROM SC;

# 删除计算机科学系所有学生的选课记录
# 先插入数据
INSERT INTO SC (`Sno`, `Cno`, `Grade`)
VALUES
('201215121', '1', 92),
('201215121', '2', 85),
('201215121', '3', 88),
('201215122', '2', 90),
('201215122', '3', 80);

# 删除计算机学生的选课记录
DELETE
FROM SC
WHERE Sno IN
	(SELECT Sno
	FROM Student
	WHERE Sdept='CS');