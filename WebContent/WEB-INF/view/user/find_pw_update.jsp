<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>비밀번호 변경</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="../include/css.jsp"%>
</head>
<body>
<%@include file="../include/preloader.jsp"%>
<main class="login-body" data-vide-bg="/resource/boots/hosting_tp/assets/img/login-pullup.mp4">
    <!-- Login Admin -->
    <form class="form-default" action="find_pw_change_update.do" method="POST">
        <div class="login-form">
            <!-- logo-login -->
            <div class="logo-login">
                <a href="/index.do"><img src="/resource/boots/hosting_tp/assets/img/logo/workout_logo_test.png" alt=""></a>
            </div>
            <h2>새 비밀번호를 입력해주세요.</h2>
            <div class="form-input">
                <label for="password1">새 비밀번호</label>
                <input id="password1" type="password" name="password1" placeholder="새 비밀번호">
            </div>
            <h2>비밀번호를 확인해주세요.</h2>
            <div class="form-input">
                <label for="password2">비밀번호 확인</label>
                <input id="password2" type="password" name="password2" placeholder="비밀번호 확인" onfocusout="InsertCheck()">
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
    function InsertCheck() {
        if ($("#password1").val() == "") {
            alert("비밀번호를 입력해주세요.");
            $("#password1").focus();
            return false;
        } else if ($("#password2").val() == "") {
            $("#alert-check").hide();
            alert("비밀번호 확인을 입력해주세요.");
            $("#password2").focus();
            return false;
        } else if ($("#password1").val() !== $("#password2").val()) {
            $("#alert-check").hide();
            alert("비밀번호가 일치하지 않습니다.");
            $("#password_2").focus();
            return false;
        }
    }
</script>
</body>
</html>