<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="poly.util.CmmUtil"%>
<%
    String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!-- jquery -->
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        alert("<%=msg%>");
    </script>
</head>
<body>
<div>
        <span>입력한 이메일로 받은 인증번호를 입력하세요. (인증번호가 맞아야 비밀번호를 변경하실 수 있습니다.)</span>
    <div>
        <form action="find_pw_result.do" method="post">
            <br>
            <div>
                인증번호 입력 : <input type="text" name="client_auth" placeholder="  인증번호를 입력하세요. ">
            </div>
            <br>
            <button type="submit" name="submit">인증번호 전송</button>
        </form>
    </div>
</div>
</body>
</html>
