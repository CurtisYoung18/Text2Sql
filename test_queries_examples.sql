-- 测试查询示例 - 用于验证text2sql agent的生成能力

-- 1. 基础统计查询
-- 统计全校各科目平均分
SELECT subject, ROUND(AVG(score), 2) AS avg_score 
FROM student_scores 
GROUP BY subject 
ORDER BY avg_score DESC;

-- 2. 及格率统计
-- 统计各科目及格率
SELECT subject, 
       ROUND(COUNT(CASE WHEN score >= 60 THEN 1 END) * 100.0 / COUNT(*), 2) as pass_rate 
FROM student_scores 
GROUP BY subject 
ORDER BY pass_rate DESC;

-- 3. 成绩分布统计
-- 统计各科目成绩分布
SELECT subject, 
       COUNT(CASE WHEN score >= 90 THEN 1 END) as excellent,
       COUNT(CASE WHEN score >= 75 AND score < 90 THEN 1 END) as good,
       COUNT(CASE WHEN score >= 60 AND score < 75 THEN 1 END) as pass,
       COUNT(CASE WHEN score < 60 THEN 1 END) as fail 
FROM student_scores 
GROUP BY subject;

-- 4. 班级排名查询
-- 查询各班级平均分排名
SELECT class_name, 
       ROUND(AVG(score), 2) as avg_score,
       COUNT(DISTINCT student_id) as student_count
FROM student_scores 
GROUP BY class_name 
ORDER BY avg_score DESC;

-- 5. 学生个人成绩查询
-- 查询特定学生的所有科目成绩
SELECT student_name, subject, score, class_name, semester
FROM student_scores 
WHERE student_name = '张三' 
ORDER BY score DESC;

-- 6. 年级对比查询
-- 各年级各科目平均分对比
SELECT grade, subject, ROUND(AVG(score), 2) as avg_score
FROM student_scores 
GROUP BY grade, subject 
ORDER BY grade, avg_score DESC;

-- 7. 学期对比查询
-- 同一学生不同学期成绩对比
SELECT s1.student_name, s1.subject, 
       s1.score as spring_score, s2.score as fall_score,
       ROUND(s1.score - s2.score, 2) as score_diff
FROM student_scores s1
JOIN student_scores s2 ON s1.student_id = s2.student_id 
    AND s1.subject = s2.subject
WHERE s1.semester = '2024春季' AND s2.semester = '2023秋季'
ORDER BY s1.student_name, score_diff DESC;

-- 8. 优秀学生查询
-- 查询各科目成绩优秀的学生（90分以上）
SELECT student_name, subject, score, class_name, grade
FROM student_scores 
WHERE score >= 90 
ORDER BY subject, score DESC;

-- 9. 需要补考的学生查询
-- 查询各科目不及格的学生
SELECT student_name, subject, score, class_name, grade
FROM student_scores 
WHERE score < 60 
ORDER BY subject, score;

-- 10. 复杂统计查询
-- 统计各班级各科目的及格率、优秀率
SELECT class_name, subject,
       COUNT(*) as total_students,
       ROUND(COUNT(CASE WHEN score >= 60 THEN 1 END) * 100.0 / COUNT(*), 2) as pass_rate,
       ROUND(COUNT(CASE WHEN score >= 90 THEN 1 END) * 100.0 / COUNT(*), 2) as excellent_rate
FROM student_scores 
GROUP BY class_name, subject 
ORDER BY class_name, pass_rate DESC;

-- 11. 成绩进步查询
-- 查询成绩进步最大的学生
SELECT s1.student_name, s1.subject,
       s1.score as spring_score, s2.score as fall_score,
       ROUND(s1.score - s2.score, 2) as improvement
FROM student_scores s1
JOIN student_scores s2 ON s1.student_id = s2.student_id 
    AND s1.subject = s2.subject
WHERE s1.semester = '2024春季' AND s2.semester = '2023秋季'
    AND s1.score > s2.score
ORDER BY improvement DESC;

-- 12. 综合排名查询
-- 查询学生综合成绩排名（所有科目平均分）
SELECT student_name, class_name, grade,
       ROUND(AVG(score), 2) as avg_score,
       COUNT(subject) as subject_count
FROM student_scores 
GROUP BY student_id, student_name, class_name, grade
ORDER BY avg_score DESC;

-- 13. 科目难度分析
-- 分析各科目的难度（通过平均分和标准差）
SELECT subject,
       ROUND(AVG(score), 2) as avg_score,
       ROUND(STDDEV(score), 2) as std_dev,
       COUNT(*) as student_count
FROM student_scores 
GROUP BY subject 
ORDER BY avg_score;

-- 14. 班级成绩分布
-- 各班级成绩分布情况
SELECT class_name,
       ROUND(AVG(score), 2) as avg_score,
       MIN(score) as min_score,
       MAX(score) as max_score,
       COUNT(DISTINCT student_id) as student_count
FROM student_scores 
GROUP BY class_name 
ORDER BY avg_score DESC;

-- 15. 学期成绩趋势
-- 分析学期间成绩变化趋势
SELECT semester, subject,
       ROUND(AVG(score), 2) as avg_score,
       COUNT(*) as student_count
FROM student_scores 
GROUP BY semester, subject 
ORDER BY semester, avg_score DESC; 