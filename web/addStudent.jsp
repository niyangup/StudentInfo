<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="utils.DBUtils" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>添加学生信息</title>
</head>
<body>
<%
  //设置编码
  request.setCharacterEncoding("utf-8");

  //获取参数
  String name = request.getParameter("name");
  String sid = request.getParameter("sid");
  String gender = request.getParameter("gender");
  String tel = request.getParameter("tel");


  int count = 0;
  Connection conn = null;
  PreparedStatement ps = null;
  try {
    //添加的sql语句
    String sql = "insert into student values(null,?,?,?,?)";
    //获取connection连接对象
    conn = DBUtils.getConnection();
    //获取PreparedStatement对象
    ps = conn.prepareStatement(sql);

    //设置参数
    ps.setString(1, name);
    ps.setInt(2, Integer.parseInt(sid));
    ps.setString(3, gender);
    ps.setInt(4, Integer.parseInt(tel));
    //执行sql
    count = ps.executeUpdate();
  } catch (SQLException e) {
    e.printStackTrace();
  } finally {
    //释放资源
    DBUtils.closeAll(conn, ps, null);
  }

  //跳转到index.jsp
  response.sendRedirect("index.jsp");
%>

</body>
</html>
