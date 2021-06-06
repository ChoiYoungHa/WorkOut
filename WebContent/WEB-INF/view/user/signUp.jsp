<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>회원가입</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="../include/css.jsp"%>
</head>
<body>
<!-- ? Preloader Start -->
<%@include file="../include/preloader.jsp"%>
<!-- Preloader Start-->


<!-- Register -->

<main class="login-body" data-vide-bg="/resource/boots/hosting_tp/assets/img/signup-pushup.mp4">
    <!-- Login Admin -->
    <form class="form-default" action="/insertMember.do" method="POST">
        <div class="login-form">
            <!-- logo-login -->
            <div class="logo-login">
                <a href="/index.do"><img src="/resource/boots/hosting_tp/assets/img/logo/workout_logo_test.png" alt=""></a>
            </div>
            <h2>Registration Here</h2>

            <div class="form-input">
                <label for="member_name">이름</label>
                <input id="member_name" type="text" name="name" placeholder="Full name">
            </div>
            <div class="form-input">
                <label for="member_nic">닉네임</label>
                <input id="member_nic" type="text" name="name" placeholder="Full name">
            </div>
            <div class="form-input">
                <label for="email">이메일</label>
                <input id="email" type="email" name="email" placeholder="Email Address" onfocusout="emailCheck()">
            </div>
            <div class="form-input">
                <label for="password_1">비밀번호</label>
                <input id="password_1" type="password" name="password" placeholder="Password">
            </div>
            <div class="form-input">
                <label for="password_2">비밀번호 확인</label>
                <input id="password_2" type="password" name="password" placeholder="Confirm Password">
            </div>
            <div class="form-input pt-30">
                <input type="submit" name="submit" value="Registration">
            </div>
            <!-- Forget Password -->
            <a href="/logIn.do" class="registration">login</a>
        </div>
    </form>
    <!-- /end login form -->
</main>

<%@include file="../include/js.jsp"%>
<!-- 회원가입 유효성 체크 js -->
<script type="text/javascript" src="/resource/valid/signupCheck.js"></script>
</body>
</html>