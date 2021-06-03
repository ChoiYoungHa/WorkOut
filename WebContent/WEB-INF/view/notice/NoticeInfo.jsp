<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page import="poly.dto.MemberDTO" %>

<%
    NoticeDTO rDTO = (NoticeDTO)request.getAttribute("rDTO"); // 게시물에 관한 정보
    MemberDTO find_member = (MemberDTO)request.getAttribute("find_member"); // 작성자 회원에 관한 정보

//공지글 정보를 못불러왔다면, 객체 생성
    if (rDTO==null){
        rDTO = new NoticeDTO();
    }

    String SS_MEMBER_ID = CmmUtil.nvl((String)session.getAttribute("SS_MEMBER_ID")); // 현재 로그인한 사용자
    String SS_MEMBER_NIC = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_NIC")); // 현재 로그인한 사용자의 닉네임 (댓글사용)
//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    int edit = 1;

//로그인 안했다면....
    if (SS_MEMBER_ID.equals("")){
        edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
    }else if (SS_MEMBER_ID.equals(rDTO.getMember_member_id())){
        edit = 2;
    }

    System.out.println("SS_MEMBER_ID : " +SS_MEMBER_ID); // 로그인중인 사용자 ID
    System.out.println("member_id = " + rDTO.getMember_member_id()); // 게시글 작성자 ID
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시판 글보기</title>
    <script src="/resource/js/jquery-3.4.1.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            // 댓글 리스트 가져오기
            getComment();
        });

        // 게시물 수정하기
        function doEdit(){
            if ("<%=edit%>"==2){
                location.href="/notice/NoticeEditInfo.do?nSeq=<%=rDTO.getPost_id()%>";

            }else if ("<%=edit%>"==3){
                alert("로그인 하시길 바랍니다.");

            }else {
                alert("본인이 작성한 글만 수정 가능합니다.");
            }
        }
        //게시물 삭제하기
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
                location.href="/pagingList.do?category=work";
            }else {
                location.href="/pagingList.do?category=menu";
            }
        }



        /**
         *  해당하는 게시물의 댓글 리스트 가져오기
         */
        function getComment() {
            $.ajax({
                //function을 실행할 url
                url: "/notice/find_comment.do",
                type: "post",
                dataType: "json",
                data: {
                    "post_id": '<%=rDTO.getPost_id()%>'
                },
                success: function (json) {
                    console.log(json);
                    let comment_list = "";

                    if (json.length == 0){
                        comment_list = "<div class=col>해당 게시물에 대한 댓글이 없습니다.</div>";
                    }

                    for (let i=0; i<json.length; i++) {
                        let comment_id = json[i].comment_id;
                        console.log("받아온 댓글번호 : " + comment_id);

                        comment_list += '<div>';
                        comment_list += ("작성자 : " + json[i].member_nic+"<br>");
                        comment_list += (json[i].comment_ct+"<br>");

                        // 본인이 작성한 댓글인 경우에만 수정, 삭제할 수 있도록 수정, 삭제 버튼을 표시함
                        if ('<%=SS_MEMBER_NIC%>' == json[i].member_nic)
                        {
                            console.log("본인이 작성한 댓글이면 버튼표시");
                            comment_list += '<button type="button" class="btn btn-info" onclick="editForm(' + comment_id + ')">수정</button>';
                            comment_list += '<button type="button" class="btn btn-danger" onclick="delComment(' + comment_id + ')">삭제</button><br>';
                        }
                        comment_list += '</div>';
                    }
                    $("#comment_list").html(comment_list);
                }

            });
        }

        /**
         * 댓글 수정을 위해 기존 댓글 불러오기
         * */
        function editForm(comment_id) {
            console.log("수정할 댓글 번호(comment_no) : " + comment_id);
            $.ajax({
                url : "/getCommentDetail.do",
                type : "post",
                dataType : "JSON",
                data : {
                    "comment_id" : comment_id
                },
                success : function(res) {
                    console.log("받아온 댓글 DTO 정보(json) : " + res);

                    /**
                     * 수정 체크 시, 기존 댓글 등록을 실행하면 새로운 댓글로 등록되기 때문에,
                     * 새로운 edit (댓글 수정) 버튼을 만들어서 기존의 등록 버튼을 지우고 수정 버튼을 보여준다.
                     * */

                    document.getElementById("regComment").style.display = "none";
                    document.getElementById("editComment").style.display = "block";
                    console.log("기존 등록 버튼 대신 수정 버튼 띄우기 성공!");

                    var originalComment = res.comment_ct;
                    var comment_id = res.comment_id;
                    console.log("기존 댓글 내용, 댓글 번호 : " + originalComment + comment_id);

                    // 기존 댓글 박스에(textarea) 기존 댓글을 넣고,
                    // button value값에 수정할 댓글 번호 값을 넣음.
                    var commentBox = document.getElementById("comment");
                    var editBtn = document.getElementById("editComment");
                    commentBox.value = originalComment;
                    editBtn.value = comment_id;
                }
            })
        }


        /**
         * 댓글 수정 로직
         * */
        function editComment() {
            var comment = document.getElementById("comment").value;
            // 수정 버튼에 value로 등록되어 있는 comment_id 댓글번호를 가져옴
            var editBtn = document.getElementById("editComment");
            var comment_id = editBtn.value;
            console.log("댓글 번호 가져왔는지 : " + comment_id);
            // 댓글이 입력되지 않았다면,
            if (comment == "") {
                alert("댓글을 입력해 주세요.");
                $("#comment").focus();
                return false;
            }
            if (calBytes(comment) > 3000) {
                alert("댓글은 최대 3000Bytes 까지 입력 가능합니다.");
                $("#comment").focus();
                return false;
            }
            else {
                // 댓글 수정 ajax 로직 진행
                $.ajax({
                    url : "/editComment.do",
                    type : "post",
                    dataType : "JSON",
                    data : {
                        "comment" : comment,
                        "comment_id" : comment_id,
                    },
                    // 성공했다면(data == 1, 수정 성공)
                    success : function(data) {
                        console.log("수정 성공! data가 1이라면 성공" + data);
                        if (data == 1) {
                            alert("댓글을 수정했습니다.");
                            // 댓글 목록 새로 가져오기
                            getComment();
                            // 수정을 위해 "등록(댓글 새로 insert)"과 "수정(댓글 내용 불러와서 edit)" 버튼을 바꿨으므로,
                            // 등록이 완료된 후 다시 화면에 새로운 댓글 등록창을 표시
                            document.getElementById("regComment").style.display = "block";
                            document.getElementById("editComment").style.display = "none";
                            // 댓글이 수정되었다면, 기존 입력창에 썼던 내용을 초기화(placeholder만 남는다.)
                            document.getElementById("comment").value = "";
                        } else if (data == 0) {
                            alert("댓글 수정에 실패했습니다.");
                            return false;
                        }
                    },
                    // error catch!
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("에러 발생! \n" + textStatus + ":" + errorThrown);
                        console.log(errorThrown);
                    }
                })
            }
        }


        /** 댓글 삭제하기(해당 글에 대한 댓글번호를 함수 호출 시 파라미터로 전달하여,
         * ajax로 해당 댓글을 삭제한다.(삭제 or 수정 후 getComment() 불러오기)
         */
        function delComment(comment_id) {
            console.log("삭제할 댓글 번호(comment_no) : " + comment_id);
            var delConfirm = "댓글을 삭제하시겠습니까?";
            if (confirm(delConfirm)) {
                // 본인이 작성한 댓글에 대해서만 수정, 삭제 버튼이 표시되기 때문에 바로 ajax 삭제 진행
                $.ajax({
                    url : "/deleteComment.do",
                    type : "post",
                    data :
                        {
                            "comment_id" : comment_id
                        },
                    success: function(data) {
                        console.log(data);
                        if (data == 1) {
                            alert("삭제에 성공했습니다.");
                            // 댓글 목록 불러오기
                            getComment();
                        } else if (data == 0) {
                            alert("삭제에 실패했습니다.");
                        }
                    },
                    // error catch!
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("에러 발생! \n" + textStatus + ":" + errorThrown);
                        console.log(errorThrown);
                    }
                }) // ajax 끝
            } // confirm 끝
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
                            // 댓글이 등록되었다면, 기존 입력창에 썼던 내용을 초기화(placeholder만 남는다.)
                            document.getElementById("comment").value = "";
                            getComment(); // 등록된 후 바로 댓글 리스트 가져오기
                        } else if (data == 0) { // 등록에 실패하면
                            console.log("댓글 등록에 실패함")
                            return false;
                        }
                    },
                    // error catch!
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("에러 발생! \n" + textStatus + ":" + errorThrown);
                        console.log(errorThrown);
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
<div class="container">
<div>
    <div class="row">
        <div class="col-4">제목</div>
        <div class="col-8"><%=rDTO.getPost_title()%></div>
    </div>
    <div class="row">
        <div class="col-4">조회수</div>
        <div class="col-8"><%=rDTO.getPost_view()%></div>
    </div>
    <div class="row">
        <div class="col-4">작성자</div>
        <div class="col-8"><%=find_member.getMember_nic()%></div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-4">
            <%=rDTO.getContent().replaceAll("\r\n", "<br/>")%>
        </div>
    </div>
    <hr/>
    <!-- 댓글 -->
    <!-- 댓글 상단에 하나씩 댓글리스트 출력-->
    <div class="row">
        <div id="comment_list"></div>
    </div>
    <!-- 댓글 작성란-->
    <div class="row">
        <div class="col"><%=SS_MEMBER_NIC%></div>
    </div>
    <div class="row">
        <div class="col">
            <textarea name="comment" id="comment" style="width: 200px; height: 100px" valign="top" placeholder="댓글을 남겨보세요"></textarea>
        </div>
    </div>
        <div class="row">
        <div class="col">
            <button type="button" class="btn btn-info" id="regComment" value="등록" onclick="doSubmit()">댓글등록</button>
            <!-- 댓글 수정을 눌렀을 때만 버튼이 표시되도록 설정 -->
            <button type="button" class="btn btn-info" id="editComment" onclick="editComment()" style="display: none">댓글 수정</button>
        </div>
        </div>
</div>
</div>

    <div class="row">
        <div class="col" colspan="4">
            <a href="javascript:doEdit();">[수정]</a>
            <a href="javascript:doDelete();">[삭제]</a>
            <a href="javascript:doList('<%=rDTO.getPost_category()%>');">[목록]</a>
        </div>
    </div>
</div>
</div>
<link rel="stylesheet" href="/resources/css/bootstrap.css"/>
<script src="/resources/js/bootstrap.js"></script>
</body>
</html>