<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>

<script type="text/javascript">
$(function() {
	$(".datetimepicker").datetimepicker({ 
		format: "Y-m-d H:i",
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	 	 	dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    format:'Y-m-d H:i',
	    step: 1,
	    defaultSelect: false,
	    defaultDate: false,
	    onClose: function(ct, $i) {
	        let endDateInput = $("#dateEnd");
	        if($("#dateEnd").val() != ''){
	            let tempStartDate = new Date(ct);
	            let tempEndDate = new Date(endDateInput.val());
	            if(tempStartDate > tempEndDate){
	                endDateInput.val(getFormatDateTime(ct));
	            }
	        }else {
	            endDateInput.val(getFormatDateTime(ct));
	        }
	    },
	    onSelectDate: function(ct, $i){
	        $("#dateEnd").datetimepicker('setOptions', { minDate: ct });
	        $("#dateEnd").datetimepicker('setOptions', { minTime: ct });
	    },
	    onSelectTime: function(ct, $i){
	        $("#dateEnd").datetimepicker('setOptions', { minDate: ct });
	        $("#dateEnd").datetimepicker('setOptions', { minTime: ct });
	    }
	});
});
</script>
</head>
<body>
	<h1>datetimepicker</h1>
	시작일시 : <input type='text' class='datetimepicker' name='start_dt'  style='width:140px;'>, 
	종료일시 : <input type='text' class='datetimepicker' name='end_dt'   style='width:140px; padding-left:10px;'>
</body>
</html>