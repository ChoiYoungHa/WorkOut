//이메일 형식 저장
var expEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

var nameJ = /^[가-힣]{2,6}$/;
// 유효성 체크를 보여주는 id값을 변수에 담음(getElementById('id값')

// signUp.jsp에서 회원 이름을 나타내는 id값
var uname = document.getElementById("member_name");

// 비밀번호 형식 저장(영문 대, 소문자, 대소문자로 시작하는 4~20자리)
var pwJ = /^[a-zA-Z0-9]{4,20}$/;


function emailCheck() {
    if (expEmail.test($("#email").val()) == false) {
        Swal.fire("올바른 이메일 형식으로 입력해 주세요.",'','error');
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
                if (data == 1) { // 이미 존재하여 1을 반환하면
                    Swal.fire("이미 가입된 이메일입니다.",'','error');
                } else if (data == 0) { // 존재하지 않아 0을 반환하면
                    Swal.fire("사용 가능한 이메일입니다.",'','success');
                }
            }
        })
    }
}

function signupCheck() {
    // 실시간으로 유효성 체크를 하기 때문에, 유효성이 잘못되었거나 값이 입력되지 않으면 다시 확인해 달라는 모달창을 띄움
    if (expEmail.test($("#email").val()) == false || nameJ.test($(uname).val()) == false
        || ($("#password_1").val() != $("#password_2").val()) || pwJ.test($("#password_1").val()) == false ||
        $("#member_nic").val() == "") {
        Swal.fire('입력한 정보를 다시 한 번 확인해 주세요.', '', 'warning');
        return false;
    }
}

