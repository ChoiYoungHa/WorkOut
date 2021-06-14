<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
    //작성자 여부체크
    function doOnload(){
        if ("<%=access%>"=="1"){
            alert("작성자만 수정할 수 있습니다.");
            location.href="/Main.do";
        }
    }
    //전송시 유효성 체크
    function doSubmit(f){
        if(f.title.value == ""){
            alert("제목을 입력하시기 바랍니다.");
            f.title.focus();
            return false;
        }

        if(calBytes(f.title.value) > 200){
            alert("최대 200Bytes까지 입력 가능합니다.");
            f.title.focus();
            return false;
        }

        if(f.contents.value == ""){
            alert("내용을 입력하시기 바랍니다.");
            f.contents.focus();
            return false;
        }

        if(calBytes(f.contents.value) > 5000){
            alert("최대 5000Bytes까지 입력 가능합니다.");
            f.contents.focus();
            return false;
        }

    }
    //글자 길이 바이트 단위로 체크하기(바이트값 전달)
    function calBytes(str){

        var tcount = 0;
        var tmpStr = new String(str);
        var strCnt = tmpStr.length;
        var onechar;
        for (i=0;i<strCnt;i++){
            onechar = tmpStr.charAt(i);

            if (escape(onechar).length > 4){
                tcount += 2;
            }else{
                tcount += 1;
            }
        }
        return tcount;
    }
</script>
