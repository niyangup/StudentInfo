package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtils {
  private static String driveClassName = "com.mysql.jdbc.Driver";
  // 数据库的url
  private static String url =
      "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf8";

  // 数据库用户名
  private static String user = "root";
  // 数据库密码
  private static String password = "admin";

  /** 获取connection对象 */
  public static Connection getConnection() {
    Connection conn = null;
    try {
      Class.forName(driveClassName);
    } catch (ClassNotFoundException e) {
      e.printStackTrace();
    }

    try {
      conn = DriverManager.getConnection(url, user, password);
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return conn;
  }

  /** 释放资源 */
  public static void closeAll(Connection conn, Statement st, ResultSet rs) {
    // 负责关闭
    if (conn != null) {
      try {
        conn.close(); // 使用代理,放回到连接池中
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
    if (st != null) {
      try {
        st.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
    if (rs != null) {
      try {
        rs.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  }
}
