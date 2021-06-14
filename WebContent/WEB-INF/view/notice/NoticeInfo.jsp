<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.MemberDTO" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    NoticeDTO rDTO = (NoticeDTO) request.getAttribute("rDTO"); // 게시물에 관한 정보
    MemberDTO find_member = (MemberDTO) request.getAttribute("find_member"); // 작성자 회원에 관한 정보

//공지글 정보를 못불러왔다면, 객체 생성
    if (rDTO == null) {
        rDTO = new NoticeDTO();
    }

    String SS_MEMBER_ID = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID")); // 현재 로그인한 사용자
    String SS_MEMBER_NIC = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_NIC")); // 현재 로그인한 사용자의 닉네임 (댓글사용)
//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    int edit = 1;

//로그인 안했다면....
    if (SS_MEMBER_ID.equals("")) {
        edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
    } else if (SS_MEMBER_ID.equals(rDTO.getMember_member_id())) {
        edit = 2;
    }

    System.out.println("SS_MEMBER_ID : " + SS_MEMBER_ID); // 로그인중인 사용자 ID
    System.out.println("member_id = " + rDTO.getMember_member_id()); // 게시글 작성자 ID
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
                            <h1>게시물 조회</h1>
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
                                <div class="quote-wrapper">
                                    <div>
                                        <div><h1><%=rDTO.getPost_title()%></h1></div>
                                        <div><h3><%=find_member.getMember_nic()%></h3></div>
                                        <div class="row justify-content-end">
                                            <div><h5 class="mr-20">조회수 : <%=rDTO.getPost_view()%></h5></div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div class="media align-items-center">
                                    <p class="ml-25"><%=rDTO.getContent().replaceAll("\r\n", "<br/>")%></p>
                                </div>
                                <div class="comments-area">
                                    <div class="comment-list" id="comment_list">

                                    </div>
                                    <div class="comment-form">
                                        <h4 class="font-weight-bold">댓글작성</h4>
                                        <form class="form-contact comment_form" onSubmit="return false">
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="form-group">
                                                    <textarea class="form-control w-100" name="comment" id="comment"
                                                              cols="30" rows="9" placeholder="Write Comment"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <button type="button" id="regComment" class="button button-contactForm btn_1 boxed-btn" onclick="doSubmit()">댓글입력</button>
                                                <!-- 댓글 수정을 눌렀을 때만 버튼이 표시되도록 설정 -->
                                                <button type="button" id="editComment" style="display: none" class="button button-contactForm btn_1 boxed-btn" onclick="editCommentFn()">댓글수정</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="comments-area">
                                    <div class="comment-list">
                                        <a class="button button-contactForm btn_1 boxed-btn" href="javascript:doEdit();" style="width: 62px; height: 28px; padding: 0px">수정</a>
                                        <a class="button button-contactForm btn_1 boxed-btn" href="javascript:doDelete();" style="width: 62px; height: 28px; padding: 0px">삭제</a>
                                        <a class="button button-contactForm btn_1 boxed-btn" href="javascript:doList('<%=rDTO.getPost_category()%>');" style="width: 62px; height: 28px; padding: 0px">목록</a>
                                    </div>
                                </div>
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
<%@include file="../include/noticeInfo_script.jsp" %>
</body>
</html>