//회원가입 정보의 유효성 체크하기 및 계산
function InsertCheck() {
    if ($("#age").val() == "") {
        alert("나이를 입력해주세요.");
        $("#age").focus();
        return false;
    }else if ($("input[name='sex']:checked").length < 1) {
        alert("성별을 체크해주세요.");
        $("#sex").focus();
        return false;
    }else if ($("#tall").val() == "") {
        alert("키를 입력해주세요.");
        $("#tall").focus();
        return false;
    }else if ($("#weight").val() == "") {
        alert("몸무게를 입력해주세요.");
        $("#weight").focus();
        return false;
    }else if ($("input[name='activity']:checked").length < 1) {
        alert("활동량을 체크해주세요.");
        $("#how_exer").focus();
        return false;
    }else if ($("input[name='how_exer']:checked").length < 1) {
        alert("운동목적을 체크해주세요.");
        $("#activity").focus();
        return false;
    }else {
        var age =$("#age").val();
        var tall = $("#tall").val();
        var sex=$("input[name='sex']:checked").val();
        var weight = $("#weight").val();
        var activity=$("input[name='activity']:checked").val();
        var how_exer=$("input[name='how_exer']:checked").val();

        if(sex == 1){
            var mansum = 66+(13.7*parseInt(weight))+(5*parseInt(tall))-(6.8*parseInt(age));

            $("#basic").attr("value", mansum); // 기초대사량

            $("#keep_kcal").attr("value", mansum*activity ); // 유지칼로리 기초대사량 * 활동량(운동빈도)

            var mankcal = mansum*activity; // 유지칼로리

            if(how_exer == 1){
                $("#goal_kcal").attr("value", mankcal-(mankcal/10) ); // -10% 체중감소 목적
            }else if(how_exer == 2){
                $("#goal_kcal").attr("value", mankcal+(mankcal/10) ); // -10% 체중증가 목적
            }else if(how_exer == 3){
                $("#goal_kcal").attr("value", mankcal ); // -10% 체중유지 목적
            }

        }else if(sex == 2){
            var Womansum = 655+(9.6*parseInt(weight))+(1.7*parseInt(tall))-(4.7*parseInt(age));

            $("#basic").attr("value", Womansum); // 기초대사량

            $("#keep_kcal").attr("value", Womansum*activity ); // 유지칼로리

            var Womankcal = Womansum*activity; // 유지칼로리

            if(how_exer == 1){
                $("#goal_kcal").attr("value", Womankcal-(Womankcal/10) ); // 목표칼로리 체중감량
            }else if(how_exer == 2){
                $("#goal_kcal").attr("value", Womankcal+(Womankcal/10) ); // 목표칼로리 체중증가
            }else if(how_exer == 3){
                $("#goal_kcal").attr("value", Womankcal ); // 목표칼로리 체중유지
            }
        }
        return true;
    }
};