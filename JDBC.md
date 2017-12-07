###第二阶段第八天JDBC

#### 一. JDBC介绍

​       JDBC: Java DataBase Connectivity JDBC Sun公司提供的一套数据库操作规范！JDBC与各个数据库厂商的关系：接口和实现的关系



* JDBC涉及的核心类和接口
  * DriverManager 
  * Driver 
  * Connection
  * Statement
  * ResultSet



#### 二. 基本实现步骤

1. 导入驱动

   将对应数据库的jar包,拷贝到项目中！

2. 注册驱动

   > 注意： 驱动导的jar包应该是数据库厂商的路径

   DriverManager.registerDriver(new Driver());

3. 获取连接

   > Connection java.sql

​       Connection connection = DriverManager.getConnection(url,username,password);

​       参数介绍： url -> jdbc:mysql://localhost:3306/数据库名称

​			   username: 用户名

​       		           password: 密码

4. 创建执行sql语句的statement

   > statement 也要导入 java.sql

   Statement statement = connection.createStatement();

5. statement执行sql语句

   int num = statement.executeUpdate(sql) ; // DDL DML

   ResultSet result = statement.executeQuery(sql); //DQL

6. 解析结果集

   > resultSet 对象就是一张表的对象，内有一个光标指向行！默认光标没有指向数据行！
   >
   > 需要将向下移动 调用next() 方法！

​        whie(resultset.next())

​        {

​		//获取一行的数据

​		String 数据 = result.getString(下角标1开始/列名);

​        }



7. 关闭资源

   resultset.close();

   statement.close();

   connection.close();



实现代码：

```java

//1.导入驱动
//2.注册驱动DriverManager
//registerDriver(java.sql.Driver driver)
//com.mysql.jdbc.Driver()
DriverManager.registerDriver(new Driver());
//public class com.mysql.jdbc.Driver implements java.sql.Driver
		
//3.创建一个连接
//param1： url 
//jdbc:mysql://localhost:3306/数据库名称
//http://www.baidu.com:80
//file:///
//content://
//tcp://
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/day08", "root", "111");
		
//4.创建一个执行sql语句的statement
		
Statement statement = connection.createStatement();
		
		
//5.小车拉着sql语句去数据库
//statement.executeUpdate(sql)  DML DDL 
ResultSet resultSet = statement.executeQuery("select * from emp");
		
//6.处理结果集
//resultset - list<实体> -map
		
while(resultSet.next()){
	//获取当行的列
	String id = resultSet.getString(1); //根据列的下标
	String ename = resultSet.getString("ename"); //根据列名
	System.out.println(id+"-->"+ename);
}
		
//7.关闭资源
resultSet.close();
statement.close();
connection.close();
```



#### 三. 核心接口的详细API讲解

 ##### 1. DriverManager 

> 注册驱动！获取连接！

* 注册驱动

  ```java
  static registerDriver(Driver driver)
  ```

  问题以及解决方案：

  使用注册方法会注册两次！

  解决方案：

  ```java
   Class.forName("com.mysql.jdbc.Driver"); //触发静态代码块 执行一次！
  ```

* 获取连接

  | `static Connection` | `getConnection(String url)`           试图建立到给定数据库 URL 的连接。 |
  | ------------------- | ---------------------------------------- |
  | `static Connection` | `getConnection(String url, Properties info)`           试图建立到给定数据库 URL 的连接。 |
  | `static Connection` | `getConnection(String url, String user, String password)`           试图建立到给定数据库 URL 的连接。 |

​       url编写方式： jdbc:mysql://localhost:3306/数据库名

​       info - 作为连接参数的任意字符串标记/值对的列表；通常至少应该包括 "user" 和 "password"

      ```java
     Properties info = new Properties();
	 //放入用户名和密码
	 //key user password
	 info.setProperty("user", "root");
	 info.setProperty("password", "111");
	 DriverManager.getConnection(url, info);
      ```

​    一个参数：

```java
//一个参数 也要用户名密码还有url
//拼接到路径的后面 
//http协议的get方式请求
//参数追加到路径后面
url = url + "?user=root&password=111";
Connection connection =  DriverManager.getConnection(url);
```



##### 2. Connection接口

> 与特定数据库的连接（会话）。在连接上下文中执行 SQL 语句并返回结果。

主要：创建Statement执行sql语句

```java

Statement statement = connection.createStatement(); //DML INSERT UPDATE DELETE 

PreparedStatement statement =connection.preparedStatement(String sql); //DQL 防止注入攻击！

connection.close(); //释放当前connection资源！ 使用完毕以后要进行释放！
```



##### 3. Statement接口

> 用于执行静态 SQL 语句并返回它所生成结果的对象。

```sql
 boolean execute(String sql) 
          执行给定的 SQL 语句，该语句可能返回多个结果。 
 介绍：sql对应类型： DDL DML DCL DQL 
       ture: DQL 
       false:DDL DML DCL
 
 使用情景： 执行sql语句，不需要返回结果!
 
 
 int executeUpdate(String sql)
 介绍： sql对应类型： DDL DML DCL
 	   int 行级数（影响的行数）：DML  
 	   	    0：DDL DCL
 使用情景： DML 
 
 ResultSet executeQuery(String sql)
 介绍： sql语句对应类型： DQL
        resultset: 他就是一张虚拟的表！表中有游标，默认执行的是数据之前的位置！
        resultset对象永远不为null!但是不见其一定有数据！
 
 
 statement.close(); //进行关闭
```



##### 4. ResultSet接口 

> 表示数据库结果集的数据表，通常通过执行查询数据库的语句生成

* ResultSet游标

​       学习游标操作只需要会next方法即可！如果碰到了next解决不了的问题，那么你的sql语句就有问题了！

        ```java
  absolute(int row)  将光标移动到绝对行！ 起始行从1 开始！
  
  relative(int rows) 相对于当前位置移动 + - 方向！
  
  boolean previous() 向上移动一行！
  
  boolean next() 向下移动一行！
  
  true: 有下一行的时候！返回true,将光标向下移动一行！
  false: 没有下一行！

        ```

* ResultSet获取行的数据

  ```java

  getXX(index,列名); index从1开始！

  getString();
  getInt(); --> 表的声明类型！
  getLong();


  create table xx(
    id Bigint,
    name varchar(10),
    height double(4,1),
    bir  date
  )

  class Xx{
    private  Long  id;   //默认 int = 0 / Integer = null
    private  String name;
    private Double height;
    private Date(java.util.Date) bir;
    private String bir;
    private String height;
  }

  验证：如果查询起了别名！使用别名还是列名？？？？

  重点： 如果使用的* 获取列的数据时候！使用创建表的列名！
        如果查询给列起了别名！获取列数据时候应该使用别名！
  ```



#### 四. 基于JDBC的CRUD练习！JBDC工具类编写出来

##### 1. CRUD练习

```java
@Test
	public void testInsert() throws Exception{
	 //TODO 进行插入练习
	 //1 注册驱动
     Class.forName("com.mysql.jdbc.Driver");		
	 
     //2.创建连接
     //java.sql
     Connection connection =
     DriverManager.getConnection("jdbc:mysql://localhost:3306/day08",
    		 "root", "111");
	 
     //3.获取Statement对象！
     Statement statement = connection.createStatement();
     
     //4.执行sql语句
     String sql = "insert into a (id,name) value(10,'java插入的数据！')";
     
     int num =  statement.executeUpdate(sql);
     
     System.out.println("插入："+num);
     
     //关闭资源
     statement.close();
     connection.close();
	}
	
	@Test
	public void testDelete() throws Exception{
	   //TODO 删除
		//1.注册驱动
		Class.forName("com.mysql.jdbc.Driver");
		
		//2.获取连接
		Connection connection =
		DriverManager.getConnection("jdbc:mysql://localhost:3306/day08",
				"root", "111");
	 
		//3.statement
		Statement statement = connection.createStatement();
		
		//4.执行SQL语句
		//delete -- dml  -- executeUpdate
		
		String sql = "delete from a";
		
		int num = statement.executeUpdate(sql);
		
		System.out.println(num);
		
		//5.关闭资源
		statement.close();
		connection.close();
	}
	
	@Test
	public void testUpdate() throws Exception{
	 //TODO 修改	
		Connection connection = JDBCUtils.getConnection();
		
		Statement statement = connection.createStatement();
		
		int num = statement.executeUpdate("update emp set ename = '张三'");
		
		System.out.println("修改了："+num);
		
		JDBCUtils.close(statement, connection);
	}
	
	
	@Test
	public  void testSelect() throws Exception{
	 //TODO 查询
     //注入攻击
		//1.
		Connection connection = JDBCUtils.getConnection();
		//2. 获取statement
		Statement statement = connection.createStatement();
		System.out.println("请输入要查询的名字！");
		//输入要查询的名字
		Scanner scanner = new Scanner(System.in);
		
		String name = scanner.nextLine();
		
		scanner.close();
		
		String sql = "select empno as eno from emp where ename = '"+name+"';";
		
		ResultSet resultSet = statement.executeQuery(sql);
		
		
		while(resultSet.next()){
			//行  获取类
			System.out.println(resultSet.getString("eno"));
		}
		
		//释放资源
		JDBCUtils.close(resultSet, statement, connection);
		
	}
```





##### 2.工具类封装

```java
package com.itqf.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;


/**
 * 工具类工具类工具类    工具  -- 类
 * 
 * 工具类没有逻辑的概念 不需要强加逻辑！
 * 写工具类不要嫌麻烦！
 * 
 * 目的：简化jdbc操作
 * 解决的问题：
 * 			  1.重复注册问题
 * 	 		  2.获取连接每次都要输入大量的参数
 * 			  3.关闭资源
 * 
 * 分析对应的方案：
 * 			  1.注册一次  static代码块！单例模式
 * 			  2.编写静态常量！创建一个静态方法 返回连接！
 * 			  3.解决非空判断 方法重载
 */
public class JDBCUtils {
	
   private static String driver;
   private static String url;
   private static String user;
   private static String password;
	
   static{
	//TODO jdbc.properties加载进来   
	//ResourceBundle key value数据保存手段！
	//利用静态方法getBundle可以从src下 加载properties文件！
	//param:baseName 就是文件的名字   
	//注意：文件必须在src 文件名 不需要加后缀名   
	ResourceBundle bundle =
			ResourceBundle.getBundle(Constants.PROFILENAME);
	driver = bundle.getString(Constants.DRIVER);
	url = bundle.getString(Constants.URL);		
	user = bundle.getString(Constants.USER);
	password = bundle.getString(Constants.PASSWORD);
	
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
   }
	
   /**
    * 获取连接的方法
    * @return 连接
    */
   public static Connection getConnection(){
	   
	   try {
		  return DriverManager.getConnection(url, user, password);
	    } catch (SQLException e) {
		// TODO Auto-generated catch block
		  e.printStackTrace();
	    }
	   return null;
   }
   
   
   
   /**
    * 关闭资源问题
    * 非空判断
    * 单个关闭  
    * statement connection 
    * resultSet stamement connection
    */
   
   
   public static void close(ResultSet resultSet){
	   try {
		resultSet.close();
	 } catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	 }
   }
   
   
   public static void close(Statement statement){
	   
	   if (statement != null) {
		   try {
			statement.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   }
   }
   
   
   public static void close(Connection connection)
   {
	   if (connection != null) {
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 }
   }
   
   
   public static void close(Statement statement,Connection connection)
   {  
	   close(statement);
	   close(connection);
   }
   
   
   public static void close(ResultSet resultSet,Statement statement,Connection connection)
   {
	   close(resultSet);
	   close(statement);
	   close(connection);
   }
   
	
}

```



#### 五. 注入攻击

      ##### 1. 什么是注入攻击？

将查询的结果值！当做sql语句一部分！改变了原来sql语句的逻辑！

```sql
select * from emp where ename = '' or '1' ='1';
```



##### 2.注入攻击解决方案

1. 编写sql，需要填值使用?占位符标识

   ```java
   String sql = "select * from emp where ename = ? and empno = ? ;";
   //注意： ？ 叫占位符！ 代表值的部分，
   // ? 只能代表值！不能替换表名或者列名 , 如果动态拼接表名或者列名需要
   // 字符串拼接
   ```

2. 创建预编译statement

   ```java
   PreparedStatement statement = connection.preparedStatement(sql);
   ```

3. 给查询的占位符赋值

   ```java
   statement.setObject(index,object value); 
   index 代表sql语句中占位符的位置  从左到右 从1开始
   value 占位符对应的值
   ```

4. 执行sql语句

   ```java
   execute(); 
   executeUpdate();
   executeQuery(); 
   ```



#### 六.结果封装

> 针对的查询语句！
>
> 将ResultSet对象封装成可使用的其他类型！



ResultSet 一张虚拟的表！

有若干行！

行里有若干列！

列里装数据！

一行是一个实体！一个对象！

```java
获取resultSet列的信息 核心
ResultSetMetaData metaData = resultSet.getMetaData();
		
int columnCount = metaData.getColumnCount();
		
metaData.getColumnName(1);
```



封装形式：

1. ResultSet --> List<实体类> list ; (开发)

​    

| name | age  |  info  |
| :--: | :--: | :----: |
|  张三  |  11  |   xx   |
|  李四  |  12  | 来至猩猩的你 |
|  王五  |  13  | 帅的一塌糊涂 |

```java
Class Student{ 

   private String name;

   private Integer age;

   private String info

   //get/set/toString

}

Student student = new Student();
student.setName("张三");

List<Student> list =  new ArrayList<Student>();

```



2. ResultSet --> List<Map> list;

```java
Map<Key,Value> map = new HashMap<>();
map.put(name,"张三");
map.put(age,11);
map.put(info,xx);
```

























