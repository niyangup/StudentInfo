<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="utils.DBUtils" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="domain.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>更新学生信息</title>
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
<body>

<%
  //获取需要修改数据的id
  String num = request.getParameter("id");
  //将string转换成int
  int id = Integer.parseInt(num);

  int count = 0;
  Connection conn = null;
  PreparedStatement ps = null;
  try {
    //添加的sql语句
    //    String sql = "update student set name=?,sid=?,gender=?,tel=? where id = ?";
    String sql = "select * from student where id=?";
    //获取connection连接对象
    conn = DBUtils.getConnection();
    //获取PreparedStatement对象
    ps = conn.prepareStatement(sql);
    ps.setInt(1, id);
    //执行sql
    ResultSet rs = ps.executeQuery();
    //声明student对象
    Student student = null;
    while (rs.next()) {
      student = new Student();
      //为student设置属性
      student.setId(id);
      student.setName(rs.getString("name"));
      student.setSid(rs.getInt("sid"));
      student.setGender(rs.getString("gender"));
      student.setTel(rs.getInt("tel"));
    }
    if (student != null) {
      pageContext.setAttribute("student", student);
    }
  } catch (SQLException e) {
    e.printStackTrace();
  } finally {
    //释放资源
    DBUtils.closeAll(conn, ps, null);
  }
%>
<div class="container" align="center">
  <form action="updateStudent.jsp" method="post">

    <input type="hidden" class="form-control" id="id" name="id" value="${student.id}">

    <table>
      <tr>
        <td><label for="name">姓名：</label></td>
        <td>
          <input type="text" class="form-control" id="name" name="name" placeholder="请输入姓名" value="${student.name}">
        </td>
      </tr>
      <tr>
        <td><label for="name">性别：</label></td>
        <td>
          <c:if test="${student.gender == '女'}">
            <input type="radio" name="gender" value="男"/>男
            <input type="radio" name="gender" value="女" checked="checked"/>女
          </c:if>

          <c:if test="${student.gender == '男'}">
            <input type="radio" name="gender" value="男" checked="checked"/>男
            <input type="radio" name="gender" value="女"/>女
          </c:if>
        </td>
      </tr>

      <tr>
        <td><label for="name">学号：</label></td>
        <td>
          <input type="text" class="form-control" id="sid" name="sid" placeholder="请输入学号" value="${student.sid}">
        </td>
      </tr>
      <tr>
        <td><label for="name">电话：</label></td>
        <td>
          <input type="text" class="form-control" id="tel" name="tel" placeholder="请输入电话" value="${student.tel}"/>
        </td>
      </tr>
    </table>


    <div class="form-group" style="text-align: center">
      <input type="button" value="提交" onclick="check()">
    </div>
  </form>
</div>

<!--空判断功能-->
<script type="text/javascript">
  function check() {
    var name = document.getElementById("name").value;
    var sid = document.getElementById("sid").value;
    var tel = document.getElementById("tel").value;
    // alert(document.getElementsByName("gender")[0].value);
    if (name.trim() == "" || sid.trim() == "" || tel.trim() == "") {
      alert("请输入完整信息");
    } else {
      //通过验证就提交
      document.forms[0].submit();
    }

  }

</script>
</body>
</html>
