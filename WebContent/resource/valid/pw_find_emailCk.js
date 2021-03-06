//이메일 형식 저장
var expEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
//비밀번호 형식 저장 8글자 이상 16자 이하 영어,숫자, 특수문자 1글자이상 포함해야됨
var expPassword = /(?=.*\d{1,18})(?=.*[~`!@#$%\^&*()-+=]{1,18})(?=.*[a-zA-Z]{1,18}).{12,20}$/;

function emailCheck() {
    if (expEmail.test($("#email").val()) == false) {
        alert("올바른 이메일 형식으로 입력해 주세요.");
        return false;
    } else {
        //ajax 호출
        $.ajax({
            //function을 실행할 url
            url : "/signup/emailCheck.do",
            type : "post",
            dataType : "json",
            data : {
                "email" : $("#email").val()
            },
            success : function(data) {
                if (data == 0) { // 가입되지 않은 이메일이면 0
                    alert("가입되지 않은 이메일입니다.");
                    return false;
                } else if (data == 1) { // 회원이면 1
                    alert("인증메일 전송을 눌러주세요.");
                }
            }
        })
    }
}