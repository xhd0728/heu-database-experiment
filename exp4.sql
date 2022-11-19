# 实验四 利用SQL语句完成视图设计

# 建立学生视图
CREATE VIEW StudentV
AS
SELECT Sno, Sname, Sage, Sdept
FROM Student;

# 建立课程视图
CREATE VIEW CourseV
AS
SELECT Cno, Cname, Cpno, Ccredit
FROM Course;

# 建立学生选课视图
CREATE VIEW SCV
AS
SELECT Sno, Cno, Grade
FROM SC;

# 实验题目1
# 使用group by语句对课程进行分组
# 使用avg函数计算每门课程的平均分
# 使用>=ALL条件查询平均分最高的课程
SELECT *
FROM CourseV
WHERE CourseV.Cno IN
	(SELECT SCV.Cno
	FROM SCV
	GROUP BY SCV.Cno
	HAVING AVG(SCV.Grade)>=ALL(
		SELECT AVG(SCV.Grade) 
		FROM SCV 
		GROUP BY SCV.Cno)
	);

# 实验题目2
# 首先查询出平均分最高的课程信息
# 从其他视图中查询出选课信息
SELECT StudentV.Sno, Sname, Cname, Grade
FROM StudentV, SCV, CourseV
WHERE 
	StudentV.Sno=SCV.Sno AND 
	CourseV.Cno=SCV.Cno AND 
	CourseV.Cno IN
		(SELECT Cno
		FROM CourseV
		WHERE CourseV.Cno IN
			(SELECT SCV.Cno
			FROM SCV
			GROUP BY SCV.Cno
			HAVING AVG(SCV.Grade)>=ALL(
				SELECT AVG(SCV.Grade) 
				FROM SCV 
				GROUP BY SCV.Cno)
			)
		);

# 实验题目3
# 首先根据学号分组，查询平均分最高的学生学号
# 再从StudentV视图中得到该学生所在的院系
SELECT StudentV.Sdept
FROM StudentV
WHERE StudentV.Sno IN
	(SELECT Sno
	FROM SCV
	GROUP BY Sno
	HAVING AVG(Grade)>=ALL(
		SELECT AVG(Grade) 
		FROM SCV 
		GROUP BY Sno)
	);