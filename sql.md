# Mysql数据库

## 一、介绍本周内容

> javaee java后台开发的重点 sql语句

* MySQL数据库的基本内容
* MySQL数据库的高级部分 多表查询
* java操作数据库 jdbc Java Database Connection
* xml、json数据格式，进行解析和封装，重点：xml约束(要求读懂)
* web阶段：Javaproject ---> web project ---> html css js + java代码  tomcat服务器  web项目发布到服务器

## 二、数据库介绍

### 1.数据库介绍

> 思考：持久化保存班级学员的信息

数据库：DataBase db 文件后缀名 .db

数据库是一种持久化保存数据的手段，数据库也是真实存在在本地磁盘上 c:/programdata/数据库名（隐藏文件）

数据库保存数据有固定的格式（有格式方便操作）

### 2.数据库管理系统(Mysql)

> DataBase Management System ---> DBMS

用于创建和维护数据库数据的一种软件，这些软件通常使用一种sql语句进行数据库操作

**注意：** 数据库就是一个数据的仓库，数据管理系统是仓库的管理员，学会如何操作数据库管理软件即可，因为操作管理软件使用sql语句。

### 3.数据库的单位

* 库：库里边出储存表
* 表：数据储存的单位，表包含很多行表示一类实体的集合
* 行：行存储在表中，一行代表着一个实体
* 列：列存在行中，代表着一个实体的属性

```java
class Student{
    private String name;
    private int age;
}
Student stu = new Student();
stu.setName("xxx");
stu.setAge(12);
```

#### 存储：

* 创建一个库
* 创建一个表 ---> class Student
* 创建一个行 ---> 实体对象 stu
* 创建一个列 ---> 实体的某一个属性 name

### 4.sql语句介绍以及分类

> SQL：Structure Query Language。（结构化查询语言）
SQL被美国国家标准局（ANSI）确定为关系型数据库语言的美国标准，后来被国际化标准组织（ISO）采纳为关系数据库语言的国际标准。各数据库厂商都支持ISO的SQL标准。普通话各数据库厂商在标准的基础上做了自己的扩展。**方言**

#### sql语句的分类(重点)

> * DDL**（Data Definition Language）：数据定义语言，用来定义数据库对象：库、表、列等； CREATE、 ALTER、DROP
> * DML***（Data Manipulation Language）：数据操作语言，用来定义数据库记录（数据）；    INSERT、 UPDATE、 DELETE
> * DQL***********（Data Query Language）：数据查询语言，用来查询记录（数据）。SELECT
> * DCL（Data Control Language）：数据控制语言，用来定义访问权限和安全级别；

### 5.安装mysql管理软件

* 开启服务
    1. net start mysql 开启服务
    1. net stop mysql 关闭服务

* 使用软件
    1. 登录软件
    > mysql -uroot -p 我的密码：root

## 三、数据库的DDL语言

> DDL数据定义语言，操作库列表的语法类型
> DDL语法涉及三个关键字：CREATE ALTER DROP

### 1.DDL语言中操作数据库的方式

* 创建一个库

```sql
CREATE DATABASE 数据库名称;
```

* 查看库

```sql
SHOW DATABASES;
```

* 切换库

> 你可能有很多的数据库，选中你要修改数据的数据库即可

```sql
USE 数据库名;
```

* 删除数据库

```sql
DROP DATABASE 数据库名称;
```

* 查看当前使用的数据库

```sql
SELECT DATABASE();
```

### 2.DDL语言操作数据库中的表（重点）

* 创建一个表

```sql
CREATE TABLE 表名{
    列名 类型 修饰符,
    列名 类型 修饰符,
    列名 类型 修饰符
};
```

* 介绍一下sql语句中的类型，以及优化
    1. **int**：整型 age int,int类型一列占四个字节
        1. tinyint 整数类型 一列占一个字节 -127~128 ---> 0~256
        1. bigint 整数类型 一列占八个字节 
    1. **double**：浮点型，例如double(5,2)表示最多5位，其中必须有2位小数，即最大值为999.99；
    1. char：固定长度字符串类型;char(10),不满十个字符会用空格填充 最大长度：256
    1. **varchar**：可变长度字符串类型；varchar(10) 'abc'    最大长度：65535
    1. text：字符串类型;
    1. blob：字节类型；
    1. date：日期类型，格式为：yyyy-MM-dd；
    1. time：时间类型，格式为：hh:mm:ss
    1. timestamp：时间戳类型 yyyy-MM-dd hh:mm:ss  会自动赋值
    1. datetime:日期时间类型 yyyy-MM-dd hh:mm:ss
* 操作表
    1. 当前数据库中的所有表 SHOW TABLES;
    1. 查看表的字段信息 DESC 表名;
    1. 修改表名 RENAME TABLE 表的老名称 TO 表的新名称;
    1. 删除表 DROP TABLE 表名;
    1. 查看表格的创建细节 SHOW CREATE TABLE user;

### 3.修改列的信息

* 添加一列 ALTER TABLE 表名 ADD 列名 类型;
* 修改列的类型 ALTER TABLE 表名 MODIFY 列名 类型;
* 删除一列 ALTER TABLE 表名 DROP 列名;
* 修改列名 ALTER TABLE 表名 CHANGE 旧列名 新列名 类型;

## 四、数据库的DML语言

> 数据操作语言INSTER UPDATE DELETE
> 插入数据 修改数据 删除数据

* 插入数据

语法：

```sql
INSERT INTO 表名 (列，列，列) VALUE/VALUES (值，值，值);
-- 注意：字符串类型最好使用单引号'值'
-- 注意：表名后的列的列表应该跟后边的value值一一对应
-- 批量插入：
INSERT INTO 表名 (列) VALUES(值),(值),(值);
-- 不指明列全部插入
INSERT INTO 表名 VALUE/VALUES(全部列值，并且跟创建表的列的顺序一一对应);
-- 弊端：可能忘记差创建表的顺序，建议表名后指定列名
```

* 修改数据

UPDATE

语法：

```sql
UPDATE 表名 SET 列名 = 新值，列名 = 新值;//全部修改
-- 指定条件修改（条件）WHERE
UPDATE 表名 SET 列名 = 值,......WHERE 列名逻辑符 值 AND/OR 列名 逻辑符 值...;
-- 数学运算符
-- 在原有的基础上进行操作
UPDATE 表名 SET 列名 = 列名(当前的值)+-*/值where 条件;
-- 逻辑符：> < >= <= <> !=
```

* 删除数据

DELETE

语法：

```sql
-- 全部删除
DELETE FROM 表名;
-- 条件删除
DELETE FROM 表名 WHERE 列名 逻辑符 值 AND/OR 列名 逻辑符 值;
```

扩展一种删除手段
> TRUNCATE 表名：删除更加彻底，不仅删除数据，还会删除表结构

## 五、数据库的DQL语言

### 1.基本查询

SELECT/第三方框架 query

语法：

```sql
SELECT 列,列,列 / * FROM 表名; -- 开发中不要使用*
```

### 2.条件查询

> 按条件查询想要的数据

SELECT

语法：

```sql
SELECT 列,列,列 / * FROM 表名 WHERE 条件;
```

* =、!=、<>（不等于）、<、<=、>、>=;
* BETWEEN…AND;//指定范围 id BETWEEN 1 AND 3; == >=1 and <=3;
* IN(set);//指定的固定值内 id IN(1,2,3);
* IS NULL; IS NOT NULL 注意;数据库判断空不能使用 =  例子: name = null 错误!  name is null;
* AND;
* OR;
* NOT;

### 3.模糊查询

> 关键字 LIEK

通配符:

* _ 任意一个字符

* %：任意0~n个字符

|name|age|
|:----:|:----:|
|张三||
|三哥||
|三哥的哥哥||

```sql
-- 查询三
select * from 表 where name like '%三%';
-- 三开头
where name like '三%';
-- 第二个是三
where name like '_三%';
```

.**分割线以下学习的关键字不需要添加在where后面**

---

### 4.字段控制

* 去掉重复数据
> DISTINCT

```sql
SELECT DISTINCT 列名 from 表名;
```

* 求和问题
> 想要进行两个列求和 要求列必须是数字类型，否则报错
语法：

```sql
select 列+列（创建一个新的列）,其他的列 from 表名;
```

**问题** ：

  1. 求和碰到null 数字+null=null
  1. 求和创建了一个新的查询列，查询列就叫求和算法名，建议起别名 

* ifnull
> sql语句的函数
语法：

```sql
ifnull(列名,值)
SELECT ename,sal,comm,sal+IFNULL(comm,0) FROM emp;
```

* 给列起别名
> 关键字 as
语法：

```sql
select 列名 as 别名 from 表名;
select 列名 空格 别名 from 表名;
```

### 5.排序

> 关键字 order by 列名 asc(正序)/desc(倒序);
> 排序通常是按照某一列排，还有一些其他情况，可以指定多个列作为排序的条件
**注意：排序order by跟where一个级别，如果单纯的使用排序，无需添加where关键字**

```sql
select * from 表名 order by 列名 asc/desc;
```

练习代码：

```sql
SELECT ename,sal FROM emp ORDER BY sal ASC;
SELECT empno,ename,sal FROM emp ORDER BY sal DESC,empno DESC;
SELECT ename,sal,deptno FROM emp WHERE deptno = 20 ORDER BY sal ASC;
```

.
**注意：order by和where是同一级别，如果两者都需要，where应位于order by的前面，避免不需要的数据参与排序**

### 6.聚合函数

> sum avg count min max
语法：

```sql
-- 聚合函数练习 sum avg count min max

-- 1.最大工资
SELECT MAX(sal) maxsal FROM emp;

-- 2.最小工资
SELECT MIN(sal) minsal FROM emp;

-- 3.平均工资
SELECT AVG(sal) avgsal FROM emp;

-- 4.求所有的工资和
SELECT SUM(sal) sumsal FROM emp;

-- 5.有多少个员工
SELECT COUNT(*) ecount FROM emp;
```

注意：

* sum求和自动将null转为0
* count计数不会将null算作条数据，所以要用*，而不是某一列名

### 7.分组查询

> 关键字 group by 列; 分组查询和where还有order by 是同一级别

having语法：

```sql
select * from 表名 group by 列名 having （通常为聚合函数）
```

练习代码：

```sql
-- 分组查询练习 group by 

-- 查询20号部门的工资和
SELECT SUM(sal) FROM emp WHERE deptno = 20;

-- 查询每一个部门的工资和
-- 分组查询要查询出的字段 1.聚合函数 2.分组字段 其他字段无意义
SELECT deptno,SUM(sal) FROM emp GROUP BY deptno;

-- 部门人数和部门编号
SELECT deptno,COUNT(*) FROM emp GROUP BY deptno;

-- 查询每组的人数 要求工资大于1500
-- where 碰到其他同级别的关键字 都应该在前面
SELECT deptno,COUNT(*) ct FROM emp WHERE sal > 1500 GROUP BY deptno;

-- 查询工资总和大于9000的部门编号以及工资和
-- having 条件 事后条件

SELECT deptno,SUM(sal) FROM emp GROUP BY deptno HAVING SUM(sal) > 9000;

-- 引用别名
SELECT deptno,SUM(sal) ss FROM emp GROUP BY deptno HAVING ss > 9000;

-- 查询部门编号和人数，工资低于一千的不统计，最后工资和低于八千的不统计
SELECT deptno,COUNT(*),SUM(sal) FROM emp WHERE sal>1000 GROUP BY deptno HAVING SUM(sal)>8000;
```

.**总结：分组查询通常配合聚合函数，分组查询的列通常有分组的列和聚合函数，having是分组后的条件，having的条件通常也是聚合函数**

where和having的区别：

* where分组之前的条件，可以配合任意的关键字使用
* having分组后的条件，只配和group by后出现
* having条件通常使用聚合函数

### 8.group by 和 order by 同时出现

> group by在order by的前面，因为这时的排序的不是一条数据，按组排序

```sql
-- 查询工资高于9000的部门，按倒序
SELECT deptno,SUM(sal) FROM emp GROUP BY deptno HAVING SUM(sal)>9000 ORDER BY SUM(sal) DESC;
```

### 9.limit分页查询

> limit是方言，级别同样跟where同级别

作用：截取数据的一部分

语法：

```sql
select * from 表名 limit num;-- 查询几条数据start 0 ---> end num
select * from 表名 limit start,num;-- 从那开始查几条数据
```

分页公式：

```sql
-- currentPage 当前页
-- pageSize 每页的数量
limit (currentPage-1)*pageSize,pageSize;
```

.**注意：如果页数不足，limit会自动将页数全部显示**

### 10.总结

> 查询关键字
> select - from 表名 -where-limit-order by-group by having-like-as

顺序问题：

```sql
select */列名 as 别名 from 表名 where 列名 >= like and or group by 列名 having order by 列名 asc/desc limit 1,2;
```

## 六、约束以及数据完整性

> 约束不是必须的但是是很有必要的

**作用：** 保证用户输入或者修改后数据的正确性
> 例：用户名不能为null，约束某一个字段不能重复

### 1.实体完整性约束

> 约束一行数据
**实体：** 就是一个事物的的代表，对应数据库的一行的数据

* 主键约束（primary key）
> 确保每一行的数据不重复
**使用：** 给表创建一列，这一列没有真正的含义，就是为了做主键，确保数据不重复，列名通常叫id，添加primary key修饰的是主键
**主键分类：**

1. 自然主键：实体本身就存在的属性，有唯一的特点，可以作为主键使用列
1. 代理主键：创建一个无意义的列，单纯的用来做主键，推荐使用代理主键

**特点：** 使用primary key修饰的列，不能为null且不重复

语法：

```sql
-- 第一种：创建表的时候直接添加
create table 表名(
    id int primary key
);
-- 第二种：创建表的时候添加（联合主键）
create table 表名(
    id int,
    name varchar(20),
    primary key(id)
);
CREATE TABLE 表名(
    stuid int,
    classid int,
    name varchar(20),
    primary key(stuid,classid)
);
-- 第三种：创建完表以后修改
ALTER TABLE 表名 ADD PRIMARY KEY(列);
```

* 唯一约束 unique
> 特点：数据不重复，但是可以为null

语法：

```sql
name varchar(20) unique
```

* 主键自增长（auto_increment）

**要求：** 主键类型必须是数字
语法：

```sql
id int primary key auto_increment
```

**注意：** 主键自增长就相当于把主键交与数据库软件进行维护，所以在插入数据的时候，不需要添加主键这一列
语法：

```sql
-- 主键自增长
CREATE TABLE stu6(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(10)
);

INSERT INTO stu6 (NAME) VALUES('asddd');
```

### 2.域（列）完整性

* 列类型约束 varchar int
* 非空约束 not null
    语法：
    ```sql
    name varchar(20) unique not null
    -- primary key = unique + not null
    ```
* 默认值约束 default
    语法：
    ```sql
    sex varchar(20) default '男'
    insert into 信息(sex) value (default)

    -- 域约束

    CREATE TABLE stu7(
        NAME VARCHAR(20) NOT NULL,
        sex VARCHAR(4) DEFAULT '男'
    );

    INSERT INTO stu7 VALUES('xx',DEFAULT);
    ```

### 3.参照引用完整性约束(多表)

> 一个表的某一列需要参照其他的列，参照引用约束，如果不添加约束，可以随便写

添加方式：

1. 直接在外键表中添加

语法：

```sql
create table book(
    bid int primary key auto_increment,
    bname varchar(20) not null,
    cid int,-- cid 外检，指定类别，cid应该是参照类别表的主键
    constraint 约束名称(不能重复) foreign key(cid) reference 主表的名称(cid(主键))
);
-- 外部添加
alert table 子表 add constraint 约束名称 foreign key(外键) preference 主表(主键);
```

**注意：** 外键的名称尽量跟主表的主键一致，类型必须一致

**总结：** 约束只限制插入修改和删除，不限制查询

## 七、表关系

> 通过分析表与表之间的关系，添加正确的主外键约束

1. 一对一

外键是子表的主键
也有主外键的关系，也有主子表的关系
外键是子表的主键
一对一关系通常进行合表

练习代码：

```sql
-- 一对一
-- 主表
CREATE TABLE qq(
    qq INT PRIMARY KEY,
    qqname VARCHAR(100) NOT NULL
);
-- 子表
CREATE TABLE qqinfo(
    qq INT PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    CONSTRAINT fk_i_q FOREIGN KEY (qq) REFERENCES qq(qq)
);
```

1. 一对多

一对多或者多对一肯定有主外键关系
一对多或者多对一肯定包含主子表关系
先创建主表，再创建子表
添加主外键约束（参照或者引用约束）

练习代码：

```sql
-- 一对多 多对一 主子表 主外键
CREATE TABLE stu8(
    sid INT PRIMARY KEY,
    sname VARCHAR(20) NOT NULL
);

CREATE TABLE score(
    cid INT PRIMARY KEY,
    score DOUBLE(5,2),
    sid INT
);

ALTER TABLE score ADD CONSTRAINT fk_s_s FOREIGN KEY (sid) REFERENCES stu8(sid);
```

1. 多对多

多对多没有主子表之分
创建一个中间表
创建中间表必须包含两个主表的外键

练习代码:

```sql
-- 多对多需要自己创建一个中间表，中间表应该包含两个主表的外键

CREATE TABLE stu9(
    sid INT PRIMARY KEY AUTO_INCREMENT,
    sname VARCHAR(20) NOT NULL
);

CREATE TABLE teh(
    tid INT PRIMARY KEY AUTO_INCREMENT,
    tname VARCHAR(20) NOT NULL
);

-- 创建中间表

CREATE TABLE center(
    cid INT PRIMARY KEY AUTO_INCREMENT,
    sid INT,
    tid INT
);

ALTER TABLE center ADD CONSTRAINT fk_s_c FOREIGN KEY (sid) REFERENCES stu9(sid);
ALTER TABLE center ADD CONSTRAINT fk_t_c FOREIGN KEY (tid) REFERENCES teh(tid);

```

## 八、多表查询

### 1. 多表查询的方法

* 合并结果集（纵向合并）
    union、union all
* 连接查询（横向合并）（重点）
    1. 内连接查询 [inner] join on
    1. 外连接查询
        1. 右外连接 left[outer] join on
        1. 左外连接 right[outer] join on
    1. 99查询法
    1. 全连接（mysql不支持）full join
    1. 自然连接
        1. 自然内连接 natural join
        1. 自然左外连接 natural left join
        1. 自然右外连接 natural right join
* 子查询（重点）

### 2.合并结果集

> 关键字 union、union all，合并结果集是将多个select的查询结果垂直的拼接到一起。要求：拼接的结果的列数相同，列的命名最好相同

* union：去掉重复数据
* union all：不去掉重复数据

### 3.连接查询

> 连接查询横向拼接，连接查询的多表必须有关系（主外键关系），连接查询会出现笛卡尔积错误，将数据都进行组合不进行筛选

* 99查询法 
> 99查询法是mysql的一个方言

```sql
select * from 表1，表2;
-- 有笛卡尔积错误
-- 解决笛卡尔积
select * from 表1,表2 where 表1.主键 = 表2.外键;
-- 给表起别名
select a.xx,b.xxx from 表1 a(别名),表2 b(别名) where a.主键 = b.外键;
```

* 内连接

语法：

```sql
表1 别名 [inner] join 表2 别名 on 表1.主键 = 表2.外键;
-- inner可以省略
```

练习代码：

```sql
SELECT * FROM student s INNER JOIN score c ON s.stuid = c.stuid;
```

* 外连接
> 外连接跟内连接还有99查询法的区别

语法:
表1 别名 left/right [outer] jion 表2 别名 on 主 = 外;

练习代码：

```sql
-- 外连接 left/right [outer] join on

SELECT * FROM student s LEFT JOIN score c ON s.stuid = c.stuid;

SELECT * FROM student s RIGHT JOIN score c ON s.stuid = c.stuid;
```

**总结：** 外连接跟内连接和99查询法的区别

    * 99查询法和内连接理论上是公平的，严格按照主外键相等进行数据查询
    * 外连接理论上是不公平的，可以通过方向（left/right）指明一个主表，就算子表中没有外键，也会将主表的数据全部查出

* 自然连接

语法：

select * from 表1 natural join 表2;自然内连接

select * from 表1 natural left join 表2;自然左外连接

select * from 表1 natural right join 表2;自然右外连接

作用：会自动匹配主外键相等

要求：要求主外键的命名和类型相同

练习代码：

```sql
-- 自然连接

-- 自然内连接

SELECT * FROM student s NATURAL JOIN score c

-- 自然外连接

SELECT * FROM student s NATURAL LEFT JOIN score c
```

* n张表怎样查询

使用了外连接，所有的外连接的方向应该一致

多张表查询牢牢抓住主外键

多表查询先将两个表连接，再去连接下一张表

多表查询记得起别名

## 九、子查询

 一个select语句中包含另一个完整的select语句。

子查询就是嵌套查询，即SELECT中包含SELECT，如果一条语句中存在两个，或两个以上SELECT，那么就是子查询语句了。

* 子查询出现的位置
  where后，作为条件被查询的一条件的一部分；
  from后，作表；必须起别名！
* 子查询结果集的形式
  * 单行单列（用于条件） >  <
  * 单行多列（用于条件）in
  * 多行单列（用于条件）any  all
  * 多行多列（用于表）

例子：select * from student where 身高 , sex  in (select  max(身高) ,sex from student)
例子：查询男生的信息，高于所有女生身高的！

```sql
select * from student where sex = nan and height > all(select height from  student where sex = 女);

select * from student where sex = nan and height > (select max(height) from student where sex = nv)

select * from student where sex = nan and height > any (select height from student where sex = '女');

select * from student where sex = nan and height > (select mi(height) from student where sex = '女')

select * from student where sex = "nv"  and  heigth = 150;

select * from (select * from student where sex = "nv" ) bieming where height = 150 ;
```

## 十、数据库备份

