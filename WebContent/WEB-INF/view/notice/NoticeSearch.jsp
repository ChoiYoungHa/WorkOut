<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
    String category = ((String)request.getAttribute("post_category")); // 어떤 게시판인지 게시판에 표기하기 위한 변수
    String category_hit = ((String)request.getAttribute("post_category")); // 인기 게시물 카테고리 구분
    String SS_MEMBER_ID = ((String)session.getAttribute("SS_MEMBER_ID")); // 회원마다 북마크 표시가 다르게 보여야 함.
    String keyword = ((String) request.getAttribute("keyword")); // 검색 키워드유지
    List<NoticeDTO> rList =	(List<NoticeDTO>)request.getAttribute("sList"); // 해당 카테고리에 맞는 게시물을 표시
    System.out.println("category = " + category);

//게시판 조회 결과 보여주기
    if (rList==null){
        rList = new ArrayList<>();
    }

    if (category.equals("work")) {
        category = "운동";
    }else {
        category = "식단";
    }
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>공지 리스트</title>
    <script src="https://kit.fontawesome.com/285f83e94b.js" crossorigin="anonymous"></script>
    <script src="/resource/js/jquery-3.4.1.min.js"></script>

    <script type="text/javascript">
        const clicked_class = "fas";

        //상세보기 이동
        function doDetail(seq){
            location.href="/notice/NoticeInfo.do?nSeq="+ seq;
        }

        function iClickHandler(e, post_id) {
            // e.classList.toggle("far");
            // e.classList.toggle("fas");
            const hasClass = e.classList.contains(clicked_class);

            if (!hasClass) { // 북마크 등록
                e.classList.add(clicked_class); // 빨간하트
                console.log(post_id)
                $.ajax({
                    //function을 실행할 url
                    url : "/notice/bookmark_insert.do",
                    type : "post",
                    dataType : "json",
                    data : {
                        "post_id": post_id,
                        "member_id": "<%=SS_MEMBER_ID%>"
                    },
                    success : function(data) {
                        if (data == 1) { // 북마크가 성공적으로 완료된다면
                            alert("이 게시물을 좋아합니다.");
                        }
                    }
                })
            } else { // 북마크 제거
                e.classList.remove(clicked_class); // 빈 하트
                console.log("빈 하트");
                $.ajax({
                    //function을 실행할 url
                    url : "/notice/bookmark_delete.do",
                    type : "post",
                    dataType : "json",
                    data : {
                        "post_id": post_id
                    },
                    success : function(data) {
                        if (data == 1) { // 북마크가 성공적으로 취소된다면
                            alert("취소 되었습니다.");
                        }
                    }
                })
            }
        }
    </script>
</head>
<body>
<h2><%=category%>게시판</h2>
<hr/>
<!-- search{s} -->
<div class="form-group row justify-content-center">
    <form action="/notice/searchBoard.do" method="GET">
    <div class="w100" style="padding-right:10px">
        <select class="form-control form-control-sm" name="searchType" id="searchType">
            <option value="title">제목</option>
            <option value="member_nic">닉네임</option>
        </select>
    </div>
    <div class="w300" style="padding-right:10px">
        <input type="text" class="form-control form-control-sm" name="keyword" id="keyword" value="<%=keyword%>">
        <input type="hidden" id="category" name="category" value="<%=category_hit%>">
    </div>
    <div>
        <input class="btn btn-sm btn-primary" type="submit" value="검색" />
    </div>
    </form>
</div>
<!-- search{e} -->
<hr/>


<br/>
<table border="1" width="600px">
    <tr>
        <td width="200" align="center">제목</td>
        <td width="100" align="center">조회수</td>
        <td width="100" align="center">추천수</td>
        <td width="100" align="center">작성자</td>
    </tr>
    <%
        int i =0;
        for (;i<rList.size();i++){
            NoticeDTO rDTO = rList.get(i);
            if (rDTO==null){
                rDTO = new NoticeDTO();
            }
    %>
    <tr>
        <td align="center">
            <a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getPost_id())%>');">
                <%=CmmUtil.nvl(rDTO.getPost_title()) %></a><i onclick="iClickHandler(this, '<%=rDTO.getPost_id()%>');" class="far fa-heart" id="<%=rDTO.getPost_id()%>"></i>
        </td>
        <td align="center"><%=rDTO.getPost_view() %></td>
        <td align="center"><%=rDTO.getPost_recom() %></td>
        <td align="center"><%=rDTO.getMember_nic() %></td>
    </tr>
    <%
        }
    %>
</table>
<a href="/notice/insertPage.do">[글쓰기]</a>
<a href="/index.do">[메인]</a>
<script type="text/javascript">
    function init(){
        console.log("bookmark check!");
        $.ajax({
            //function을 실행할 url
            url : "/notice/bookmark_find.do",
            type : "post",
            dataType : "json",
            data : {
                "member_id": "<%=SS_MEMBER_ID%>"
            },
            success : function(data) { // 북마크된 게시물의 번호를 받아오고, 번호에 해당하는 것은 빨간하트
                console.log(data);
                const clicked_class = "fas";

                var i_list = document.querySelectorAll("i"); // i 태그를 list로 모두 담음
                var i;
                for (i = 0; i < i_list.length; i++) { // 게시물 수 만큼
                        if (data.includes(i_list[i].id)) { // 받아온 post_id에 해당하는 게시물이 있는지 확인
                            i_list[i].classList.add(clicked_class);
                        }
                }
            }
        })
    }
    init(); // 로드되는 순간 ajax 돌면서 북마크했는지 안했는지 구별해주자. body 에 쓴 이유는 쿼리셀렉터 때문이다.
</script>
<link rel="stylesheet" href="/resources/css/bootstrap.css"/>
<script src="/resources/js/bootstrap.js"></script>
</body>
</html>