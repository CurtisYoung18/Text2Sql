# 学生成绩数据库测试数据集

这个数据集专门为测试text2sql agent而设计，包含了丰富的学生成绩数据，可以用于验证agent的SQL生成和执行能力。

### Agent Demo 链接：https://udify.app/chat/4AP6kVeEusD9RFUC

## 文件说明

- `student_scores_test_data.sql` - 完整的数据库建表和数据插入脚本
- `test_queries_examples.sql` - 各种测试查询示例
- `README.md` - 使用说明文档

## 数据库结构

### 表名：student_scores（学生成绩信息表）

| 字段名 | 类型 | 说明 |
|--------|------|------|
| id | INT | 主键，自增 |
| student_id | VARCHAR(20) | 学号 |
| student_name | VARCHAR(50) | 学生姓名 |
| class_name | VARCHAR(30) | 班级 |
| subject | VARCHAR(30) | 科目 |
| score | DECIMAL(5,2) | 分数 |
| exam_date | DATE | 考试日期 |
| semester | VARCHAR(20) | 学期 |
| grade | VARCHAR(20) | 年级 |
| created_at | TIMESTAMP | 记录创建时间 |
| updated_at | TIMESTAMP | 记录更新时间 |

## 数据特点

### 数据规模
- **总记录数**: 约200条
- **学生数量**: 20名学生
- **科目数量**: 5个科目（数学、语文、英语、物理、化学）
- **年级数量**: 3个年级（高一、高二、高三）
- **学期数量**: 2个学期（2023秋季、2024春季）

### 数据分布
- **成绩范围**: 48.5 - 99.5分
- **班级分布**: 高一(1)班、高一(2)班、高一(3)班、高二(1)班、高二(2)班、高二(3)班、高三(1)班、高三(2)班、高三(3)班
- **成绩分布**: 包含优秀、良好、及格、不及格等各种成绩水平

## 使用方法

### 1. 导入数据库

```bash
# 连接到MySQL数据库
mysql -u username -p database_name

# 执行SQL脚本
source student_scores_test_data.sql
```

### 2. 验证数据导入

执行脚本末尾的验证查询，确认数据正确导入：

```sql
SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT student_id) as unique_students,
    COUNT(DISTINCT subject) as subjects,
    COUNT(DISTINCT semester) as semesters,
    COUNT(DISTINCT grade) as grades
FROM student_scores;
```

### 3. 测试text2sql agent

使用以下类型的问题来测试你的agent：

#### 基础统计查询
- "统计全校各科目平均分"
- "查询各科目及格率"
- "统计各班级平均分排名"

#### 个人成绩查询
- "查询张三的所有科目成绩"
- "查询李四的数学成绩"
- "查询成绩优秀的学生（90分以上）"

#### 对比分析查询
- "比较2024春季和2023秋季的成绩变化"
- "各年级各科目平均分对比"
- "查询成绩进步最大的学生"

#### 复杂统计查询
- "统计各班级各科目的及格率和优秀率"
- "分析各科目的难度（平均分和标准差）"
- "查询学生综合成绩排名"

#### 条件筛选查询
- "查询不及格的学生"
- "查询高一(1)班的学生成绩"
- "查询物理成绩前5名的学生"

## 测试场景

### 1. 基础SQL生成能力
- 简单的SELECT查询
- WHERE条件筛选
- GROUP BY聚合
- ORDER BY排序

### 2. 复杂SQL生成能力
- JOIN连接查询
- 子查询
- CASE WHEN条件判断
- 窗口函数（如需要）

### 3. 数据分析能力
- 统计计算（平均值、计数、百分比等）
- 数据分布分析
- 趋势分析
- 排名分析

### 4. 错误处理能力
- 不存在的表名或字段名
- 语法错误
- 逻辑错误

## 预期结果示例

### 问题："查询各科目成绩优秀的学生（90分以上）"

**预期SQL:**
```sql
SELECT student_name, subject, score, class_name, grade
FROM student_scores 
WHERE score >= 90 
ORDER BY subject, score DESC;
```

**预期结果:**
<img width="1034" height="916" alt="supabase" src="https://github.com/user-attachments/assets/ac597caa-5aa1-4758-9695-9d5c0b4f2c03" />

**Agent 结果:**
<img width="764" height="756" alt="text2sql" src="https://github.com/user-attachments/assets/9ecde960-88e7-4b59-895d-ddd146bb8060" />


## 注意事项

1. **数据一致性**: 所有数据都是虚构的，仅用于测试目的
2. **性能考虑**: 数据量适中，适合快速测试
3. **索引优化**: 已为常用查询字段添加索引
4. **字符编码**: 使用utf8mb4编码，支持中文字符


