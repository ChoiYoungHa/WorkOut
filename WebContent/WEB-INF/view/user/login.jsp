<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>로그인</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="../include/css.jsp"%>
</head>
<body>
<%@include file="../include/preloader.jsp"%>
<main class="login-body" data-vide-bg="/resource/boots/hosting_tp/assets/img/login-pullup.mp4">
    <!-- Login Admin -->
    <form class="form-default" action="/getLogin.do" method="POST" onsubmit="return loginChk();">
        <div class="login-form">
            <!-- logo-login -->
            <div class="logo-login">
                <a href="/index.do"><img src="/resource/boots/hosting_tp/assets/img/logo/workout_logo_test.png" alt=""></a>
            </div>
            <h2>Login Here</h2>
            <div class="form-input">
                <label for="email">Email</label>
                <input id="email" type="email" name="email" placeholder="Email" formnovalidate/>
            </div>
            <div class="form-input">
                <label for="password">Password</label>
                <input id="password" type="password" name="password" placeholder="Password">
            </div>
            <div class="form-input pt-30">
                <input type="submit" name="submit" value="login">
            </div>

            <!-- Forget Password -->
            <a href="/find_pw.do" class="forget">Forget Password</a>
            <!-- Forget Password -->
            <a href="/signup.do" class="registration">Registration</a>
        </div>
    </form>
    <!-- /end login form -->
</main>
<%@include file="../include/js.jsp"%>
<script type="text/javascript">
    //이메일 형식 저장
    var expEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

    function loginChk() {
        if (expEmail.test($("#email").val()) == false || pwJ.test($("#password").val()) == false) {
            console.log("유효하지 않음");
            Swal.fire('입력한 정보를 다시 한 번 확인해 주세요', '', 'warning');
            return false;
        }
    }
</script>
</body>
</html>