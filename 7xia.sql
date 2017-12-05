USE day07;
-- 练习添加主键
CREATE TABLE stu1(
  id INT PRIMARY KEY ,
  NAME VARCHAR(20))

stu1
INSERT INTO stu1 VALUE(NULL,'xx');


CREATE TABLE stu2(
   stuid INT ,
   classid INT,
   NAME VARCHAR(20),
   PRIMARY KEY(stuid,classid))

CREATE TABLE stu3(  
   idcard VARCHAR(18) 
   NAME VARCHAR(20)
)

ALTER TABLE stu3 ADD PRIMARY KEY(id);

SELECT * FROM emp;

-- unique唯一约束练习
CREATE TABLE stu5(
   id INT PRIMARY KEY,
   NAME VARCHAR(20) UNIQUE)

INSERT INTO stu5 VALUES(1,'aa'),(2,'bb');

UPDATE stu5 SET NAME = 'aa' WHERE id = 4；


-- 主键自增长练习
CREATE TABLE stu6(
   id BIGINT PRIMARY KEY AUTO_INCREMENT,
   NAME VARCHAR(10))

INSERT INTO stu6 VALUE(6,'xx');

INSERT INTO stu6 (NAME) VALUE('aaa');

-- 域约束

CREATE TABLE  stu7(
   NAME VARCHAR(20) NOT NULL,
   sex VARCHAR(4) DEFAULT '男')

INSERT INTO stu7 VALUE(NULL,DEFAULT);


-- 重点练习主外键约束

CREATE TABLE category(
   cid INT PRIMARY KEY AUTO_INCREMENT,
   cname VARCHAR(20) UNIQUE NOT NULL);

-- 图书表
CREATE TABLE book(
   bid INT PRIMARY KEY AUTO_INCREMENT,
   bname VARCHAR(20) NOT NULL,
   xid INT )
   
 
-- 外部添加
 
ALTER TABLE book ADD CONSTRAINT fk_b_c FOREIGN KEY(xid) 
REFERENCES category(cid);
 
  
  
TRUNCATE category;  

UPDATE book SET xid = 3 WHERE bid = 1;
DELETE FROM book;
DELETE FROM category;


DML 
DDL

DROP TABLE category;

DQL 
SELECT 


-- 表关系练习

-- 一对一
-- 一对一有主子表之分 子表的外键又是主键

-- 主表
CREATE TABLE qq(
   qq INT PRIMARY KEY,
   qqname VARCHAR(100) NOT NULL);

-- 子表 qq详情
CREATE TABLE qqinfo(
   qq INT PRIMARY KEY,
   address VARCHAR(50) NOT NULL,
   CONSTRAINT fk_i_q FOREIGN KEY (qq) REFERENCES qq(qq))


-- 一对多 多对一 主子表之分！主外键约束
CREATE TABLE stu8(
  sid INT PRIMARY KEY,
  sname VARCHAR(20) NOT NULL);

CREATE TABLE score(
  cid INT PRIMARY KEY,
  score DOUBLE(5,2),
  sid INT)

ALTER TABLE score ADD CONSTRAINT fk_s_s FOREIGN KEY (sid)
REFERENCES stu8(sid);

-- 多对多主要自己创建一个中间表！中间表应该包含两个主表的外键

CREATE TABLE stu9(
  sid INT PRIMARY KEY AUTO_INCREMENT,
  sname VARCHAR(20) NOT NULL);

CREATE TABLE teh(
  tid INT PRIMARY KEY AUTO_INCREMENT,
  tname VARCHAR(20) NOT NULL);

-- 创建一个中间表
CREATE TABLE center(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  sid INT,
  tid INT)

ALTER TABLE center ADD CONSTRAINT fk_s_c FOREIGN KEY(sid)
REFERENCES stu9(sid);

ALTER TABLE center ADD CONSTRAINT fk_t_c FOREIGN KEY(tid)
REFERENCES  teh(tid);










