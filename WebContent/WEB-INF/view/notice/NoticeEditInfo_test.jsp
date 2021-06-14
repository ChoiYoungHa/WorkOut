<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.MemberDTO" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    NoticeDTO rDTO = (NoticeDTO)request.getAttribute("rDTO");
//공지글 정보를 못불러왔다면, 객체 생성
    if (rDTO==null){
        rDTO = new NoticeDTO();
    }
    int access = 1; //(작성자 : 2 / 다른 사용자: 1)
    if (CmmUtil.nvl((String)session.getAttribute("SS_MEMBER_ID")).equals(rDTO.getMember_member_id())){
        access = 2;
    }

%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>게시판 글보기</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="/resource/boots/hosting_tp/assets/img/workout_logo_test.png">
    <!-- CSS here -->
    <%@include file="../include/css.jsp" %>
</head>
<body>
<!-- ? Preloader Start -->
<%@ include file="../include/preloader.jsp" %>
<!-- Preloader Start -->
<header>
    <!-- Header Start -->
    <%@include file="../include/navbar.jsp" %>
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
                            <h1>게시물 수정</h1>
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
                <div class="col-lg-12 posts-list">
                    <div class="single-post">
                        <div class="blog_details">
                            <div class="blog-author">
                                <form name="f" method="post" action="/notice/NoticeUpdate.do" onsubmit="return doSubmit(this);">
                                    <input type="hidden" name="nSeq" value="<%=request.getParameter("nSeq") %>" />
                                <div class="quote-wrapper">
                                    <div>
                                        <div><input name="title"><%=rDTO.getPost_title()%></div>
                                        <div class="row justify-content-end">
                                            <div><h5 class="mr-20">조회수 : <%=rDTO.getPost_view()%></h5></div>
                                        </div>
                                        <div>
                                            <select id="category" name="category" class="custom-select custom-select-lg mb-3" style="background-color:lightskyblue; text-align:center;font-weight:bold;">
                                            <option value="menu">식단게시판</option>
                                            <option value="work">운동게시판</option>
                                        </select>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div class="media align-items-center">
                                    <input class="ml-25"><%=rDTO.getContent().replaceAll("\r\n", "<br/>")%>
                                </div>
                                    <hr>
                                    <div>
                                        <div><input type="submit" value="수정" /></div>
                                        <div><input type="reset" value="다시 작성" /></div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Area End -->
</main>
<%@include file="../include/footer.jsp" %>
<!-- Scroll Up -->
<div id="back-top">
    <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
</div>
<%@include file="../include/js.jsp" %>
<%@include file="../include/noticeEditInfo_script.jsp" %>
</body>
</html>