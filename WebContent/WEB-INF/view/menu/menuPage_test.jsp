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
                <div class="row">
                    <div class="col-xl-4 col-lg-5">
                        <h2>Search new domain</h2>
                        <p>Supercharge your WordPress hosting with detailed  website analytics, marketing tools.</p>
                    </div>
                    <div class="col-xl-8 col-lg-7">
                        <!--Hero form -->
                        <form action="#" class="search-box">
                            <div class="input-form">
                                <input type="text" placeholder="Search for a domain">
                                <!-- icon search -->
                                <div class="search-form">
                                    <button><i class="ti-search"></i></button>
                                </div>
                                <!-- icon search -->
                                <div class="world-form">
                                    <i class="fas fa-globe"></i>
                                </div>
                            </div>
                        </form>
                        <!-- Domain List -->
                        <div class="single-domain pt-30 pb-30">
                            <ul>
                                <li><span>.com</span> <p>$15.99</p></li>
                                <li><span>.net</span> <p>$10.99</p></li>
                                <li><span>.rog</span> <p>$10.99</p></li>
                                <li><span>.me</span> <p>$10.99</p></li>
                            </ul>
                        </div>
                        <!-- Domain List  End-->
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-xl-8 col-lg-9 col-md-12 ">
                        <div class="hero__caption hero__caption2 text-center">
                            <h1 data-animation="fadeInLeft" data-delay=".6s ">식단 관리하기</h1>
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
                <div class="col-xl-3 col-lg-4 col-md-6 col-sm-10">
                    <div class="single-card text-center mb-30">
                        <div class="card-top">
                            <h4>아침</h4>
                            <div id="food_morning_list"></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 col-sm-10">
                    <div class="single-card text-center mb-30">
                        <div class="card-top">
                            <h4>점심</h4>
                            <div id="food_lunch_list"></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 col-sm-10">
                    <div class="single-card text-center mb-30">
                        <div class="card-top">
                            <h4>저녁</h4>
                            <div id="food_dinner_list"></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 col-sm-10">
                    <div class="single-card text-center mb-30">
                        <div class="card-top">
                            <h4>간식</h4>
                            <div id="food_snack_list"></div>
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
<%@include file="../include/footer.jsp"%>
<!-- Scroll Up -->
<div id="back-top" >
    <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
</div>
<%@include file="../include/js.jsp"%>
</body>
</html>