<%@ page import="poly.dto.NoticeDTO" %>
<%@ page import="poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String category = ((String)request.getAttribute("post_category")); // 어떤 게시판인지 게시판에 표기하기 위한 변수
    String category_hit = ((String)request.getAttribute("post_category")); // 인기 게시물 카테고리 구분
    String SS_MEMBER_ID = ((String)session.getAttribute("SS_MEMBER_ID")); // 회원마다 북마크 표시가 다르게 보여야 함.
//    List<NoticeDTO> rList =	(List<NoticeDTO>)request.getAttribute("rList"); // 해당 카테고리에 맞는 게시물을 표시

//게시판 조회 결과 보여주기
//    if (rList==null){
//        rList = new ArrayList<>();
//    }

    if (category.equals("work")) {
        category = "운동";
    }else {
        category = "식단";
    }
%>

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
                            <div class="row col-lg-12">
                                <form action="/notice/searchBoard.do" class="search-box" style="width: 900px" method="GET">
                                    <div class="default-select mb-20 ml-lg-3">
                                        <select name="modal_searchType" id="modal_searchType">
                                            <option value="title">제목</option>
                                            <option value="member_nic">닉네임</option>
                                        </select>
                                    </div>
                                    <div class="input-form">
                                        <input type="text" name="keyword" id="keyword" onfocus=getSearchList() onblur=removeSearchList() placeholder="원하는 게시물을 찾아보세요">
                                        <div class="search-form mr-10">
                                            <button type="submit"><i class="ti-search"></i></button>
                                        </div>
                                        <div id="search_box"></div>
                                        <input type="hidden" id="category" name="category" value="<%=category_hit%>">
                                        <!-- icon search -->
                                        <div class="world-form">
                                            <i class="fas fa-globe"></i>
                                        </div>
                                    </div>
                                </form>
                            </div>


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
<%@include file="../include/notice_script.jsp"%>
</body>
</html>