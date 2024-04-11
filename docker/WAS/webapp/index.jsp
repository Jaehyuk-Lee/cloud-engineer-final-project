<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MariaDB 연결 드라이버 테스트</title>
</head>
<body>
        <h1>MariaDB 연결 드라이버 테스트</h1>
        <%
                String jdbcUrl = "jdbc:mariadb://192.168.111.31:3306/wbdb";
                String dbId = "root";
                String dbPwd = "mypassword";

                try
                {
                        Class.forName("org.mariadb.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);
                        out.println("MariaDB 연결 성공");
                }
                catch (Exception ex)
                {
                        out.println("연결 오류입니다. 오류 메시지 : " + ex.getMessage());
                }
        %>
</body>
</html>
