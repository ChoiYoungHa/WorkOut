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
            <button class="button" type="button" value="검색" onclick="clickFoodList()"/>
        </div>
</div>
<!-- search{e} -->
<div id="searchList"></div>
<script type="text/javascript">

    // 엔터쳤을 때,
    document.querySelector('#keyword').addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            // code for enter
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

        var totalData = 1000;    // 총 데이터 수
        var dataPerPage = 20;    // 한 페이지에 나타낼 데이터 수
        var pageCount = 10;        // 한 화면에 나타낼 페이지 수

        // 페이징 코드 받아오는 데이터의 크기에 맞게 수정
        function paging(totalData, dataPerPage, pageCount, currentPage){

            console.log("currentPage : " + currentPage);

            var totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수
            var pageGroup = Math.ceil(currentPage/pageCount);    // 페이지 그룹

            console.log("pageGroup : " + pageGroup);

            var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호
            if(last > totalPage)
                last = totalPage;
            var first = last - (pageCount-1);    // 화면에 보여질 첫번째 페이지 번호
            var next = last+1;
            var prev = first-1;

            console.log("last : " + last);
            console.log("first : " + first);
            console.log("next : " + next);
            console.log("prev : " + prev);

            var $pingingView = $("#paging");

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

                paging(totalData, dataPerPage, pageCount, selectedPage);
            });

        }

        $("document").ready(function(){
            paging(totalData, dataPerPage, pageCount, 1);
        });

        $.ajax({
            url : `http://openapi.foodsafetykorea.go.kr/api/d5388ab1d4d546a6b033/I2790/json/1/10/`+search+"="+keyword,
            type : "get",
            success : function(data) {
                // 원하는 음식이 안나올 수 있어서 최대한 많은 데이터를 가져오고 페이징을 해야함.
                // 각 요소마다 클릭되면 데이터가 저장될 수 있게 해야함.
                let foodList = "";
                console.log(data)
                for(let i = 0; i < data.I2790.row.length; i++){
                    foodList += data.I2790.row[i].DESC_KOR + "  "// 음식명
                    foodList += data.I2790.row[i].MAKER_NAME  + "  " // 브랜드
                    foodList += data.I2790.row[i].SERVING_SIZE  + "  "// 음식량
                    foodList += data.I2790.row[i].NUTR_CONT1 + "<br>"// 칼로리
                }
                $('#searchList').html(foodList);
            }
        })
    }

</script>
</body>
</html>
