<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>기초대사량 구하기</title>
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
</head>
<body>
<!-- BodyCheck(신체 정보 측정)을 위한 신체정보 입력 테이블 -->
<form id="formvalue" method="post" action="/MetabolismResult.do" onsubmit="return InsertCheck()">
    <div class="table table-dark">
        <div class="row m-2 pt-3" style="font-size:18px;">
            <div class="col-4 text-left mt-2">
                <b>나이를 입력하세요 :</b>
            </div>
            <div class="col-8 text-right">
                <input type="text" name="age" id="age"
                       style="width: 100px; background-color: #ffed91; border: 1px solid #ffed91;" />
                <b>세</b>
            </div>
        </div>

        <hr>
        <div class="row m-2">
            <div class="col-4 text-left"  style="font-size:18px;">
                <b>성별을 선택하세요 :</b>
            </div>
            <div class="col-8 text-right" style="font-size:18px;">
                <label><input type="radio" name="sex" id="sex"
                              style="background-color: lightgray;" value="1" /><b>&nbsp;남자&nbsp;</b></label>
                <label><input type="radio" name="sex" id="sex"
                              style="background-color: lightgray;" value="2" /><b>&nbsp;여자&nbsp;</b></label>
            </div>
        </div>

        <hr>
        <div class="row m-2 "  style="font-size:18px;">
            <div class="col-4 text-left">
                <b>키를 입력하세요 :</b>
            </div>
            <div class="col-8 text-right">
                <input type="text" name="tall" id="tall"
                       style="width: 100px; background-color: #ffed91; border: 1px solid #ffed91;" /><b>cm</b>
            </div>
        </div>

        <hr>
        <div class="row m-2"  style="font-size:18px;">
            <div class="col-4 text-left">
                <b>몸무게를 입력하세요 :</b>
            </div>
            <div class="col-8 text-right">
                <input type="text" name="weight" id="weight"
                       style="width: 100px; background-color: #ffed91; border: 1px solid #ffed91;" />
                <b>kg</b>
            </div>
        </div>

        <hr>
        <div class="row m-2 pl-3 text-left"  style="font-size:18px;">
            <b>나의 활동량을 아래 5가지 중 체크해 주세요 :</b>
        </div>
        <hr>
        <div class="row m-2 pl-3 text-left"  style="font-size:18px;">
            <label> <input type="radio" name="activity" value="1.2">
                <b>거의 없다.</b> (거의 좌식 생활하고, 운동 안 함)
            </label>
        </div>

        <hr>
        <div class="row m-2 pl-3 text-left"  style="font-size:18px;">
            <label> <input type="radio" name="activity" value="1.375">
                <b>조금 있다.</b> (활동량이 보통이거나, 주에 1-3회 운동)
            </label>
        </div>
        <hr>
        <div class="row m-2 pl-3 text-left"  style="font-size:18px;">
            <label> <input type="radio" name="activity" value="1.55">
                <b>보통이다.</b> (활동량이 다소 많거나, 주에 3-5회 운동)
            </label>
        </div>

        <hr>
        <div class="row m-2 pl-3 text-left"  style="font-size:18px;">
            <label> <input type="radio" name="activity" value="1.725">
                <b>꽤 있다.</b> (활동량이 많거나, 주에 6-7회 정도 운동)
            </label>
        </div>
        <hr>
        <div class="row m-2 pl-3 text-left"  style="font-size:18px;">
            <label> <input type="radio" name="activity" value="1.9">
                <b>아주 많다.</b> (활동량이 매우 많거나, 거의 매일 하루 2번 운동)
            </label>
        </div>

        <hr>
        <div class="row m-2"  style="font-size:18px;">
            <div class="col-4 text-left mb-4">
                <b>운동 목적을 선택하세요 :</b>
            </div>
            <div class="col-8 text-right">
                <label><input type="radio" name="how_exer"
                              style="width: 30px" value="1" /><b>체중 감량</b></label>
                <label><input
                        type="radio" name="how_exer" style="width: 30px" value="2" /><b>체중
                    증량</b></label>
                <label><input type="radio" name="how_exer"
                              style="width: 30px" value="3" /><b>체중 유지</b></label>
            </div>
        </div>
    </div>
    <br />
    <input type="hidden" name="basic" id="basic" value="1"  />
    <input type="hidden" name="keep_kcal" id="keep_kcal" value="1"/>
    <input type="hidden" name="goal_kcal" id="goal_kcal" value="1"/>
    <div class="row">
        <div class="col-6">
            <input type="submit" class="btn btn-success" value="입력" style="width: 400px; height: 70px;">
        </div>
        <div class="col-6">
            <input type="reset" class="btn btn-danger" value="다시 작성"
                   style="width: 400px; height: 70px;">
        </div>
    </div>
    <br>
</form>

</section>
</div>
<!-- Body Check 입력 구간 종료 -->
<!-- 기초대사량 측정을 위한 Metabolism js 사용 -->
<script type="text/javascript" src="/resources/js/metabolism.js"></script>
<!-- 부트스트랩 -->
<script type="text/javascript" src="/resources/js/main.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap.css"/>
<script src="/resources/js/bootstrap.js"></script>
</body>
</html>