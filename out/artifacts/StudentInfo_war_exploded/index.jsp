<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="utils.DBUtils" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="domain.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>学生基本信息管理系统</title>
</head>
<style>
  a {
    text-decoration: none
  }

  a:visited {
    color: #0000EE
  }

  a:active {
    color: #FF0000
  }
</style>
<script>
  function deleteUser(id) {
    //用户安全提示
    if (confirm("您确定要删除吗？")) {
      //访问路径
      location.href = "deleteStudent.jsp?id=" + id;
    }
  }
</script>
<body>
<%
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  try {
    //编写SQL语句
    String sql = "select * from student";
    //获取connection对象
    conn = DBUtils.getConnection();
    //获取PreparedStatement对象
    ps = conn.prepareStatement(sql);
    //执行查询
    rs = ps.executeQuery();
    List<Student> studentList = new ArrayList<>();
    //遍历结果集
    while (rs.next()) {
      Student student = new Student();
      student.setId(rs.getInt("id"));
      student.setName(rs.getString("name"));
      student.setSid(rs.getInt("sid"));
      student.setGender(rs.getString("gender"));
      student.setTel(rs.getInt("tel"));
      studentList.add(student);
    }
    //将数据放入pageContext域中
    pageContext.setAttribute("studentList", studentList);
  } catch (SQLException e) {
    e.printStackTrace();
  } finally {
    //释放资源
    DBUtils.closeAll(conn, ps, rs);
  }
%>
<div align="center">
  <a href="add.jsp">添加学生信息</a>
</div>
<table align="center" width="500px" border="1" style="border-collapse:collapse;">

  <tr>
    <th>编号</th>
    <th>姓名</th>
    <th>学号</th>
    <th>性别</th>
    <th>联系方式</th>
    <th>操作</th>
  </tr>

  <!--  遍历展示数据-->
  <c:forEach items="${studentList}" var="student" varStatus="s">
    <tr align="center">

      <td>${s.count}</td>
      <td>${student.name}</td>
      <td>${student.sid}</td>
      <td>${student.gender}</td>
      <td>${student.tel}</td>
      <td>
        <a href="update.jsp?id=${student.id}">更新</a>
        <a href="javascript:deleteUser(${student.id});">删除</a>
      </td>
    </tr>

  </c:forEach>

</table>
<div align="center">

  <div style="padding-top: 20px;">
    <form action="searchStudent.jsp" method="post">
      <span align="center">
        姓名:<input type="text" name="mname" id="mname" placeholder="根据姓名模糊查询">
        学号:<input type="text" name="msid" id="msid" placeholder="根据学号模糊查询">
        <input type="submit" value="模糊查询"/>
      </span>
    </form>
  </div>
  <span>
    <a href="orderBy.jsp?condition=1">根据姓名排序</a>
    <a href="orderBy.jsp?condition=2">根据学号排序</a>
  </span>

</div>


</body>
</html>
