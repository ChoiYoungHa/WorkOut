<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
    String SS_MEMBER_ID = ((String)session.getAttribute("SS_MEMBER_ID"));
    List<NoticeDTO> rList =	(List<NoticeDTO>)request.getAttribute("rList");

//게시판 조회 결과 보여주기
    if (rList==null){
        rList = new ArrayList<NoticeDTO>();

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
    </script>
</head>
<body>
<h2>공지사항</h2>
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
        for (int i=0;i<rList.size();i++){
            NoticeDTO rDTO = rList.get(i);
            if (rDTO==null){
                rDTO = new NoticeDTO();
            }

    %>
    <tr>
        <td align="center">
            <a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getPost_id())%>');">
                <%=CmmUtil.nvl(rDTO.getPost_title()) %></a>
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
</body>
</html>