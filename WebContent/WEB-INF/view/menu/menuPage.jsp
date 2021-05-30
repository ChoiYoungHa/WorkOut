<%@ page import="poly.util.CmmUtil" %><%--
  Created by IntelliJ IDEA.
  User: askil
  Date: 2021-05-05
  Time: 오후 3:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<%
    String member_gk = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_GK"));
%>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $("#popbutton").click(function(){
                $('div.modal').modal({remote : 'layer.html'});
            })
        })
    </script>
</head>
<body>
<label for="week-select">주차 별 칼로리 : </label>
<select name="week" id="week-select">
    <option value="1week">1주차</option>
    <option value="2week">2주차</option>
    <option value="3week">3주차</option>
    <option value="4week">4주차</option>
    <option value="5week">5주차</option>
    <option value="6week">6주차</option>
    <option value="7week">7주차</option>
</select>
<h2>목표 칼로리 : <%=member_gk%></h2>
<h2>섭취 칼로리 : </h2>
<button class="btn btn-default" id="popbutton">모달출력버튼</button><br/>
<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">

        </div>
    </div>
</div>
<!-- search{s} -->
<div>
        <div class="w100" style="padding-right:10px">
            <select name="searchType" id="searchType">
                <option value="food_name">음식이름</option>
                <option value="food_maker">브랜드</option>
            </select>
        </div>
        <div>
            <input type="text" id="keyword" />
            <button class="button-bar" type="button" value="검색" onclick="clickFoodList()">전송</button>
        </div>
</div>
<!-- search{e} -->
<div id="searchList"></div>
<div id="paging"></div>

<div class="container">
    <!--음식 정보출력 및 등록(아침, 점심, 저녁 선택) / db 저장시키기 / 아침 점심 저녁 메뉴기억해두기 -->

</div>

<script type="text/javascript">

    // 엔터쳤을 때,
    document.querySelector('#keyword').addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            let searchType =$("#searchType").val();
            let keyword = $("#keyword").val();

            let search = "";

            if (searchType === 'food_name'){
                search = "DESC_KOR";
            }else{
                search = "MAKER_NAME";
            }

            $.ajax({
                url : `http://openapi.foodsafetykorea.go.kr/api/d5388ab1d4d546a6b033/I2790/json/1/100/`+search+"="+keyword,
                type : "get",
                success : function(data) {
                    // 원하는 음식이 안나올 수 있어서 최대한 많은 데이터를 가져오고 페이징을 해야함.
                    // 각 요소마다 클릭되면 데이터가 저장될 수 있게 해야함.

                    paging(data.I2790.row.length, 1, data);


                }
            })
        }
    });

    // 검색버튼을 클릭했을 때,
    function clickFoodList(){
        let searchType =$("#searchType").val();
        let keyword = $("#keyword").val();

        let search = "";

        if (searchType === 'food_name'){
            search = "DESC_KOR";
        }else{
            search = "MAKER_NAME";
        }

        $.ajax({
            url : `http://openapi.foodsafetykorea.go.kr/api/d5388ab1d4d546a6b033/I2790/json/1/100/`+search+"="+keyword,
            type : "get",
            success : function(data) {
                // 원하는 음식이 안나올 수 있어서 최대한 많은 데이터를 가져오고 페이징을 해야함.
                // 각 요소마다 클릭되면 데이터가 저장될 수 있게 해야함.

                paging(data.I2790.row.length, 1, data);


            }
        })
    }

    function paging(totalData, currentPage, data){

        var dataPerPage = 10;    // 한 페이지에 나타낼 데이터 수
        var pageCount = 10;        // 한 화면에 나타낼 페이지 수

        console.log("currentPage 받아온 페이지 번호 : " + currentPage);

        var totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수
        var pageGroup = Math.ceil(currentPage/pageCount);    // 페이지 그룹

        console.log("pageGroup : " + pageGroup);

        var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호
        if(last > totalPage)
            last = totalPage;
        var first = last - (pageCount-1);    // 화면에 보여질 첫번째 페이지 번호
        if (first < 1){
            var first = currentPage - currentPage % pageCount + 1;  //하단 마지막 숫자
        }
        var next = last+1;
        var prev = first-1;

        console.log("last : " + last);
        console.log("first : " + first);
        console.log("next : " + next);
        console.log("prev : " + prev);


        var start = 0;
        var end = 0;

        // 리팩토링 예정
        if (currentPage == 1){
            start = 0;
            end = 9;
        }else if (currentPage == 2){
            start = 10;
            end = 19;
        }else if (currentPage == 3){
            start = 20;
            end = 29;
        }else if (currentPage == 4){
            start = 30;
            end = 39;
        }else if (currentPage == 5){
            start = 40;
            end = 49;
        }else if (currentPage == 6){
            start = 50;
            end = 59;
        }else if (currentPage == 7){
            start = 60;
            end = 69;
        }else if (currentPage == 8){
            start = 70;
            end = 79;
        }else if (currentPage == 9){
            start = 80;
            end = 89;
        }else if (currentPage == 10){
            start = 90;
            end = 99;
        }



        // for (var i = 1; i <= currentPage; i++) {
        //     start = start + 10;
        //     end = end + 10;
        //     if (i == currentPage){
        //         end = end - 1;
        //     }
        // }

        let foodList = "";
        console.log(data)
        for(var i = start; i <= end; i++){
            foodList += "<a href='#' id=" + i + ">" + data.I2790.row[i].DESC_KOR + "  " + "</a> "// 음식명
            foodList += data.I2790.row[i].MAKER_NAME  + "  " // 브랜드
            foodList += data.I2790.row[i].SERVING_SIZE  + "  "// 음식량
            foodList += data.I2790.row[i].NUTR_CONT1 + "<br>"// 칼로리
        }
        $('#searchList').html(foodList);
        $("#searchList a").css("color", "black");
        $("#searchList a").css({"text-decoration": "none"});

        $("#searchList a").click(function(){
            var $item = $(this);
            var $id = $item.attr("id");
            var id = $id;
            console.log(id);

            var food_name = data.I2790.row[id].DESC_KOR; // 음식이름
            var food_brand = data.I2790.row[id].MAKER_NAME // 음식 제조사
            var food_gram = data.I2790.row[id].SERVING_SIZE // 음식 량
            var food_kcal = data.I2790.row[id].NUTR_CONT1 // 음식 칼로리
            var tan = data.I2790.row[id].NUTR_CONT2 // 탄수화물
            var dan = data.I2790.row[id].NUTR_CONT3 // 단백질
            var fat = data.I2790.row[id].NUTR_CONT4 // 지방



        });

        var html = "";

        if(prev > 0)
            html += "<a href=# id='prev'><</a> ";

        for(var i=first; i <= last; i++){
            html += "<a href='#' id=" + i + ">" + i + "</a> ";
        }

        if(last < totalPage)
            html += "<a href=# id='next'>></a>";

        $("#paging").html(html);    // 페이지 목록 생성
        $("#paging a").css("color", "black");
        $("#paging a#" + currentPage).css({"text-decoration":"none",
            "color":"red",
            "font-weight":"bold"});    // 현재 페이지 표시

        $("#paging a").click(function(){

            var $item = $(this);
            var $id = $item.attr("id");
            var selectedPage = $item.text();

            if($id == "next")    selectedPage = next;
            if($id == "prev")    selectedPage = prev;

            paging(data.I2790.row.length, selectedPage, data);
        });

    }
</script>
</body>
</html>
