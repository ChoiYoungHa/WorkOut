<%@ page import="poly.dto.NoticeDTO" %>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.Criteria" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String category = ((String)request.getAttribute("post_category")); // 어떤 게시판인지 게시판에 표기하기 위한 변수
    String category_hit = ((String)request.getAttribute("post_category")); // 인기 게시물 카테고리 구분
    String SS_MEMBER_ID = ((String)session.getAttribute("SS_MEMBER_ID")); // 회원마다 북마크 표시가 다르게 보여야 함.
    String keyword = ((String) request.getAttribute("keyword")); // 검색 키워드유지
    String searchType = (String) request.getAttribute("searchType"); // 검색 조건을 가지고 있어야 검색 후 페이징 처리가 가능함.
//    List<NoticeDTO> rList =	(List<NoticeDTO>)request.getAttribute("rList"); // 해당 카테고리에 맞는 게시물을 표시

//게시판 조회 결과 보여주기
//    if (rList==null){
//        rList = new ArrayList<>();
//    }

    if (category.equals("work")) {
        category = "운동";
    } else {
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
    <%@include file="../include/css.jsp" %>
</head>
<body>
<!-- Preloader Start -->
<%@ include file="../include/preloader.jsp" %>
<!-- Preloader End -->
<%@include file="../include/navbar.jsp" %>
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
                                <form action="/notice/searchBoard.do" class="search-box" style="width: 900px"
                                      method="GET">
                                    <div class="default-select mb-20 ml-lg-3">
                                        <select name="searchType" id="searchType">
                                            <option value="title">제목</option>
                                            <option value="member_nic">닉네임</option>
                                        </select>
                                    </div>
                                    <div class="input-form">
                                        <input type="text" name="keyword" id="keyword" placeholder="원하는 게시물을 찾아보세요">
                                        <div class="search-form mr-10">
                                            <button type="submit"><i class="ti-search"></i></button>
                                        </div>
                                        <!-- div로 최근검색어 리스트에 추가함 -->
                                        <div id="searchHistory" style="display:none;">
                                            <ul id="list"></ul>
                                        </div>
                                        <input type="hidden" id="category" name="category" value="<%=category_hit%>">
                                        <!-- icon search -->
                                        <div class="world-form">
                                            <i class="fas fa-globe"></i>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="row col-lg-12 justify-content-center mt-105"><h1><%=category%>게시판</h1></div>
                       </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <!-- About-1 Area End -->
    <!--? About-2 Area Start -->
    <div class="about-area1 pb-bottom pl-200 pr-200">
        <hr/>
        <%
            Criteria pDTO = (Criteria) request.getAttribute("paging");
            int nowPage = pDTO.getNowPage();
            int startPage = pDTO.getStartPage();
            int endPage = pDTO.getEndPage();
            int cntPerPage = pDTO.getCntPerPage();
            int lastPage = pDTO.getLastPage();
            int num = 1;
            List<NoticeDTO> pageList = (List<NoticeDTO>) request.getAttribute("pageList");
            System.out.println("pageList is null? " + (pageList == null));
            if (pageList == null) {
                pageList = new ArrayList<NoticeDTO>();
            }
        %>
        <div class="row col-lg-4 mb-20">
            <select id="cntPerPage" name="sel" onchange="selChange()">
                <option value="5" <%if (cntPerPage == 5) {%> selected <%}%>>5개씩 보기</option>
                <option value="10" <%if (cntPerPage == 10) {%> selected <%}%>>10개씩 보기</option>
                <option value="15" <%if (cntPerPage == 15) {%> selected <%}%>>15개씩 보기</option>
            </select>
        </div>


        <div class="row col-lg-12 justify-content-center mb-20">
            <div class="mr-20"><h2 class="font-weight-bold"><a href="/pagingList.do?category=<%=category_hit%>&nowPage=${paging.nowPage}" style="color: black">전체 게시물</a></h2></div>
            <div><h2 class="font-weight-bold"><a href="/pagingList.do?category=<%=category_hit%>&nowPage=${paging.nowPage}&sort=y" style="color: black">인기 게시물</a></h2></div>
        </div>


        <div class="progress-table-wrap">
            <div class="progress-table">
                <div class="table-head">
                    <div class="percentage ml-20" style="font-weight: bold">제목</div>
                    <div class="country" style="font-weight: bold">조회수</div>
                    <div class="visit" style="font-weight: bold">추천수</div>
                    <div class="serial" style="font-weight: bold">작성자</div>
                </div>
                <%
                    int i = 0;
                    for (; i < pageList.size(); i++) {
                        NoticeDTO rDTO = pageList.get(i);
                        if (rDTO == null) {
                            rDTO = new NoticeDTO();
                        }
                %>
                <div class="table-row">
                    <div class="percentage ml-20">
                        <a style="color: black" href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getPost_id())%>');"> <%=CmmUtil.nvl(rDTO.getPost_title()) %>
                        </a><i onclick="iClickHandler(this, '<%=rDTO.getPost_id()%>');" class="far fa-heart ml-10" id="<%=rDTO.getPost_id()%>"></i>
                    </div>
                    <div class="country"><%=rDTO.getPost_view() %></div>
                    <div class="visit"><%=rDTO.getPost_recom() %></div>
                    <div class="serial"><%=rDTO.getMember_nic() %></div>
                </div>
                <%}%>
            </div>
        </div>

        <div class="row justify-content-lg-end mt-20">
            <div class="mr-10 btn"><a href="/main.do" style="color: black">메인</a></div>
            <div class="mr-30 btn"><a href="/notice/insertPage.do" style="color: black">글쓰기</a></div>
        </div>

        <div class="row">
            <div class="row col-lg-4" id="paging">
                    <%if (startPage != 1) { %>
                        <div class="col-1 activeFocus"><a style="color: black" href="/pagingList.do?nowPage=<%=startPage - 1%>&cntPerPage=<%=cntPerPage%>&keyword=<%=keyword%>&searchType=<%=searchType%>&category=<%=category_hit%>"></a></div>
                            <%}%> <% for (int j = startPage; j <= endPage; j++) { %> <%
                                                if (j == nowPage) { %>
                <div class="col-1 activeFocus"><span><%=j%></span></div>
                    <%
                        }
                    %>
                    <%
                        if (j != nowPage) {
                    %>
                    <div class="col-1 activeFocus"><a style="color: black"
                                                      href="/pagingList.do?nowPage=<%=j%>&cntPerPage=<%=cntPerPage%>&keyword=<%=keyword%>&searchType=<%=searchType%>&category=<%=category_hit%>"><%=j%>
                    </a></div>
                    <%
                        }
                    %>
                    <%
                        }
                    %>
                    <%
                        if (endPage != lastPage) {
                    %>
                    <div class="col-1 activeFocus"><a style="color: black"
                            href="/pagingList.do?nowPage=<%=endPage + 1%>&cntPerPage=<%=cntPerPage%>&keyword=<%=keyword%>&searchType=<%=searchType%>&category=<%=category_hit%>"></a>
                    </div>
                    <%
                        }
                    %>
            </div>
        </div>
    </div>
    <!-- About-2 Area End -->
</main>

<style>
    .activeFocus {
        color: red;
        font-weight: bold;
    }
</style>
<%@include file="../include/footer.jsp" %>
<!-- Scroll Up -->
<div id="back-top">
    <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
</div>
<%@include file="../include/js.jsp" %>
<%@include file="../include/notice_script.jsp" %>
<script type="text/javascript">
    // 한 페이지당 게시물 보기 개수를 세팅하여 전달
    function selChange() {
        var sel = document.getElementById('cntPerPage').value;
        location.href = "/notice/searchBoard.do?category=<%=category_hit%>&keyword=<%=keyword%>&searchType=<%=searchType%>&nowPage=${paging.nowPage}&cntPerPage="+sel;
    }
</script>
</body>
</html>