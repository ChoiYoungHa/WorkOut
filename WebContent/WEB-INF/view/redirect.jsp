<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="poly.util.CmmUtil"%>
<%
    String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
    String url = CmmUtil.nvl((String)request.getAttribute("url"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
                    location.href = "<%=url%>";
                }
            });
        })
    </script>
<%--    <title></title>--%>
<%--    <script type="text/javascript">--%>
<%--        alert("<%=msg%>");--%>
<%--        location.href="<%=url%>";--%>
<%--    </script>--%>

</head>
<body>

</body>
</html>