<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="include/session.jsp"%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Work Out</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- css import-->
    <%@include file="include/css.jsp"%>
</head>
<body>
<!-- Preloader Start -->
<%@ include file="include/preloader.jsp"%>
<!-- Preloader End -->
<%@include file="include/navbar.jsp"%>
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
                            <h1 data-animation="fadeInLeft" data-delay=".6s ">BUILD UP YOUR BODY SHAPE</h1>
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
    <section class="pricing-card-area pricing-card-area2 fix">
        <div class="container">
            <div class="row">
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-10">
                    <div class="single-card text-center mb-30">
                        <div class="card-top">
                            <img src="/resource/boots/hosting_tp/assets/img/icon/babel.png" style="width: auto" height="110px" alt="">
                            <h4>인공지능 홈트레이닝</h4>
                            <p>Starting at</p>
                        </div>
                        <div class="card-bottom">
                            <a href="workMain.do" class="borders-btn">Get Started</a>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-10">
                    <div class="single-card text-center mb-30">
                        <div class="card-top">
                            <img src="/resource/boots/hosting_tp/assets/img/icon/food.png" style="width: auto" height="110px" alt="">
                            <h4>식단관리</h4>
                            <p>Starting at</p>
                        </div>
                        <div class="card-bottom">
                            <a href="/checkMemberGk.do" class="borders-btn">Get Started</a>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-10">
                    <div class="single-card text-center mb-30">
                        <div class="card-top">
                            <img src="/resource/boots/hosting_tp/assets/img/icon/heart.png" style="width: auto" height="110px" alt="">
                            <h4>기초대사량 계산기</h4>
                            <p>Starting at</p>
                        </div>
                        <div class="card-bottom">
                            <a href="/metabolism.do" class="borders-btn">Get Started</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Pricing Card End -->
    <!--? About-1 Area Start -->

    <!-- About-1 Area End -->
    <!--? About-2 Area Start -->
    <div class="about-area1 pb-bottom">

    </div>
    <!-- About-2 Area End -->
</main>
<%@include file="include/footer.jsp"%>
<!-- Scroll Up -->
<div id="back-top" >
    <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
</div>
<%@include file="include/js.jsp"%>
<script type="text/javascript">
    function validateCheck(){
        console.log(<%=SS_MEMBER_ID%>);
        if ('<%=SS_MEMBER_ID%>' == 'null') {
            Swal.fire({
                title: "<%=msg%>",
                icon: 'success',
            }).then(val => {
                if (val) {
                    location.href = "<%=url%>";
                }
            });
        }
    }
    function init(){
        validateCheck();
    }
    init();
</script>
</body>
</html>