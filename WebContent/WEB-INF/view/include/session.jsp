<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    //Controller에 저장된 세션으로 로그인할 때 생성됨
    String SS_MEMBER_ID = ((String)session.getAttribute("SS_MEMBER_ID"));
    String SS_MEMBER_NAME = ((String)session.getAttribute("SS_MEMBER_NAME"));
    String url = "";
    String msg = "";

    if (SS_MEMBER_ID == null) {
        url = "/logIn.do";
        msg = "로그인 후 이용 가능합니다.";
    }
%>
