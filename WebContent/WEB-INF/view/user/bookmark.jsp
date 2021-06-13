<%@ page import="poly.dto.MemberDTO" %>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    List<NoticeDTO> rList = (List<NoticeDTO>) request.getAttribute("rList");
%>

<!doctype html>
<%@include file="../include/session.jsp"%>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title> Hosting | Template</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="/resource/boots/hosting_tp/assets/img/workout_logo_test.png">
    <!-- CSS here -->
    <%@include file="../include/css.jsp"%>
</head>
<body>
<!-- ? Preloader Start -->
<%@ include file="../include/preloader.jsp"%>
<!-- Preloader Start -->
<header>
    <!-- Header Start -->
    <%@include file="../include/navbar.jsp"%>
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
                            <h1 data-animation="fadeInLeft" data-delay=".6s ">BookMark</h1>
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
                <div class="col-xs-8 posts-list">
                    <div class="single-post">
                        <div class="blog_details">
                            <h2 style="color: #2d2d2d; text-align: center">북마크 게시물</h2>
                            <div class="quote-wrapper">
                                <div class="progress-table-wrap">
                                    <div class="progress-table">
                                        <div class="table-head">
                                            <div class="percentage">제목</div>
                                            <div class="country">조회수</div>
                                            <div class="visit">추천수</div>
                                            <div class="serial">작성자</div>
                                        </div>
                                            <%
                                                int i =0;
                                                for (;i<rList.size();i++){
                                                    NoticeDTO rDTO = rList.get(i);
                                                    if (rDTO==null){
                                                        rDTO = new NoticeDTO();
                                                    }
                                            %>
                                        <div class="table-row">
                                            <div class="percentage"><a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getPost_id())%>');"><%=rDTO.getPost_title()%></a></div>
                                            <div class="country"><%=rDTO.getPost_view()%></div>
                                            <div class="visit"><%=rDTO.getPost_recom()%></div>
                                            <div class="serial"><%=rDTO.getMember_nic()%></div>
                                        </div>
                                        <% } %>
                                    </div>
                                </div>
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
<%@include file="../include/footer.jsp"%>
<!-- Scroll Up -->
<div id="back-top" >
    <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
</div>
<%@include file="../include/js.jsp"%>
<script type="text/javascript">
    function doDetail(seq){
        location.href="/notice/NoticeInfo.do?nSeq="+ seq;
    }


</script>
</body>
</html>