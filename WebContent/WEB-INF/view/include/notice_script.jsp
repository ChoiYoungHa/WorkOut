<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
    const clicked_class = "fas";

    //상세보기 이동
    function doDetail(seq){
        location.href="/notice/NoticeInfo.do?nSeq="+ seq;
    }

    // 한 페이지당 게시물 보기 개수를 세팅하여 전달
    function selChange() {
        var sel = document.getElementById('cntPerPage').value;
        location.href = "/pagingList.do?category=<%=category_hit%>&nowPage=${paging.nowPage}&cntPerPage="+sel;
    }

    // 북마크 기능
    function iClickHandler(e, post_id) {
        // e.classList.toggle("far");
        // e.classList.toggle("fas");
        const hasClass = e.classList.contains(clicked_class);

        if (!hasClass) { // 북마크 등록
            e.classList.add(clicked_class); // 빨간하트
            console.log(post_id)
            $.ajax({
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

    // 최근 검색어 불러오기
    function getSearchList(){
        $.ajax({
            url : "/getSearchList.do",
            type : "post",
            success : function(data) {
                let searchList = "";
                for(let i = 0; i < data.length; i++){
                    searchList += data[i] + "<br>";
                }
                $("#search_box").html(searchList);
                $("#search_box").show();
            }
        })
    }

    // 검색창에서 포커스 벗어나면 최근검색어 감춤
    function removeSearchList(){
        $("#search_box").hide();
    }

</script>

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
                        i_list[i].classList.add(clicked_class); // 빨간하트로 변경
                    }
                }
            }
        })
    }
    init(); // 로드되는 순간 ajax 돌면서 북마크했는지 안했는지 구별해주자. body 에 쓴 이유는 쿼리셀렉터 때문이다.
</script>