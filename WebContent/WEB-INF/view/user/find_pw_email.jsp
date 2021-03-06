<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>비밀번호찾기</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="../include/css.jsp"%>
</head>
<body>
<%@include file="../include/preloader.jsp"%>
<main class="login-body" data-vide-bg="/resource/boots/hosting_tp/assets/img/login-pullup.mp4">
    <!-- Login Admin -->
    <form class="form-default" action="find_pw_email.do" method="POST">
        <div class="login-form">
            <!-- logo-login -->
            <div class="logo-login">
                <a href="/index.do"><img src="/resource/boots/hosting_tp/assets/img/logo/workout_logo_test.png" alt=""></a>
            </div>
            <h2>이메일을 입력해주세요.</h2>
            <div class="form-input">
                <label for="email">Email</label>
                <input id="email" type="email" name="email" placeholder="Email">
            </div>
            <div class="form-input pt-30">
                <input type="submit" name="submit" value="전송">
            </div>
        </div>
    </form>
    <!-- /end login form -->
</main>
<%@include file="../include/js.jsp"%>
</body>
</html>