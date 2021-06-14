<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%
    //전달받은 메시지
    String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
    String post_category = CmmUtil.nvl((String) request.getAttribute("post_category"));
    System.out.println("post_category = " + post_category);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>처리페이지</title>
<%--    <script type="text/javascript">--%>
<%--        alert("<%=msg%>");--%>
<%--        if ("<%=post_category%>" === "work"){--%>
<%--            top.location.href="/pagingList.do?category=work";--%>
<%--        }--%>
<%--        else {--%>
<%--            top.location.href="/pagingList.do?category=menu";--%>
<%--        }--%>
<%--    </script>--%>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title></title>
    <!-- jquery -->
    <script src="/resource/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            Swal.fire({
                title: "<%=msg%>",
                icon: 'success',
                buttons: true,
            }).then(val => {
                if (val) {
                    if ("<%=post_category%>" === "work"){
                        top.location.href="/pagingList.do?category=work";
                    }
                    else {
                        top.location.href="/pagingList.do?category=menu";
                    }
                }
            });
        })
    </script>
</head>
<body>

</body>
</html>