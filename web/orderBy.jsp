<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.DBUtils" %>
<%@ page import="domain.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>排序</title>
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
  String condition = request.getParameter("condition");

  String sql = null;
  //根据姓名排序
  if ("1".equals(condition)) {
    sql = "select * from student order by name";
  }

  //根据学号排序
  if ("2".equals(condition)) {
    sql = "select * from student order by sid";
  }

  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  try {
    //获取connection对象
    conn = DBUtils.getConnection();
    //获取PreparedStatement对象
    ps = conn.prepareStatement(sql);
    //执行sql语句
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
    //将数据放置在pageContext域对象中
    pageContext.setAttribute("studentList", studentList);
  } catch (SQLException e) {
    e.printStackTrace();
  } finally {
    //释放资源
    DBUtils.closeAll(conn, ps, rs);
  }
%>

<table align="center" width="500px" border="1" style="border-collapse:collapse;">

  <tr>
    <th>编号</th>
    <th>姓名</th>
    <th>学号</th>
    <th>性别</th>
    <th>联系方式</th>
    <th>操作</th>
  </tr>

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
</body>
</html>
