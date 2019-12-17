<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <title>添加学生信息</title>
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
<div class="container" align="center">
  <center><h3>添加学生信息页面</h3></center>
  <form action="addStudent.jsp" method="post">

    <table>
      <tr>
        <td><label for="name">姓名：</label></td>
        <td><input type="text" class="form-control" id="name" name="name" placeholder="请输入姓名"></td>
      </tr>
      <tr>
        <td><label for="name">性别：</label></td>
        <td>
          <input type="radio" name="gender" value="男" checked="checked"/>男
          <input type="radio" name="gender" value="女"/>女
        </td>
      </tr>

      <tr>
        <td><label for="name">学号：</label></td>
        <td><input type="text" class="form-control" id="sid" name="sid" placeholder="请输入学号"></td>
      </tr>
      <tr>
        <td><label for="name">电话：</label></td>
        <td><input type="text" class="form-control" id="tel" name="tel" placeholder="请输入电话"/></td>
      </tr>
    </table>


    <div class="form-group" style="text-align: center">
      <input type="button" value="提交" onclick="check()">
      <input type="reset" value="重置"/>
    </div>
  </form>

  <!--  空判断功能-->
  <script type="text/javascript">
    function check() {
      var name = document.getElementById("name").value;
      var sid = document.getElementById("sid").value;
      var tel = document.getElementById("tel").value;
      if (name.trim() == "" || sid.trim() == "" || tel.trim() == "") {
        alert("请输入完整信息");
      } else {
        //通过验证就提交
        document.forms[0].submit();
      }
    }
  </script>
</div>
</body>
</html>