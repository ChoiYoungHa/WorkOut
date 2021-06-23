<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">

    // 칼로리 단위 조정
    function priceToString(price) {
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    // 주차별 칼로리
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
        goal_kcal = priceToString(goal_kcal);

        let html = "목표 칼로리 : " + goal_kcal + "kcal";
        $("#goal_kcal").html(html);
    }

    // 탄단지 계산
    function ca_kcal(kcal){
        let tan_kcal = Math.ceil(kcal * 0.5);
        let dan_kcal = Math.ceil(kcal * 0.3);
        let fat_kcal = Math.ceil(kcal * 0.2);

        let tan_gram = Math.ceil(tan_kcal / 4);
        let dan_gram = Math.ceil(dan_kcal / 4);
        let fat_gram = Math.ceil(fat_kcal / 9);

        let html = "<span class='mr-5'>" + "탄수화물 : " + tan_gram + "g"+" " + "</span>" + "<span class='mr-5'>" + "단백질 : " + dan_gram + "g"+" " + "</span>" +
            "<span>" + "지방 : " + fat_gram + "g" + "</span>";

        $('#food_recom_info').html(html);
    }


    // 섭취한 음식 기록
    function eatFood(){
        $.ajax({
            url : "/getFoodData.do",
            type : "get",
            success : function(data) {
                let eat_kcal = 0;
                let eat_tan = 0;
                let eat_dan = 0;
                let eat_fat = 0;

                for (let i = 0; i < data.length; i++) {
                    eat_kcal = eat_kcal + Number(data[i].food_kcal * data[i].amount);
                    eat_tan = eat_tan + Number(data[i].tan * data[i].amount);
                    eat_dan = eat_dan + Number(data[i].dan * data[i].amount);
                    eat_fat = eat_fat + Number(data[i].fat * data[i].amount);
                }

                let html = "<span class='mr-5'>" + "탄수화물 : " + eat_tan + "g" + " " + "</span>" + "<span class='mr-5'>" + " 단백질 : " + eat_dan + "g" + " " + "</span>" +
                    "<span>" + " 지방 : " + eat_fat + "g" + "</span>";

                eat_kcal = priceToString(eat_kcal);

                let eat_kcal_html = "<h2 style='color: white'> 섭취 칼로리 : " + eat_kcal + "kcal" + "</h2>";
                $('#food_intake_info').html(html);
                $('#eat_kcal').html(eat_kcal_html);
            }
        })
    }
</script>

<script type="text/javascript">
    // 엔터쳤을 때,
    document.querySelector('#modal_keyword').addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            reloading_st();
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

                    loading_ed();
                    paging(data.I2790.row.length, 1, data);
                }
            })
        }
    });


    // 검색버튼을 클릭했을 때,
    function clickFoodList(){
        reloading_st();
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
                loading_ed();
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
            foodList += "<li><a class='d-flex' href='#' id=" + i + "><p>" + data.I2790.row[i].DESC_KOR + "  " + "</a> "// 음식명
            foodList += data.I2790.row[i].MAKER_NAME  + "  " // 브랜드
            foodList += data.I2790.row[i].SERVING_SIZE + "g" + "  "// 음식량
            foodList += data.I2790.row[i].NUTR_CONT1 +"kcal"+ "</p></li>"// 칼로리
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
        var html = "<li>" + "<p>" + "음식이름 : " + food_name + "</p>" + "<p>" + "제조사 : " + food_brand + "</p>" +
            "<p>" + "칼로리 : "+ food_kcal + "kcal" + "</p>" + "<p>" + "용량 : " + food_gram + "g" + "</p>" +
            "<p>" + "탄수화물 : " + tan + "g" + "</p>" + "<p>" + "단백질 : " + dan + "g" + "</p>" + "<p>" + "지방 : " + fat + "g" + "</p></li>";
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
                eatFood();

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
                        let food_data = "<li id="+ "F" + dataLength + ">" + "<hr>" + "<span>" + food_name + "    " + food_kcal + "kcal" +"</span>" +
                            "<br>" + "<p>" + food_gram + "g" + " " + amount + "개" + "</p>" + "<i class=" + "'far" + " " + "fa-minus-square'" +
                            "onclick='deleteFood(this)'" + dataLength +">" + "</i>" +
                            "<input type='hidden' value=" + food_time + ">" + "</li>";
                        $('#' + 'food_' + food_time + '_list').append(food_data);
                    }
                })
            }
        })
    }

    // 페이지가 로딩되면 섭취한 음식 DB에서 가져오기
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

                    let food_data = "<li id=" + "F" + i +">" + "<hr>" + "<span>" + food_name + "    " + food_kcal + "kcal" +"</span>" + "<br>" + "<p>" + food_gram + "g" + " " + amount + "개" + "</p>" + "<i class=" + "'far" + " " + "fa-minus-square'" + "onclick='deleteFood(this)'" + ">" + "</i>" +
                        "<input type='hidden' value=" + food_time + ">" + "</li>";
                    $('#' + 'food_' + food_time + '_list').append(food_data);
                }
            }
        })
    }

    // 데이터가 삭제되고 html이 삭제되거나, html이 삭제되고 데이터가 삭제된 것이 보이지 않거나 ajax 비동기 처리문제 해결해야됨.
    function deleteFood(e){
        // 부모요소에 접근 후 각 자식요소 데이터 추출
        let pa = e.parentNode;

        // 자식요소의 데이터 공백단위로 정제
        let split_res = pa.childNodes[1].textContent.split("    ");
        let split_it = pa.childNodes[3].textContent.split(" ");

        // 필요한 데이터 정제
        let food_time = pa.childNodes[5].value;
        let food_kcal = split_res[1].replace(/kcal/,'');
        let food_gram = split_it[0].replace(/g/,'');

        // 서버로 전송
        // 다른방법으로 element id랑 food 테이블 id를 일치시키고 id 조회해서 삭제
        $.ajax({
            url : "/deleteFoodData.do", // db 요소 삭제 로직작성
            type : "post",
            dataType : "json",
            data : {
                "food_time" : food_time,
                "food_kcal" : food_kcal,
                "food_gram" : food_gram
            }, success: function (data) {
                // 클릭한 요소의 부모 element id 받아오기
                let temp_id = e.parentNode.id;
                console.log(temp_id);
                var a = $('#' + temp_id);
                console.log(a);
                $('#' + temp_id).remove(); // 삭제
                eatFood();
            }
        })
    }
    init();
    ca_kcal(<%=member_gk%>);
    eatFood();
</script>
<script type="text/javascript">
    function loading_st() {
        let layer_str = "<div id='loading_layer' style='position: fixed;z-index: 3000;top: 0;left: 0;width: 100%;height: 100%;display: flex;justify-content: center;align-items: center;background-color: rgba(123 ,123 ,123 , 0.4);writing-mode: vertical-lr;'><img style='width:30%' src='/resource/boots/hosting_tp/assets/img/workout_logo_test.png'></div>"
        document.write(layer_str);
    }

    function loading_ed() {
        let ta = document.getElementById('loading_layer');
        ta.style.display = 'none';
    }

    function reloading_st() {
        let re = document.getElementById('loading_layer');
        re.style.display = 'flex';
    }

</script>