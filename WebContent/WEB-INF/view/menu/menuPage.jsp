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
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="/resources/css/bootstrap.css"/>
    <script src="/resources/js/bootstrap.js"></script>
    <style>
        #content_left_box {
            border: 1px solid red;
            width: 600px;
            height: 640px;
        }

        #content_right_box {
            border: 1px solid red;
            width: 600px;
            height: 640px;
        }

        @media screen and (min-width: 676px) {
            .modal-dialog {
                max-width: 1200px; /* New width for default modal */
            }
        }

        #food_list_head{
            text-align: center;
        }

        #food_list{
            border: 1px solid red;
            height: 550px;
            margin-top: 15px;
        }

        #right_one{
            border: 1px solid red;
            height: 180px;
            margin-top: 20px;
        }
        #right_two{
            border: 1px solid red;
            height: 180px;
            margin-top: 20px;
        }
        #right_three{
            border: 1px solid red;
            height: 180px;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        #amount {
            all: unset;
            text-align: center;
        }
        #amount_box{
            margin-left: 180px;
        }
    </style>
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

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <div>
                    <div>
                        <select name="modal_searchType" id="modal_searchType">
                            <option value="food_name">음식이름</option>
                            <option value="food_maker">브랜드</option>
                        </select>
                        <input type="text" id="modal_keyword" />
                        <button class="button-bar" type="button" value="검색" onclick="clickFoodList()">검색</button>
                    </div>
                </div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- content box left-->
                <div class="container">
                    <div class="row">
                        <!--모달 왼쪽 박스 -->
                        <div class="col-lg-6" id="content_left_box">
                            <div id="food_list_head"><h3>음식목록</h3></div>
                            <div id="food_list">
                                <div id="searchList"></div>
                                <div id="paging"></div>
                            </div>
                        </div>
                        <!--모달 오른쪽 박스 -->
                        <div class="col-lg-6" id="content_right_box">
                            <div id="right_one">
                                <div id="tan"></div>
                                <input type="hidden" id="foodName">
                                <input type="hidden" id="foodBrand">
                                <input type="hidden" id="foodGram">
                                <input type="hidden" id="foodKcal">
                                <input type="hidden" id="foodTan">
                                <input type="hidden" id="foodDan">
                                <input type="hidden" id="foodFat">
                            </div>
                            <div id="right_two">
                                <br>
                                <div><h3 style="text-align: center">개수</h3></div>
                                <br>
                                <div id="amount_box">
                                <input type="text" id="amount" value="1">
                                </div>
                                <hr>
                            </div>
                            <div id="right_three">
                                <div>
                                    <select name="modal_food_time" id="modal_food_time">
                                        <option value="morning">아침</option>
                                        <option value="lunch">점심</option>
                                        <option value="dinner">저녁</option>
                                    </select>
                                </div>
                                <div>
                                    <br>
                                    <hr>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick=saveFoodList()>등록</button>
            </div>
        </div>
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
            <input type="text" id="keyword" data-target="#exampleModalCenter" data-toggle="modal"/>
            <button class="button-bar" type="button" value="검색">검색</button>
        </div>
</div>
<!-- search{e} -->
<%--<div id="searchList"></div>--%>
<%--<div id="paging"></div>--%>

<div class="container">
    <!--음식 정보출력 및 등록(아침, 점심, 저녁 선택) / db 저장시키기 / 아침 점심 저녁 메뉴기억해두기 -->
    <div class=""></div>
</div>

<script type="text/javascript">

    // 엔터쳤을 때,
    document.querySelector('#modal_keyword').addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            let searchType =$("#modal_searchType").val();
            let keyword = $("#modal_keyword").val();

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
        let searchType =$("#modal_searchType").val();
        let keyword = $("#modal_keyword").val();

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

    // 페이징, 페이징 번호 선택, 음식선택 함수
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
            foodList += data.I2790.row[i].SERVING_SIZE + "g" + "  "// 음식량
            foodList += data.I2790.row[i].NUTR_CONT1 +"kcal"+ "<br>"// 칼로리
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

            console.log("food_name : " + food_name);
            console.log("food_brand : " + food_brand);
            console.log("food_gram : " + food_gram);
            console.log("food_kcal : " + food_kcal);
            console.log("tan : " + tan);
            console.log("dan : " + dan);
            console.log("fat : " + fat);

            innerFoodData(tan,dan,fat,food_name,food_brand,food_kcal,food_gram);

            $('#foodName').val(food_name);
            $('#foodBrand').val(food_brand);
            $('#foodGram').val(food_gram);
            $('#foodKcal').val(food_kcal);
            $('#foodTan').val(tan);
            $('#foodDan').val(dan);
            $('#foodFat').val(fat);

            // hidden input에서 가져온 데이터 확인 후, ajax로 controller로 넘겨주면 됨.
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

        // 페이지번호를 클릭했을 때
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
<script type="text/javascript">
    function innerFoodData(tan,dan,fat,food_name,food_brand,food_kcal,food_gram){
        console.log("tan : " + tan)
        console.log("dan : " + dan)
        console.log("fat : " + fat)

        var html = "음식이름 : " + food_name + "<br>" + "제조사 : " + food_brand + "<br>" +
            "칼로리 : "+ food_kcal + "kcal" + "<br>" + "용량 : " + food_gram + "g" + "<br>" +
            "탄수화물 : " + tan + "g" + "<br>" + "단백질 : " + dan + "g" + "<br>" + "지방 : " + fat + "g";
        $("#tan").html(html);

    }
    // // api 정보 받아오기
    // String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID"));
    // String food_time = CmmUtil.nvl(request.getParameter("food_time")); // 섭취 시간
    // String food_name = CmmUtil.nvl(request.getParameter("food_name")); // 음식 이름
    // String food_gram = CmmUtil.nvl(request.getParameter("food_gram")); // 음식 량
    // String food_kcal = CmmUtil.nvl(request.getParameter("food_kcal")); // 음식 칼로리
    // String tan = CmmUtil.nvl(request.getParameter("tan")); // 탄수화물
    // String dan = CmmUtil.nvl(request.getParameter("dan")); // 단백질
    // String fat = CmmUtil.nvl(request.getParameter("fat")); // 지방
    // String amount = CmmUtil.nvl(request.getParameter("amount")); // 수량
    //
    function saveFoodList(){
        var food_name = $('#foodName').val();
        var food_brand = $('#foodBrand').val();
        var food_gram = $('#foodGram').val();
        var food_kcal = $('#foodKcal').val();
        var tan = $('#foodTan').val();
        var dan = $('#foodDan').val();
        var fat = $('#foodFat').val();

        console.log(food_name);
        console.log(food_brand);
        console.log(food_gram);
        console.log(food_kcal);
        console.log(tan);
        console.log(dan);
        console.log(fat);
    }


</script>
</body>
</html>
