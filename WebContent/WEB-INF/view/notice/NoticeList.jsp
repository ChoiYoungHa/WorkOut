<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
    String category = ((String)request.getAttribute("post_category"));
    String SS_MEMBER_ID = ((String)session.getAttribute("SS_MEMBER_ID"));
    List<NoticeDTO> rList =	(List<NoticeDTO>)request.getAttribute("rList");
    System.out.println("category = " + category);


//게시판 조회 결과 보여주기
    if (rList==null){
        rList = new ArrayList<NoticeDTO>();
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
    <script type="text/javascript">
        //상세보기 이동
        function doDetail(seq){
            location.href="/notice/NoticeInfo.do?nSeq="+ seq;
        }

        function iClickHandler(e) {

            e.classList.toggle("far");
            e.classList.toggle("fas");

        }


    </script>
    <script src="https://kit.fontawesome.com/285f83e94b.js" crossorigin="anonymous"></script>
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
</head>
<body>
<h2><%=category%>게시판</h2>
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
                <%=CmmUtil.nvl(rDTO.getPost_title()) %></a><i onclick="iClickHandler(this);" class="far fa-heart" id="<%=i%>"></i>
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
</body>
<%--<script type="text/javascript">--%>
<%--        // var bt = document.querySelectorAll("i.far fa-heart"); // get all buttons with the class--%>
<%--        // console.log(bt)--%>
<%--        var bt = <%=i%>;--%>
<%--        console.log(bt)--%>
<%--            var temp = document.getElementById(i);--%>
<%--            console.log(temp);--%>
<%--            temp.onclick=function() { // assign anonymous handler--%>
<%--                console.log(temp);--%>
<%--                temp.classList.toggle('fas fa-heart');--%>
<%--                // if(temp.className == 'far'){--%>
<%--                //     temp.classList.remove('far');--%>
<%--                //     temp.classList.add('fas');--%>
<%--                //     console.log("동작");--%>
<%--                // }--%>
<%--                // else{--%>
<%--                //     temp.classList.remove('fas');--%>
<%--                //     temp.classList.add('far');--%>
<%--                //     console.log("동작");--%>
<%--                // }--%>
<%--                // console.log("하트 바꾸기")--%>
<%--                // temp.toggleClass('fas fa-heart');--%>
<%--        }--%>
<%--</script>--%>

<%--<script type="text/javascript">--%>
<%--    $('#heart').click(function() {--%>
<%--        $(this).toggleClass('far fa-heart');--%>
<%--        $(this).toggleClass('fas fa-heart');--%>
<%--    });--%>
<%--</script>--%>
</html>