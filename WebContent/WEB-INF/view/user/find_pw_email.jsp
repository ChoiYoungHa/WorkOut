<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <!-- jquery -->
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
</head>
<body>

<div>
    <form action="find_pw_email.do" method="post">
        <br>
        <div>
           <input type="email" name="email" id="email" placeholder="이메일을 입력하세요." onfocusout="emailCheck()" required="required"/>
        </div>
        <br> <br>
        <button type="submit" name="submit">인증메일 전송</button>
    </form>
</div>
<script type="text/javascript" src="/resource/valid/pw_find_emailCk.js"></script>
</body>
</html>
