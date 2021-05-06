<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<%@ page import="poly.util.CmmUtil" %>
<%
    request.setCharacterEncoding("euc-kr");
    String SS_MEMBER_NAME = CmmUtil.nvl((String)session.getAttribute("SS_MEMBER_NAME"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>게시판 글쓰기</title>

    <script type="text/javascript">
        //로그인 여부 체크
        function doOnload(){
            var user_id = "<%=SS_MEMBER_NAME%>";

            if (user_id==""){
                alert("로그인된 사용자만 글을 쓸 수 있습니다.");
                top.location.href="/notice/NoticeList.do";
            }
        }
        //전송시 유효성 체크
        function doSubmit(f){
            if(f.title.value == ""){
                alert("제목을 입력하시기 바랍니다.");
                f.title.focus();
                return false;
            }

            if(calBytes(f.title.value) > 200){
                alert("최대 200Bytes까지 입력 가능합니다.");
                f.title.focus();
                return false;
            }

            if(f.contents.value == ""){
                alert("내용을 입력하시기 바랍니다.");
                f.contents.focus();
                return false;
            }

            if(calBytes(f.contents.value) > 5000){
                alert("최대 5000Bytes까지 입력 가능합니다.");
                f.contents.focus();
                return false;
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
<body onload="doOnload();">
<form name="f" method="post" action="/notice/NoticeInsert.do" target= "ifrPrc" onsubmit="return doSubmit(this);">
    <table border="1">
        <col width="100px" />
        <col width="500px" />
        <tr>
            <td align="center">제목</td>
            <td><input type="text" name="title" maxlength="100" style="width: 450px" /></td>
        </tr>
        <tr>
            <td align="center">게시판 선택</td>
            <td>
                <select id="category" name="category" class="custom-select custom-select-lg mb-3" style="background-color:lightskyblue; text-align:center;font-weight:bold;">
                <option value="menu">식단게시판</option>
                <option value="work">운동게시판</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <textarea name="contents" style="width: 550px; height: 400px"></textarea>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <input type="submit" value="등록" />
                <input type="reset" value="다시 작성" />
            </td>
        </tr>
    </table>
</form>
<!-- 프로세스 처리용 iframe / form 태그에서 target을 iframe으로 한다. -->
<iframe name="ifrPrc" style="display:none"></iframe>
</body>
</html>