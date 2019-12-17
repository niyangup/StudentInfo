<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="utils.DBUtils" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="domain.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>模糊查询学生信息</title>
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
  //设置编码
  request.setCharacterEncoding("utf-8");

  //获取参数
  String mname = request.getParameter("mname");
  String msid = request.getParameter("msid");

  //需要执行的SQL语句
  StringBuffer sql = new StringBuffer("select * from student where 1 = 1 ");

  //姓名有值
  if (mname.trim().length() > 0) {
    sql.append(" and name like ?");
  }
  //学号有值
  if (msid.trim().length() > 0) {
    sql.append(" and sid like ?");
  }
  int i = 1;
  Connection conn = null;
  PreparedStatement ps = null;
  try {
    //获取connection连接对象
    conn = DBUtils.getConnection();
    //获取PreparedStatement对象
    ps = conn.prepareStatement(sql.toString());

    //设置参数
    if (mname.trim().length() > 0) {
      ps.setString(i, "%" + mname + "%");
      i++;
    }

    if (msid.trim().length() > 0) {
      ps.setString(i, "%" + msid + "%");
    }
    //执行sql
    ResultSet rs = ps.executeQuery();
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
    DBUtils.closeAll(conn, ps, null);
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
