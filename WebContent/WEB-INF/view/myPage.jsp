<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    MemberDTO rDTO = (MemberDTO) request.getAttribute("rDTO");

    if (rDTO == null){
        rDTO = new MemberDTO();
    }
%>
<!doctype html>
<%@include file="include/session.jsp"%>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>마이페이지</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="/resource/boots/hosting_tp/assets/img/workout_logo_test.png">
    <!-- CSS here -->
    <%@include file="include/css.jsp"%>
</head>
<body>
<!-- ? Preloader Start -->
<%@ include file="include/preloader.jsp"%>
<!-- Preloader Start -->
<header>
    <!-- Header Start -->
    <%@include file="include/navbar.jsp"%>
    <!-- Header End -->
</header>
<main>
    <!-- Slider Area Start-->
    <div class="slider-area slider-bg ">
        <!-- Single Slider -->
        <div class="single-slider d-flex align-items-center slider-height3">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-xl-8 col-lg-9 col-md-12 ">
                        <div class="hero__caption hero__caption3 text-center">
                            <h1 data-animation="fadeInLeft" data-delay=".6s ">My Page</h1>
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
    <!--? Blog Area Start -->
    <section class="blog_area single-post-area section-padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 posts-list">
                    <div class="single-post">
                        <div class="blog_details">
                            <h2 style="color: #2d2d2d; text-align: center">나의 상세정보</h2>
                            <div class="quote-wrapper">
                                <form action="/myPage_Change_pw.do" method="post" class="subscribe_form relative mail_part" novalidate="true" onsubmit="return InsertCheck();">
                                    <div class="typography">
                                        <div class="quotes">
                                            <h4 class="mt-10">이름 : <%=rDTO.getMember_name()%></h4>
                                            <h4 class="mt-5">닉네임 : <%=rDTO.getMember_nic()%></h4>
                                        </div>
                                        <div class="mt-10">
                                            <input type="password" name="password1" id="password1" placeholder="변경할 비밀번호"
                                                   onfocus="this.placeholder = ''" onblur="this.placeholder = '변경할 비밀번호'" required
                                                   class="single-input quotes">
                                        </div>
                                        <div class="mt-10">
                                            <input type="password" name="password2" id="password2" placeholder="비밀번호 확인"
                                                   onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 확인'" required
                                                   class="single-input quotes" onfocusout="InsertCheck()">
                                        </div>
                                        <button type="submit" class="genric-btn danger circle mt-5">변경</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="blog_right_sidebar mt-75">
                        <aside class="single_sidebar_widget post_category_widget">
                            <h4 class="widget_title" style="color: #2d2d2d;">My Category</h4>
                            <ul class="list cat-list">
                                <li>
                                    <a href="/MyPage.do" class="d-flex">
                                        <p style="font-weight: bold">내 정보</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="/getBookMarkList.do" class="d-flex">
                                        <p style="font-weight: bold">북마크</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="/metabolism.do" class="d-flex">
                                        <p style="font-weight: bold">기초대사량 재설정</p>
                                    </a>
                                </li>
                            </ul>
                        </aside>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Area End -->
</main>
<%@include file="include/footer.jsp"%>
<!-- Scroll Up -->
<div id="back-top" >
    <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
</div>
<%@include file="include/js.jsp"%>

<script type="text/javascript">
    function InsertCheck() {
        if (($("#password1").val() != $("#password2").val())) {
            Swal.fire('비밀번호를 다시 한 번 확인해 주세요.', '', 'warning');
            return false;
        }
    }
</script>
</body>
</html>