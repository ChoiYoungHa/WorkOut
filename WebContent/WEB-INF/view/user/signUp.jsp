<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <!-- jquery -->
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
</head>
<body>
<div class="container">
    <form action="/insertMember.do" method="POST">
        <!-- 이메일 입력 후, ajax를 통해 이메일 중복 여부 검사 -->
        <input type="email" name="email" id="email" placeholder="이메일을 입력해 주세요." onfocusout="emailCheck()" required="required"/>
        <a id="btn-id">중복확인</a>
        <br/>
        <input type="text" name="member_name" id="name" placeholder="이름을 입력해 주세요." required="required"/>
        <br/>
        <input type="password" name="password" id="password_1" placeholder="비밀번호를 입력해 주세요." required="required"/>
        <br/>
        <input type="password" name="password2" id="password_2" placeholder="비밀번호 확인을 입력해 주세요." required="required" />
        <br/>
        <input type="text" name="member_nic" id="member_nic" placeholder="닉네임을 입력해주세요." required="required" />
        <br/>

<input type="submit" value="회원가입">
</form>
</div>

<!-- bootstrap, css 파일 -->
<link rel="stylesheet" href="/resource/css/user.css"/>
<script src="/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap.css"/>

<!-- 회원가입 유효성 체크 js -->
<script type="text/javascript" src="/resource/valid/signupCheck.js"></script>
</body>
</html>
