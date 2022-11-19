# 实验三 利用SQL语句完成数据库查询

# 实验题目1
# 先向学生选课表插入数据
INSERT INTO SC (`Sno`, `Cno`, `Grade`)
VALUES
('201215121', '1', 92),
('201215121', '2', 85),
('201215121', '3', 88),
('201215122', '2', 90),
('201215122', '3', 80);

# 统计平均值
SELECT AVG(Grade)
FROM SC, Student
WHERE Sdept='CS';

# 实验题目2
# 统计至少选修了两门课程的学生数
SELECT COUNT(*) AS `count`
FROM Student
WHERE Sno IN
(SELECT Sno
FROM SC
GROUP BY Sno
HAVING COUNT(*)>=2);

# 实验题目3
# 先查询出至少选修了两门课程学生的Sno
# 再根据Sno从Student表中查询出学生名单
SELECT Student.*
FROM Student
WHERE Sno IN
	(SELECT SC.Sno
	FROM SC
	GROUP BY Sno
	HAVING COUNT(*)>=2);

# 实验题目4
# 首先从SC表中查询出所有被选修的课程Cno
# 再使用not in查询出没有被选修的课程信息
SELECT Cno, Cname
FROM Course
WHERE Cno NOT IN
(SELECT Cno FROM SC);

# 实验题目5
# 首先查询出所有选修了1号课程的学生信息
# 再使用not exists语句查询出没有选修1号课程的学生信息
SELECT Student.*
FROM Student
WHERE NOT EXISTS
	(SELECT Sname
	FROM SC
	WHERE Student.Sno=SC.Sno AND Cno='1');

# 实验题目6
# 首先查询出没有选修1号课程的学生信息
# 再使用count函数计数
SELECT COUNT(Sno)
FROM Student
WHERE NOT EXISTS
	(SELECT Sname
	FROM SC
	WHERE Student.Sno=SC.Sno AND Cno='1');

# 实验题目7
# 首先在SC中查询选修了1号课程的学生学号Sno
# 添加选修了2号课程的限制条件
# 根据Sno从Student表中查询满足以上条件的学生数据
SELECT Student.*
FROM Student
WHERE Sno IN
(SELECT Sno FROM SC
WHERE Sno IN
(SELECT Sno FROM SC WHERE Cno='1') AND Cno='2');

# 实验题目8
# 使用min语句从SC中选出所有最低成绩大于等于80的学生学号Sno
# 从Student中按照Sno查询学生信息
SELECT Student.*
FROM Student
WHERE Student.Sno IN
	(SELECT Sno
	FROM SC
	GROUP BY Sno
	HAVING MIN(Grade)>=80);

# 实验题目9
# 使用count函数在SC表中计算课程数
# 使用count(distinct)语句计算学生数
# 计算出学生平均选课程数
SELECT COUNT(SC.Cno) / COUNT(DISTINCT Sno)
FROM SC;

# 实验题目10
# 首先使用group by语句按院系Sdept分组
# 然后在SC表中使用count函数计算课程数
# 使用count(distinct)计算学生数
# 计算各院系学生平均选课数
SELECT DISTINCT Student.Sdept, COUNT(Cno) / COUNT(SC.Sno)
FROM SC, Student
WHERE (SC.Sno=Student.Sno)
GROUP BY Student.Sdept;

# 实验题目11
# 使用group by语句按课程号分组
# 使用count函数计算每门课的选课人数
# 使用max函数计算最高分
# 使用min函数计算最低分
# 使用avg函数计算平均分
SELECT SC.Sno,
COUNT(*) AS `total`,
MAX(SC.Grade) AS `max`,
MIN(SC.Grade) AS `min`,
AVG(SC.Grade) AS `average`
FROM SC
GROUP BY SC.Cno;

# 实验题目12
# 使用group by函数按学生Sno分组
# 使用having语句限制查询条件
SELECT Student.*
FROM Student
WHERE Student.Sno IN
	(SELECT Sno
	FROM SC
	GROUP BY Sno
	HAVING AVG(Grade)>=75 AND MIN(Grade)>=60);