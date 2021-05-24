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
</body>
</html>
