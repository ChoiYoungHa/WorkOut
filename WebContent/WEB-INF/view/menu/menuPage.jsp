<%@ page import="poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<%
    String member_gk = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_GK"));
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        #food_time{
            justify-content: space-around;
        }
        #food_morning_list{
            border: 1px solid red;
            height: 550px;
            width: 250px;
            margin-top: 15px;
        }
        #food_lunch_list{
            border: 1px solid red;
            height: 550px;
            width: 250px;
            margin-top: 15px;
        }
        #food_dinner_list{
            border: 1px solid red;
            height: 550px;
            width: 250px;
            margin-top: 15px;
        }
        #food_snack_list{
            border: 1px solid red;
            height: 550px;
            width: 250px;
            margin-top: 15px;
        }
        #food_info_box{
            display: flex;
            justify-content: center;
        }

        #food_info {
            border: 1px solid red;
            margin-top: 30px;
            width: 800px;
            height: 200px;
            justify-content: space-around;
            margin-bottom: 30px;
        }

        #food_recom_info{
            flex-direction : column-reverse;
            justify-content : space-between;
        }

        li{
            all:unset;
        }
        p {
            all: unset;
        }
        span{
            all:unset;
        }
    </style>
    <script type="text/javascript">

        function goal_kcal_ch(){
            let select = $('#week-select').val();
            let goal_kcal = <%=member_gk%>;

            if(select == '2week'){
                goal_kcal = Math.ceil(goal_kcal - goal_kcal * 0.1);
            }else if(select == '3week'){
                goal_kcal = Math.ceil(goal_kcal - goal_kcal * 0.15);
            }else if(select == '4week'){
                goal_kcal = Math.ceil(goal_kcal - goal_kcal * 0.2);
            }else if(select == '5week'){
                goal_kcal = Math.ceil(goal_kcal - goal_kcal * 0.25);
            }else if(select == '6week'){
                goal_kcal = Math.ceil(goal_kcal - goal_kcal * 0.3);
            }else if(select == '7week'){
                goal_kcal = Math.ceil(goal_kcal - goal_kcal * 0.35);
            }

            ca_kcal(goal_kcal);
            let html = "목표 칼로리 : " + goal_kcal;
            $("#goal_kcal").html(html);
        }

        function ca_kcal(kcal){
            let tan_kcal = Math.ceil(kcal * 0.5);
            let dan_kcal = Math.ceil(kcal * 0.3);
            let fat_kcal = Math.ceil(kcal * 0.2);

            let tan_gram = Math.ceil(tan_kcal / 4);
            let dan_gram = Math.ceil(dan_kcal / 4);
            let fat_gram = Math.ceil(fat_kcal / 9);

            let html = "<span>" + "탄수화물 : " + tan_gram + "g" + "</span>" + "<span>" + "단백질 : " + dan_gram + "g" + "</span>" +
                "<span>" + "지방 : " + fat_gram + "g" + "</span>";

            $('#food_recom_info').html(html);
        }
    </script>
</head>

<body>
<label for="week-select">주차 별 칼로리 : </label>
<select name="week" id="week-select" onchange="goal_kcal_ch()">
    <option value="1week">1주차</option>
    <option value="2week">2주차</option>
    <option value="3week">3주차</option>
    <option value="4week">4주차</option>
    <option value="5week">5주차</option>
    <option value="6week">6주차</option>
    <option value="7week">7주차</option>
</select>
<h2 id="goal_kcal">목표 칼로리 : <%=member_gk%></h2>
<h2 id="eat_kcal">섭취 칼로리 : </h2>

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
                                        <option value="snack">간식</option>
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick=saveFoodList()>등록</button>
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

<div class="container">
    <!--음식 정보출력 및 등록(아침, 점심, 저녁, 간식 선택) / db 저장시키기 / 아침 점심 저녁 메뉴기억해두기 / 저장한 내용 사용자에게 출력하기 -->
    <div class="row" id="food_time">
    <div id="morning_food" class="class=col-lg-3">
        <div id="food_morning_head"><h3 style="text-align: center">아침</h3></div>
        <div id="food_morning_list">
        </div>
    </div>
        <div id="lunch_food" class="class=col-lg-3">
            <div id="food_lunch_head"><h3 style="text-align: center">점심</h3></div>
            <div id="food_lunch_list">
            </div>
        </div>
        <div id="dinner_food" class="class=col-lg-3">
            <div id="food_dinner_head"><h3 style="text-align: center">저녁</h3></div>
            <div id="food_dinner_list">
            </div>
        </div>
        <div id="snack_food" class="class=col-lg-3">
            <div id="food_snack_head"><h3 style="text-align: center">간식</h3></div>
            <div id="food_snack_list">
            </div>
        </div>
    </div>
</div>

<!-- 추천 탄단지, 섭취 탄단지 정보 -->
<div class="container" id="food_info_box">
    <div class="row" id="food_info">
        <!-- 추천 탄단지 -->
        <div id="recom_info">
        <div id="food_recom_head"><h3>추천 탄단지</h3></div>
        <div id="food_recom_info" class="row"></div>
        </div>
        <!-- 섭취 탄단지 -->
        <div id="intake_info">
            <div id="food_intake_head"><h3>섭취 탄단지</h3></div>
            <div id="food_intake_info"></div>
        </div>
    </div>
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

            let replace = food_brand.replace(/\(주\)/i,'');

            $('#foodName').val(food_name);
            $('#foodBrand').val(replace);
            $('#foodGram').val(food_gram);
            $('#foodKcal').val(food_kcal);
            $('#foodTan').val(tan);
            $('#foodDan').val(dan);
            $('#foodFat').val(fat);

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

<!--식단 등록 및 삭제 섭취 식단 확인 -->
<script type="text/javascript">
    function innerFoodData(tan,dan,fat,food_name,food_brand,food_kcal,food_gram){

        var html = "음식이름 : " + food_name + "<br>" + "제조사 : " + food_brand + "<br>" +
            "칼로리 : "+ food_kcal + "kcal" + "<br>" + "용량 : " + food_gram + "g" + "<br>" +
            "탄수화물 : " + tan + "g" + "<br>" + "단백질 : " + dan + "g" + "<br>" + "지방 : " + fat + "g";
        $("#tan").html(html);
    }

    // 음식 선택 후 저장하고 사용자에게 표현
    function saveFoodList() {
        var food_name = $('#foodName').val();
        var food_brand = $('#foodBrand').val();
        var food_gram = $('#foodGram').val();
        var food_kcal = $('#foodKcal').val();
        var tan = $('#foodTan').val();
        var dan = $('#foodDan').val();
        var fat = $('#foodFat').val();
        var amount = $('#amount').val();
        var food_time = $("#modal_food_time option:selected").val();

        $.ajax({
            url: "/insertFood.do",
            type: "post",
            dataType: "json",
            data: {
                "food_name": food_name,
                "food_brand": food_brand,
                "food_gram": food_gram,
                "food_kcal": food_kcal,
                "tan": tan,
                "dan": dan,
                "fat": fat,
                "amount": amount,
                "food_time": food_time
            },
            success: function (data) {
                console.log(data);

                let food_name = data.food_name;
                let food_gram = data.food_gram;
                let food_kcal = data.food_kcal;
                let amount = data.amount;
                let food_time = data.food_time;

                $.ajax({
                    url: "/getFoodData.do",
                    type: "post",
                    success : function(data2) {
                        let dataLength = data2.length;
                        let food_data = "<li id=" + dataLength + ">" + "<hr>" + "<span>" + food_name + "    " + food_kcal + "kcal" +"</span>" +
                            "<br>" + "<p>" + food_gram + "g" + " " + amount + "개" + "</p>" + "<i class=" + "'far" + " " + "fa-minus-square'" +
                            "onclick='deleteFood(this)'" + dataLength +">" + "</i>" +
                            "<input type='hidden' value=" + food_time + ">" + "</li>";
                        $('#' + 'food_' + food_time + '_list').append(food_data);
                    }
                })
            }
        })
    }

    function init(){
        $.ajax({
            url : "/getFoodData.do",
            type : "post",
            success : function(data) {
                // 데이터 받아와서 회원에 따라 음식목록 append
                console.log(data);
                let end = data.length;
                for (let i = 0; i < end; i++) {
                    let food_time = data[i].food_time;
                    let food_name = data[i].food_name;
                    let food_kcal = data[i].food_kcal;
                    let food_gram = data[i].food_gram;
                    let amount = data[i].amount;

                    let food_data = "<li id=" + i +">" + "<hr>" + "<span>" + food_name + "    " + food_kcal + "kcal" +"</span>" + "<br>" + "<p>" + food_gram + "g" + " " + amount + "개" + "</p>" + "<i class=" + "'far" + " " + "fa-minus-square'" + "onclick='deleteFood(this)'" + ">" + "</i>" +
                        "<input type='hidden' value=" + food_time + ">" + "</li>";
                    $('#' + 'food_' + food_time + '_list').append(food_data);
                }
            }
        })
    }

    function deleteFood(e){

        // 부모요소에 접근 후 각 자식요소 데이터 추출
        let pa = e.parentNode;
        console.log(pa.childNodes[5].value); // 원하는 데이터 섭취시간

        // 자식요소의 데이터 공백단위로 정제
        let split_res = pa.childNodes[1].textContent.split("    ");
        let split_it = pa.childNodes[3].textContent.split(" ");
        console.log(split_res[1]); // 원하는 데이터 kcal
        console.log(split_it[0]); // 원하는 데이터 g

        // 필요한 데이터 정제
        let food_time = pa.childNodes[5].value;
        let food_kcal = split_res[1].replace(/kcal/,'');
        let food_gram = split_it[0].replace(/g/,'');

        // 클릭한 요소의 부모 element id 받아오기
        let temp_id = pa.id;
        console.log(temp_id);
        $('#'+temp_id).remove(); // 삭제

        // 서버로 전송
        $.ajax({
            url : "/deleteFoodData.do", // db 요소 삭제 로직작성
            type : "post",
            dataType : "json",
            data : {
                "food_time" : food_time,
                "food_kcal" : food_kcal,
                "food_gram" : food_gram
            }
        })
    }
    init();
    ca_kcal(<%=member_gk%>);
</script>
<script src="https://kit.fontawesome.com/285f83e94b.js" crossorigin="anonymous"></script>
</body>
</html>
