<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page import="poly.dto.MemberDTO" %>

<%
    NoticeDTO rDTO = (NoticeDTO)request.getAttribute("rDTO"); // 게시물에 관한 정보
    MemberDTO find_member = (MemberDTO)request.getAttribute("find_member"); // 회원에 관한 정보


//공지글 정보를 못불러왔다면, 객체 생성
    if (rDTO==null){
        rDTO = new NoticeDTO();
    }

    String SS_MEMBER_ID = CmmUtil.nvl((String)session.getAttribute("SS_MEMBER_ID")); // 현재 로그인한 사용자
//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    int edit = 1;

//로그인 안했다면....
    if (SS_MEMBER_ID.equals("")){
        edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
    }else if (SS_MEMBER_ID.equals(rDTO.getMember_member_id())){
        edit = 2;
    }

    System.out.println("SS_MEMBER_ID : " +SS_MEMBER_ID);
    System.out.println("member_id = " + rDTO.getMember_member_id());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시판 글보기</title>
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        //수정하기
        function doEdit(){
            if ("<%=edit%>"==2){
                location.href="/notice/NoticeEditInfo.do?nSeq=<%=rDTO.getPost_id()%>";

            }else if ("<%=edit%>"==3){
                alert("로그인 하시길 바랍니다.");

            }else {
                alert("본인이 작성한 글만 수정 가능합니다.");
            }
        }
        //삭제하기
        function doDelete(){
            if ("<%=edit%>"==2){
                if(confirm("작성한 글을 삭제하시겠습니까?")){
                    location.href="/notice/NoticeDelete.do?nSeq=<%=rDTO.getPost_id()%>";
                }

            }else if ("<%=edit%>"==3){
                alert("로그인 하시길 바랍니다.");

            }else {
                alert("본인이 작성한 글만 삭제 가능합니다.");

            }
        }
        //목록으로 이동
        function doList(category){

            if (category === 'work'){
                location.href="/notice/NoticeListCategory.do?category=work";
            }else {
                location.href="/notice/NoticeListCategory.do?category=menu";
            }
        }

        //댓글 전송시 유효성 체크
        function doSubmit(){
            const comment = document.querySelector("#comment");
            console.log(comment.value)

            if(comment.value == ""){
                alert("내용을 입력하시기 바랍니다.");
                comment.focus();
                return false;
            }

            if(calBytes(comment.value) > 3000){
                alert("최대 3000Bytes까지 입력 가능합니다.");
                comment.focus();
                return false;
            }

            //ajax 호출
            else {
                $.ajax({
                    //function을 실행할 url
                    url: "/notice/insert_comment.do",
                    type: "post",
                    dataType: "json",
                    data: {
                        "post_id": '<%=rDTO.getPost_id()%>',
                        "comment": comment.value
                    },
                    success: function (data) {
                        if (data == 1) { // 등록에 성공하면
                            alert("댓글이 등록되었습니다.");
                        } else if (data == 0) { // 등록에 실패하면
                            console.log("댓글 등록에 실패함")
                            return false;
                        }
                    }
                })
            }

        }

        //글자 길이 바이트 단위로 체크하기(바이트값 전달)
        function calBytes(str){

            var tcount = 0;
            var tmpStr = new String(str);
            var strCnt = tmpStr.length;
            var onechar;
            for (i=0;i<strCnt;i++){
                onechar = tmpStr.charAt(i);

                if (escape(onechar).length > 4){
                    tcount += 2;
                }else{
                    tcount += 1;
                }
            }
            return tcount;
        }
    </script>
</head>
<body>
<table border="1">
    <col width="100px" />
    <col width="200px" />
    <col width="100px" />
    <col width="200px" />
    <tr>
        <td align="center">제목</td>
        <td colspan="3"><%=rDTO.getPost_title()%></td>
    </tr>
    <tr>
        <td align="center">조회수</td>
        <td><%=rDTO.getPost_view()%></td>
    </tr>
    <tr>
        <td align="center">작성자</td>
        <td><%=find_member.getMember_nic()%></td>
    </tr>
    <tr>
        <td align="center">게시판</td>
        <td><%=rDTO.getPost_category()%></td>
    </tr>
    <tr>
        <td colspan="4" height="300px" valign="top">
            <%=rDTO.getContent().replaceAll("\r\n", "<br/>")%>
        </td>
    </tr>
    <!-- 댓글 -->
    <tr>
        <td align="center"><%=find_member.getMember_nic() %></td>
    </tr>
    <tr>
        <td>
            <textarea name="comment" id="comment" style="width: 200px; height: 100px" valign="top" placeholder="댓글을 남겨보세요"></textarea>
        </td>
    </tr>
        <tr>
        <td>
            <input type="button" value="등록" onclick="doSubmit()"/>
        </td>
        </tr>

    <tr>
        <td align="center" colspan="4">
            <a href="javascript:doEdit();">[수정]</a>
            <a href="javascript:doDelete();">[삭제]</a>
            <a href="javascript:doList('<%=rDTO.getPost_category()%>');">[목록]</a>
        </td>
    </tr>
</table>
</body>
</html>