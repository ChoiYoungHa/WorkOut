<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
    const clicked_class = "fas";

    //상세보기 이동
    function doDetail(seq){
        location.href="/notice/NoticeInfo.do?nSeq="+ seq;
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

                // 레디스에서 저장된 데이터 html로 꾸미고 데이터 표시
                $("#search_box").html(searchList);
                $("#search_box").css("color", "white");
                $("#search_box").show();
            }
        })
    }

    // 검색창을 클릭했을때,  최근검색어 리스트 제공
    $("#keyword").on("click", function () {
            $.ajax({
                url: "/getSearchList.do",
                type: "post",
                success: function (data) {
                    var searchArr = new Array();
                    // 검색어 값들을 for문을 통해 배열에 저장
                    for (let i = data.length - 1; i >= 0; i--) {
                        searchArr.push(data[i]);
                    }
                    // remove() 요소 자체를 지움, empty 요소의 내용을 지움 -> empty()로 검색어 리스트(내용)를 지움
                    $("#list").empty();
                    console.log("기존 검색어 지우기 완료!");
                    // 최근검색어가 없을 경우에는 제공하지 않음(length가 0이 아닐때만 검색어 제공)
                    if (searchArr.length != 0) {
                        for (let i = 0; i < searchArr.length; i++) {
                            var searchKeyword = searchArr[i];
                            console.log("검색한 키워드 값 : " + searchKeyword);
                            // 검색어 목록을 list에 append 함
                            $("#list").append('<li class="font" style="color: white;" id="' + i + '" onclick="insertKeyword(' + i + ')" >' + searchKeyword + '</li>');
                        }
                        $("#list").append('<button class="btn-danger" style="width:30px; height: 30px; border-style: none; border-radius: 40%; background-color: #d0a7e4; vertical-align: middle" onclick="rmKeyword()">X</button>');
                        $("#searchHistory").show();
                    }
                }
            })
    })

    // 최근검색어 클릭 시, 검색어창에 자동 입력되게 하는 함수
    function insertKeyword(keyword) {
        console.log("insertKeyword() 함수 호출!");
        var insertKeyword = keyword;
        console.log("받아온 검색어 : " + insertKeyword);
        var value = document.getElementById(insertKeyword).innerHTML;
        console.log("받아온 검색어2 : " + value);
        // 클릭한 최근검색어를 검색창에 자동 입력되도록 설정
        $('input[name=keyword]').attr('value', value);
        console.log("검색어 입력 성공!");
    }

    // 최근검색어 창 없애기(X)
    function rmKeyword() {
        $("#searchHistory").hide();
        $("#list").empty();
        $('input[name=keyword]').attr('value', "");
        console.log("검색어 창 벗어나면 숨기기 + 기존 요소 지움!");
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

<style>
    .toSmall {
        width: 30px;
        height: 30px;
        padding:0px;
    }
    
    .font:hover {
        cursor: pointer;
    }
</style>