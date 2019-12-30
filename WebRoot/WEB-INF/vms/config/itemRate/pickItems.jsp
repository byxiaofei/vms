<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD html 4.0 Transitional//EN" >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/page/include.jsp"%>
<%@ include file="/page/modalPage.jsp"%>
<link href="<%=bopTheme2%>/css/main.css" type="text/css" rel="stylesheet">
<link href="<%=webapp%>/page/common.css" type="text/css" rel="stylesheet">
<script src="<%=bopTheme%>/js/MessageBox/js/messageBox.js" type="text/javascript"></script>
<link href="<%=bopTheme%>/js/MessageBox/css/messageBox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=webapp%>/page/webctrl/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=webapp%>/page/js/jquery/jquery_1.42.js"></script>
<script type="text/javascript" src="<%=webapp%>/page/js/window.js"></script>
<script type="text/javascript" src="<%=webapp%>/page/js/search.js"></script>
<script language="javascript" type="text/javascript" src="<%=bopTheme%>/js/main.js"></script>
<title>科目税率管理</title>
<style type="text/css">
.detailInfoDIV {
	border: 1px solid green;
	background-color: khaki;
	top: 110px;
	left: 150px;
	width: 450px;
	height: 300px;
	position: absolute;
	z-index: 2;
	filter: alpha(opacity =     90);
	-moz-opacity: 0.9;
	display: none;
}
</style>
<script type="text/javascript">
	$(function() {

		/**$("#btnConfrim").click(function() {
			if ($("[name=checkedlineNo]:checked").length > 0) {
				submitForm("confrimSpecialBill01.action");
			} else {
				alert("请选择明细");
			}

		});*/
		$("#btnSave").click(function() {
			var obj = $("[name=checkedlineNo]:checked");
			if (obj.size() == 0) {
				alert("请选择一条明细");
				return;
			}
			submitForm("updateItemRate.action");
		});
		$("#btnClose").click(function() {
			CloseWindow(true);
		});

		$(".aEdit").click(function() {
			var id = $(this).closest("td").find(".editId").val()
			var url = "editTransVerification.action?id=" + id;
			OpenModalWindow(encodeURI(url), 500, 450, true);
		});

		$("#btnSearch").click(function() {
			submitForm("selectItemList.action");
		});

		/* 	$(".aEdit").click(function(){
				var billNo = $(this).closest("tr").find("[name=checkedlineNo]").val();
				var actionStr = "listSpecialBill01.action?editBillNo="+billNo;
				submitForm(actionStr);
			}); */
		function submitForm(actionUrl) {
			var form = $("#main2");
			var oldAction = form.attr("action");
			form.attr("action", actionUrl);
			form.submit();
			form.attr("action", oldAction);
		}
		$("#CheckAll").click(function() {
			$("[name=checkedlineNo]").attr("checked", $(this).attr("checked"))
		});
	})
</script>
</head>
<body>
	<form id="main2" action="saveItemRate.action" method="post" enctype="multipart/form-data">
		<s:hidden name="verificationInfo.taxNo"></s:hidden>
		<table id="tbl_main" cellpadding="0" cellspacing="0" class="tablewh100">
			<tr>
				<td class="centercondition">
					<div class="widthauto1">
						<table id="tbl_query" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>科目编号</td>
								<td>
									<s:textfield name="verificationInfo.itemCode" cssClass="tbl_query_text"></s:textfield>
								</td>
								<td>科目名称</td>
								<td>
									<s:textfield name="verificationInfo.itemName" cssClass="tbl_query_text"></s:textfield>
								</td>
								<td>
									<s:hidden name="itemCodeIsEmpty"></s:hidden>
									<input type="button" value="查询" id="btnSearch" class="tbl_query_button" onMouseMove="this.className='tbl_query_button_on'" onMouseOut="this.className='tbl_query_button'" name="cmdDistribute" />
								</td>
							</tr>
						</table>
					</div>
					<table id="tbl_tools" width="100%" border="0">
						<tr>
							<td style="padding-left:10px;width:250px">
								<a href="#" id="btnSave">
									<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon16.png" />
									<span>保存</span>
								</a>
								<a href="#" id="btnClose">
									<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1019.png" />
									<span>关闭</span>
								</a>
							</td>
							<td style="width:50px">税率:</td>
							<td style="width:200px">
								<s:select name="verificationInfo.taxRate" list="taxRateSelList" listKey='value' listValue='text' cssClass="tbl_query_text1"></s:select>
								<span class="spanstar">*</span>
							</td>
							<td></td>
						</tr>
					</table>
					<div id="lessGridList4" style="overflow: auto; width: 100%;">
						<table class="lessGrid" cellspacing="0" rules="all" border="0" cellpadding="0" style="border-collapse: collapse;width: 100%;">
							<tr class="lessGrid head">
								<th width="3%">
									<input id="CheckAll" style="width:13px;height:13px;" type="checkbox" />
								</th>
								<th>序号</th>
								<th>科目编号</th>
								<th>科目名称</th>
							</tr>
							<s:iterator value="paginationList.recordList" id="iList" status="stuts">
								<tr align="center" class="<s:if test='#stuts.index%2 == 0'>lessGrid rowA</s:if><s:else>lessGrid rowB</s:else>">
									<td>
										<input type="checkbox" name="checkedlineNo" value="<s:property value="itemCode"/>" />
									</td>
									<td align="center">
										<s:property value='#stuts.count' />
									</td>
									<td>
										<s:property value='itemCode' />
									</td>
									<td>
										<s:property value='itemName' />
									</td>
								</tr>
							</s:iterator>
						</table>
					</div>
					<div id="anpBoud" align="Right" style="width:100%;">
						<table width="100%" cellspacing="0" border="0">
							<tr>
								<td align="right">
									<s:component template="pagediv" />
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
