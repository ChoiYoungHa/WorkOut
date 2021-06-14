<%@ page import="poly.util.CmmUtil" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../include/session.jsp"%>
<!doctype html>
<html class="no-js" lang="zxx">
<%
    String member_gk = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_GK"));

    // 소수점 찍기
    int i = Integer.parseInt(member_gk);
    DecimalFormat dc = new DecimalFormat("###,###,###,###");
    String parse_goal_kcal = dc.format(i);
%>
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
    <div id='loading_layer'
         style='position: fixed;z-index: 3000;top: 0;left: 0;width: 100%;height: 100%;display: none;justify-content: center;align-items: center;background-color: rgba(123, 123, 123, 0.4);writing-mode: vertical-lr;'>
        <img style='width:30%' src='/resource/boots/hosting_tp/assets/img/workout_logo_test.png'/></div>
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
            <div class="row mb-40" style="justify-content: center">
                <div class="col-2">
                    <select class="form-select" id="week-select" onchange="goal_kcal_ch()">
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
            <div class="row justify-content-center mt-10">
                <h2 id="goal_kcal" style="color: white">목표 칼로리 : <%=parse_goal_kcal%>kcal</h2>
            </div>
            <div class="row justify-content-center mt-10">
                <div id="eat_kcal"></div>
            </div>
            <div class="row justify-content-center mt-50">
                <div class="col-xl-8 col-lg-7">
                    <!--Hero form -->
                    <form class="search-box">;
                        <div class="input-form">
                            <input type="text" placeholder="원하는 음식을 검색해보세요" data-target="#exampleModalCenter" data-toggle="modal">
                            <!-- icon search -->
                            <div class="search-form">
                                <button data-target="#exampleModalCenter" data-toggle="modal"><i class="ti-search"></i></button>
                            </div>
                            <!-- icon search -->
                            <div class="world-form">
                                <i class="fas fa-utensils"></i>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            </div>
        </div>
    </section>
    <section class="team-area section-padding40 section-bg1">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-12">
                    <div class="section-tittle text-center mb-105" style="color: white">
                        <div class="row justify-content-around" id="food_info">
                            <!-- 추천 탄단지 -->
                            <div id="recom_info" style="font-weight: bold">
                                <div id="food_recom_head"><h3 style="color: white; font-weight: bold">추천 탄단지</h3></div>
                                <div id="food_recom_info" class="row"></div>
                            </div>
                            <!-- 섭취 탄단지 -->
                            <div id="intake_info" style="font-weight: bold">
                                <div id="food_intake_head"><h3 style="color: white; font-weight: bold">섭취 탄단지</h3></div>
                                <div id="food_intake_info" class="row"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="single-cat">
                    <div class="cat-icon">
                        <img src="assets/img/icon/services1.svg" alt="">
                    </div>
                    <div class="cat-cap">

                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="single-cat">
                    <div class="cat-icon">
                        <img src="assets/img/icon/services2.svg" alt="">
                    </div>
                    <div class="cat-cap">

                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="single-cat">
                    <div class="cat-icon">
                        <img src="assets/img/icon/services3.svg" alt="">
                    </div>
                    <div class="cat-cap">

                    </div>
                </div>
            </div>


        </div>
        </div>
    </section>
    <!-- Modal -->
    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 1200px">
            <div class="modal-content">
                <div class="modal-header">
                            <div class="row col-2">
                            <select class="form-select mt-10" name="modal_searchType" id="modal_searchType">
                                <option value="food_name">음식이름</option>
                                <option value="food_maker">브랜드</option>
                            </select>
                            </div>
                            <div>
                                <!--Hero form -->
                                <form class="search-box ml-10" style="width: 900px" onsubmit="return false">
                                    <div class="input-form">
                                        <input type="text" placeholder="원하는 음식을 검색해보세요" id="modal_keyword">
                                        <!-- icon search -->
                                        <div class="search-form">
                                            <button type="button" value="검색" onclick="clickFoodList()"><i class="ti-search"></i></button>
                                        </div>
                                        <!-- icon search -->
                                        <div class="world-form">
                                            <i class="fas fa-utensils"></i>
                                        </div>
                                    </div>
                                </form>
                            </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- content box left-->
                    <div class="container">
                        <div class="row">
                            <!--모달 왼쪽 박스 -->
                            <div class="col-lg-6" id="content_left_box">
                                <div id="food_list_head"><h3 style="text-align: center; font-weight: bold">음식목록</h3></div>
                                <div id="food_list" class="single_sidebar_widget post_category_widget">
                                    <ul id="searchList" class="list cat-list"></ul>
                                </div>
                                    <div id="paging"></div>
                            </div>
                            <!--모달 오른쪽 박스 -->
                            <div class="col-lg-6" id="content_right_box">
                                <div id="right_one">
                                    <ul id="tan" class="list cat-list"></ul>
                                    <input type="hidden" id="foodName">
                                    <input type="hidden" id="foodBrand">
                                    <input type="hidden" id="foodGram">
                                    <input type="hidden" id="foodKcal">
                                    <input type="hidden" id="foodTan">
                                    <input type="hidden" id="foodDan">
                                    <input type="hidden" id="foodFat">
                                </div>
                                <div id="right_two">
                                    <br>
                                    <div><h3 style="text-align: center">개수</h3></div>
                                    <br>
                                    <div id="amount_box">
                                        <div class="mt-10">
                                            <input type="text" id="amount" placeholder="개수를 입력해주세요"
                                                   onfocus="this.placeholder = ''" onblur="this.placeholder = '개수를 입력하세요'" required
                                                   class="single-input-accent" style="text-align: center">
                                        </div>
                                    </div>
                                    <hr>
                                </div>
                                <div id="right_three">
                                    <div class="row justify-content-center mb-20">
                                        <select name="modal_food_time" id="modal_food_time">
                                            <option value="morning">아침</option>
                                            <option value="lunch">점심</option>
                                            <option value="dinner">저녁</option>
                                            <option value="snack">간식</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick=saveFoodList()>등록</button>
                    </div>
                </div>
            </div>
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
<%@include file="../include/core_script.jsp"%>
</body>
</html>