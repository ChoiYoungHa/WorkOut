<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../include/session.jsp"%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Work Out</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- css import-->
    <%@include file="../include/css.jsp"%>
</head>
<body>
<!-- Preloader Start -->
<%@ include file="../include/preloader.jsp"%>
<!-- Preloader End -->
<%@include file="../include/navbar.jsp"%>
<main>
    <!-- Slider Area Start-->
    <div class="slider-area slider-bg ">
        <!-- Single Slider -->
        <div class="single-slider d-flex align-items-center slider-height2">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-xl-8 col-lg-9 col-md-12 ">
                        <div class="hero__caption hero__caption2 text-center">
                            <i class="fas fa-dumbbell"></i>
                            <h1 data-animation="fadeInLeft" data-delay=".6s ">기초대사량 구하기</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Slider Shape -->
        <div class="slider-shape d-none d-lg-block">
            <img class="slider-shape1" src="/resource/boots/hosting_tp/assets/img/hero/top-left-shape.png" alt="">
        </div>
    </div>
    <!-- Slider Area End -->
    <!--? Pricing Card Start -->

        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-xl-8 col-lg-9 col-md-12 ">
                    <div class="hero__caption hero__caption2 text-center">
                        <h1 data-animation="fadeInLeft" data-delay=".6s " class="mt-5">해리스 베네딕트 방정식</h1>
                        <p data-animation="fadeInLeft" data-delay=".8s">사람마다 다른 기초대사량을 구하고 활동량에 비례하여 가만히 있어도 소모되는 칼로리를 구하는 과정입니다. 이를 유지칼로리라
                        부르며 유지칼로리보다 덜 먹으면 살이빠지고 더 먹으면 살이찌는 원리를 적용하였습니다. </p>
                        <blockquote class="generic-blockquote">
                        <form action="/MetabolismResult.do" onsubmit="return InsertCheck()">
                            <div class="mt-10 mb-10">
                                <input type="text" name="age" id="age" placeholder="나이를 입력하세요 : "
                                       onfocus="this.placeholder = ''" onblur="this.placeholder = '나이를 입력하세요 : '" required
                                       class="single-input-primary" style="font-weight: bold">
                            </div>

                            <div class="row m-2">
                                <div class="col-4 text-left" style="font-weight: bold">성별을 선택하세요 : </div>
                                <div class="col-8 text-right" style="font-size:18px;">
                                    <label><input type="radio" name="sex" id="sex" value="1" /><b>&nbsp;남자&nbsp;</b></label>
                                    <label><input type="radio" name="sex" id="sex" value="2" /><b>&nbsp;여자&nbsp;</b></label>
                                </div>
                            </div>

                            <div class="mt-10">
                                <input type="text" name="tall" id="tall" placeholder="키를 입력하세요 : "
                                       onfocus="this.placeholder = ''" onblur="this.placeholder = '키를 입력하세요 : '" required
                                       class="single-input-primary" style="font-weight: bold">
                            </div>
                            <div class="mt-10">
                                <input type="text" name="weight" id="weight" placeholder="몸무게를 입력하세요 : "
                                       onfocus="this.placeholder = ''" onblur="this.placeholder = '몸무게를 입력하세요 : '" required
                                       class="single-input-primary" style="font-weight: bold">
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
                                    <b>운동 목적을 선택하세요:</b>
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
                            <br />
                            <input type="hidden" name="basic" id="basic" value="1"  />
                            <input type="hidden" name="keep_kcal" id="keep_kcal" value="1"/>
                            <input type="hidden" name="goal_kcal" id="goal_kcal" value="1"/>
                            <div class="row">
                                <div class="col-6">
                                    <input type="submit" class="btn btn-success" value="입력" style="width: 250px; height: 70px;">
                                </div>
                                <div class="col-6">
                                    <input type="reset" class="btn btn-danger" value="다시 작성"
                                           style="width: 250px; height: 70px;">
                                </div>
                            </div>
                            <br>
                        </form>
                        </blockquote>
                    </div>
                </div>
            </div>
        </div>
    <!-- Pricing Card End -->
    <!--? About-1 Area Start -->

    <!-- About-1 Area End -->
    <!--? About-2 Area Start -->
    <div class="about-area1 pb-bottom">

    </div>
    <!-- About-2 Area End -->
</main>
<%@include file="../include/footer.jsp"%>
<!-- Scroll Up -->
<div id="back-top" >
    <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
</div>
<%@include file="../include/js.jsp"%>
<script type="text/javascript" src="/resources/js/metabolism.js"></script>
</body>
</html>