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
    <section class="team-area section-padding40 section-bg1">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-12">
                    <div class="section-tittle text-center mb-105">
                        <h2>식단 관리하기</h2>
                    </div>
                </div>
            </div>
            <div class="row" style="justify-content: center">
                <div class="col-2">
                    <h1 style="color: white;">주차 별 칼로리</h1>
                </div>
            </div>
            <div class="row" style="justify-content: center">
                <div class="col-2">
                    <select class="form-select" id="week-select">
                        <option value="1week">1주차</option>
                        <option value="2week">2주차</option>
                        <option value="3week">3주차</option>
                        <option value="4week">4주차</option>
                        <option value="5week">5주차</option>
                        <option value="6week">6주차</option>
                        <option value="7week">7주차</option>
                    </select>
                </div>
                </div>
            </div>
        </div>
    </section>
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

                        <!-- Domain List  End-->
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