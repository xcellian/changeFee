<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
/**
 * @file    : changeFee.jsp
 * @author  : jeremy
 * @date    : 2017. 12. 6.
 * 
 *  == 개정이력 ==
 * 
 *  수정일         수정자         수정내용
 *  -------        --------       ---------------------------
 *  2017. 12. 6.   jeremy         최초 생성
 * 
 *  Copyright (C) by WilsonParkingKorea All right reserved.
 */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title.parkList" /></title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/changefee.css'/>" />
<script type="text/javascript" src="./js/jquery-3.2.1/jquery-3.2.1.js"></script>
<script type="text/javascript" src="./js/jqueryBlockUI/jquery.blockUI.js"></script>
<script type="text/javaScript" defer="defer">
var parkList = [
	{'label': 'P004', 'arg': 'P004'}, 
	{'label': 'P010', 'arg': 'P010'}, {'label': 'P011', 'arg': 'P011'}, {'label': 'P018', 'arg': 'P018'},
	{'label': 'P026', 'arg': 'P026'}, {'label': 'P045', 'arg': 'P045'}, {'label': 'P047', 'arg': 'P047'},
	{'label': 'P055', 'arg': 'P055'}, {'label': 'P057', 'arg': 'P057'}, {'label': 'P060', 'arg': 'P060'},
	{'label': 'P063', 'arg': 'P063'}, {'label': 'P065', 'arg': 'P065'}, {'label': 'P069', 'arg': 'P069'},
	{'label': 'P079', 'arg': 'P079'}, {'label': 'P080', 'arg': 'P080'}, {'label': 'P081', 'arg': 'P081'},
	{'label': 'P083', 'arg': 'P083'}, {'label': 'P085', 'arg': 'P085'}, {'label': 'P088', 'arg': 'P088'},
	{'label': 'P090', 'arg': 'P090'}, {'label': 'P098', 'arg': 'P098'}, {'label': 'P099', 'arg': 'P099'},
	{'label': 'P105', 'arg': 'P105'}, {'label': 'P106', 'arg': 'P106'}, {'label': 'P107', 'arg': 'P107'},
	{'label': 'P108', 'arg': 'P108'}, {'label': 'P109', 'arg': 'P109'}, {'label': 'P112', 'arg': 'P112'},
	{'label': 'P113', 'arg': 'P113'}, {'label': 'P114', 'arg': 'P114'}, {'label': 'P116', 'arg': 'P116'},
	{'label': 'P117', 'arg': 'P117'}, {'label': 'P118', 'arg': 'P118'}, {'label': 'P119', 'arg': 'P119'},
	{'label': 'P122', 'arg': 'P122'}, {'label': 'P123', 'arg': 'P123'}, {'label': 'P126', 'arg': 'P126'},
	{'label': 'P127', 'arg': 'P127'}, {'label': 'P128', 'arg': 'P128'}, {'label': 'P129', 'arg': 'P129'},
	{'label': 'P130', 'arg': 'P130'}, {'label': 'P131', 'arg': 'P131'}, {'label': 'P133', 'arg': 'P133'},
	{'label': 'P140', 'arg': 'P140'}, {'label': 'P143', 'arg': 'P143'}, {'label': 'P144', 'arg': 'P144'},
	{'label': 'P145', 'arg': 'P145'}, {'label': 'P148', 'arg': 'P148'}
];

var dayList = [
	{'label': '<spring:message code="label.btn.night.thu" />', 'arg': 'ThuNight'},
	{'label': '<spring:message code="label.btn.night.fri" />', 'arg': 'FriNight'},
	{'label': '<spring:message code="label.btn.night.sat" />', 'arg': 'SatNight'},
	{'label': '<spring:message code="label.btn.night.sun" />', 'arg': 'SunNight'},
	{'label': '<spring:message code="label.btn.night.mon" />', 'arg': 'MonNight'}
];

$(document).ready(function(){
	var parkHtml = [
		'<table class="inner">',
		'<tbody>',
		'<tr>',
		'<th rowspan="2"><span class="parkId no"></span></th>',
		'<td><a class="button red btnMax" title="Max">',
		'<spring:message code="label.btn.max" />',
		'</a></td>',
		'</tr>',
		'<tr>',
		'<td><a class="button blue btnNor" title="Normal">',
		'<spring:message code="label.btn.normal" />',
		'</a></td>',
		'</tr>',
		'</tbody>',
		'</table>',
	];
	$(parkList).each(function(idx, val){
		var $elemList = $('<li/>', {
			'html': parkHtml.join('')
		}).appendTo('#ulParkList');
		
		$elemList.find('.parkId').text(val.label);
		$elemList.find('.btnMax').click(function(){
			fnBtnClick('P', val.arg, 'max');
		});
		$elemList.find('.btnNor').click(function(){
			fnBtnClick('P', val.arg, 'restore');
		});
	});
	
	var dayHtml = [
		'<table class="inner">',
		'<tbody>',
		'<tr>',
		'<td style="padding-right: 10px;">',
		'<a class="button blue large dayLabel" title="Normal"></a>',
		'</td>',
		'</tr>',
		'</tbody>',
		'</table>',
	];
	$(dayList).each(function(idx, val){
		var $elemList = $('<li/>', {
			'html': dayHtml.join('')
		}).appendTo('#ulDayList');
		
		$elemList.find('.dayLabel').html(val.label);
		$elemList.find('.button').click(function(){
			fnBtnClick('D', val.arg);
		});
	});
	
	var fnBtnClick = function(callType, args1, args2){
		$.ajax({
			url       : '<c:url value="/callChange.do"/>',
			type      : 'POST',
			dataType  : 'json',
			data      : {'callType' : callType, 'args_01': args1, 'args_02': args2},
			beforeSend: function(){
				$.blockUI({ css: { 
					border                 : 'none', 
					padding                : '15px', 
					backgroundColor        : '#000', 
					'-webkit-border-radius': '10px', 
					'-moz-border-radius'   : '10px', 
					opacity                : .5, 
					color                  : '#fff',
					'font-size'            : '10px'
				} }); 
			},
			success   : function(response, status, xhr){
				var msg = args1;
				if (callType === 'P' && args2 === 'max') {
					msg += ', MAX';
				}
				else if (callType === 'P' && args2 === 'restore') {
					msg += ', NOR';
				}
				
				if (response.message == 'SUCCESS') {
					alert('요금을 변경하였습니다. ( ' + msg + ' )');
				}
				else {
					alert('요금변경에 실패했습니다. ( ' + msg + ' )');
				}
			},
			error     : function(xhr, status, error){
				alert('요금변경에 실패했습니다. ( ' + msg + ' )');
			},
			complete  : function(xhr, status){
				$.unblockUI();
			}
		});
	};
});
</script>
</head>

<body>
<div class="tabset">
	<!-- Tab 1 -->
	<input type="radio" name="tabset" id="tab1" aria-controls="perm" checked>
	<label for="tab1"><spring:message code="label.tab.perm" /></label>
	<!-- Tab 2 -->
	<input type="radio" name="tabset" id="tab2" aria-controls="day">
	<label for="tab2"><spring:message code="label.tab.dayweek" /></label>
	
	<div class="tab-panels">
		<section id="perm" class="tab-panel">
				<ul id="ulParkList"></ul>
		</section>
		<section id="perm" class="tab-panel">
				<ul id="ulDayList"></ul>
		</section>
	</div>
</div>

</body>
</html>
