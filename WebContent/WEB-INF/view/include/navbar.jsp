<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<header>
    <!-- Header Start -->
    <div class="header-area header-transparent">
        <div class="main-header ">
            <div class="header-bottom  header-sticky">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <!-- Logo -->
                        <div class="col-xl-2 col-lg-2">
                            <div class="logo">
                                <a href="/test.do"><img src="/resource/boots/hosting_tp/assets/img/logo/workout_logo_test.png" style="width: 150px" height="85px" alt=""></a>
                            </div>
                        </div>
                        <div class="col-xl-10 col-lg-10">
                            <div class="menu-wrapper d-flex align-items-center justify-content-end">
                                <!-- Main-menu -->
                                <div class="main-menu d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="/main.do">메인페이지</a></li>
                                            <li><a href="/pagingList.do?category=work">운동게시판</a></li>
                                            <li><a href="/pagingList.do?category=menu">식단게시판</a></li>
                                            <li><a href="contact.html">마이페이지</a></li>
                                            <% if (SS_MEMBER_ID == null) { %>
                                            <li><a href="/logIn.do">로그인</a></li>
                                            <%} else if (SS_MEMBER_ID != null) { %>
                                            <li><a href="/logOut.do">로그아웃</a></li>
                                            <%}%>
                                            <!-- Button -->
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                        <!-- Mobile Menu -->
                        <div class="col-12">
                            <div class="mobile_menu d-block d-lg-none"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Header End -->
</header>