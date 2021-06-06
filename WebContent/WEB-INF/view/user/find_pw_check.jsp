<%@ page import="poly.util.CmmUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>인증번호 입력</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="../include/css.jsp"%>
</head>
<body>
<%@include file="../include/preloader.jsp"%>
<main class="login-body" data-vide-bg="/resource/boots/hosting_tp/assets/img/login-pullup.mp4">
    <!-- Login Admin -->
    <form class="form-default" action="find_pw_result.do" method="POST">
        <div class="login-form">
            <!-- logo-login -->
            <div class="logo-login">
                <a href="/index.do"><img src="/resource/boots/hosting_tp/assets/img/logo/workout_logo_test.png" alt=""></a>
            </div>
            <h2>인증번호를 입력해주세요.</h2>
            <div class="form-input">
                <label for="client_auth">인증번호</label>
                <input id="client_auth" type="text" name="client_auth" placeholder="인증번호">
            </div>
            <div class="form-input pt-30">
                <input type="submit" name="submit" value="전송">
            </div>
        </div>
    </form>
    <!-- /end login form -->
</main>
<%@include file="../include/js.jsp"%>
<script type="text/javascript">
    alert("<%=msg%>");
</script>
</body>
</html>