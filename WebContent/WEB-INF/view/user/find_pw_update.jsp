<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="poly.util.CmmUtil"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    <!-- jquery -->
    <script src="/resource/js/jquery-3.4.1.min.js"></script>

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
</head>
<body>
<div>
        <span>비밀번호를 변경해주세요.</span>
    <div>
        <form action="find_pw_change_update.do" method="post">
            <br>
            <div>
                비밀번호 입력 : <input type="password" id="password1" name="password1" placeholder="  비밀번호를 입력하세요. "/>
            </div>
            <br>
            <div>
                비밀번호 확인 : <input type="password" id="password2" name="password2" onfocusout="InsertCheck()" placeholder="  비밀번호를 입력하세요. "/>
            </div>
            <br>
            <button type="submit" name="submit" >비밀번호 변경</button>
        </form>
    </div>
</div>
</body>
</html>
