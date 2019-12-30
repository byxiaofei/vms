<!--file: <%=request.getRequestURI()%> -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD html 4.0 Transitional//EN" >
<html>
<head>
<title>增值税管理平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=bopTheme2%>/css/main.css" type="text/css" rel="stylesheet">
<script language="javascript" type="text/javascript" src="<%=webapp%>/page/js/calendar_notime.js"></script>
<script language="javascript" type="text/javascript" src="<%=webapp%>/page/webctrl/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="<%=webapp%>/page/js/XmlHttp.js"></script>
<script language="javascript" type="text/javascript" src="<%=webapp%>/page/js/search.js"></script>
<script language="javascript" type="text/javascript" src="<%=webapp%>/page/js/ylb.js"></script>
<script language="javascript" type="text/javascript" src="<%=webapp%>/page/js/lhb.js"></script>
<script language="javascript" type="text/javascript" src="<%=bopTheme%>/js/main.js"></script>
<script language="javascript" type="text/javascript" src="<%=bopTheme%>/js/search.js"></script>
<script language="javascript" type="text/javascript" src="<%=webapp%>/page/js/comm.js"></script>
<script type="text/javascript">
	// [查询]按钮
	function search() {
		//document.forms[0].submit();
		submitAction(document.forms[0], "listRedReceiptApprove.action");
		document.forms[0].action = "listRedReceiptApprove.action";
	}
	function addResonSuccess() {
		submitAction(document.forms[0], "listRedReceiptApprove.action");
		document.forms[0].action = "listRedReceiptApprove.action";
	}
	function exportExcel() {
		submitAction(document.forms[0], "redReceiptBillToExcel.action");
		document.forms[0].action = "listRedReceiptApprove.action";
	}
	// 审核按钮
	function cancel(result) {
		if (checkChkBoxesSelected("selectBillIds")) {
			var billIds = document.Form1.selectBillIds;
			var billDates = document.Form1.selectBillDates;
			var canCancel = true;

			var chkBoexes = document.getElementsByName("selectBillIds");
			var j = 0;
			var billId = "";
			for (i = 0; i < chkBoexes.length; i++) {
				if (chkBoexes[i].checked) {
					j++;
					billId += "," + chkBoexes[i].value;
				}
			}
			if (result == 17) {
				if (!confirm("确定将选中票据进行审核处理？")) {
					return false;
				}
				submitAction(document.forms[0],
						"redReceiptApprove.action?billId=" + billId
								+ "&result=" + result);
				document.forms[0].action = "listRedReceiptApprove.action";
			} else {

				OpenModalWindowSubmit("toRedReceiptRefuse.action?billId="
						+ billId + "&result=" + result, 500, 250, true);
				//document.forms[0].action = "listRedReceiptApprove.action"; 
				//submitAction(document.forms[0], "toRedReceiptRefuse.action?billId="+billId +"&result="+result);
			}
		} else {
			alert("请选择审核记录！");
		}
	}
	function exportWord() {
		if (checkChkBoxesSelected("selectBillIds")) {
			var billIds = document.Form1.selectBillIds;
			var billDates = document.Form1.selectBillDates;
			var canCancel = true;

			var chkBoexes = document.getElementsByName("selectBillIds");
			var j = 0;
			var billId = "";

			for (i = 0; i < chkBoexes.length; i++) {
				if (chkBoexes[i].checked) {
					j++;
					billId = chkBoexes[i].value;
				}
				if (j > 1) {
					alert("请选择单条记录进行提交！");
					return false;
				}

			}
			var ticket = document.getElementById("bill" + billId).value;
			if (ticket == "0") {
				submitAction(document.forms[0], "exportToWord.action?billId="
						+ billId);
				document.forms[0].action = "listRedReceiptApprove.action";
			} else {
				alert("您所选票据为普票,没有申请信息！");
				return false;
			}

		} else {
			alert("请选择要导出的记录！");
		}
	}
	var msg = '<s:property value="message" escape="false"/>';
	if (msg != null && msg != '') {
		alert(msg);
	}
	function OpenModalWindowSubmit(newURL, width, height, needReload) {
		var retData = false;
		if (typeof (width) == 'undefined') {
			width = screen.width * 0.9;
		}
		if (typeof (height) == 'undefined') {
			height = screen.height * 0.9;
		}
		if (typeof (needReload) == 'undefined') {
			needReload = false;
		}
		retData = showModalDialog(newURL, window, "dialogWidth:" + width
				+ "px;dialogHeight:" + height
				+ "px;center=1;scroll=0;help=0;status=0;");
		if (needReload && retData) {
			window.document.forms[0].submit();
			document.forms[0].action = "listRedReceiptApprove.action";
		}
	}
</script>
</head>
<body onkeydow="enterkey(event)">
	<form name="Form1" method="post" action="listRedReceiptApprove.action" id="Form1">
		<input type="hidden" name="submitFlag" id="submitFlag" value="" />
		<input type="hidden" name="currMonth" id="currMonth" value="<s:property value="currMonth"/>" />
		<table id="tbl_main" cellpadding="0" cellspacing="0" class="tablewh100">
			<tr>
				<td class="centercondition">
					<s:component template="rocketMessage" />
					<div id="tbl_current_status">
						<img src="<%=bopTheme%>/themes/images/icons/icon13.png" />
						<span class="current_status_menu">当前位置：</span>
						<span class="current_status_submenu1">销项税管理</span>
						<span class="current_status_submenu">红冲管理</span>
						<span class="current_status_submenu">红冲审核</span>
					</div>
					<div class="widthauto1">
						<table id="tbl_query" cellpadding="0" cellspacing="0" width="100%" border="0">
							<tr>
								<td>投保单号</td>
							<td><input type="text" class="tbl_query_text"  name="redReceiptApplyInfo.ttmprcno"
								value="<s:property value='redReceiptApplyInfo.ttmprcno'/>" /></td>
							<td align="left">保单号</td>
							<td><input type="text" class="tbl_query_text" 
								name="redReceiptApplyInfo.insureId"
								value="<s:property value='redReceiptApplyInfo.insureId'/>" />
							</td>
							<td align="left">缴费频率</td>
							<td>
								<s:select name="redReceiptApplyInfo.billFreq"
										list="billFreqList" listKey="key" listValue='value'
										cssClass="tbl_query_text5" headerKey="" headerValue="请选择" /></td>
							</tr>
							<tr>
								<td>渠道</td> 
								<td><s:select name="redReceiptApplyInfo.channel"
										list="chanNelList" listKey="key" listValue='value'
										cssClass="tbl_query_text5" headerKey="" headerValue="请选择" /></td> 
								<td align="left">数据来源</td>
								<td>
									<s:select name="redReceiptApplyInfo.dSource" list="dsouRceList" listKey="key"
										listValue='value' cssClass="tbl_query_text" headerKey=""
										headerValue="请选择" />
								</td>
								<td align="left">费用类型</td>
								<td><s:select name="redReceiptApplyInfo.feeTyp"
										list="chargesList" listKey="key" listValue='value'
										cssClass="tbl_query_text5" headerKey="" headerValue="请选择" /></td></td>
							</tr>
							<tr>
								<td align="left">开票日期</td>
								<td>
									<input class="tbl_query_time" id="billBeginDate" type="text" name="redReceiptApplyInfo.billBeginDate" value="<s:property value='redReceiptApplyInfo.billBeginDate'/>"
										onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'billEndDate\')}'})" size='11'
									"/>
									--
									<input class="tbl_query_time" id="billEndDate" type="text" name="redReceiptApplyInfo.billEndDate" value="<s:property value='redReceiptApplyInfo.billEndDate'/>"
										onfocus="WdatePicker({minDate:'#F{$dp.$D(\'billBeginDate\')}'})" size='11'
									"/>
								</td>
								<td align="left">发票代码</td>
								<td>
									<input type="text" class="tbl_query_text" name="redReceiptApplyInfo.billCode" maxlength="10" value="<s:property value='redReceiptApplyInfo.billCode'/>" />
								</td>
								<td align="left">发票号码</td>
								<td>
									<input type="text" class="tbl_query_text" name="redReceiptApplyInfo.billNo" maxlength="8" value="<s:property value='redReceiptApplyInfo.billNo'/>" />
								</td>
							</tr>
							<tr>
								<td align="left">客户名称</td>
								<td>
									<input type="text" class="tbl_query_text" name="redReceiptApplyInfo.customerName" value="<s:property value='redReceiptApplyInfo.customerName'/>" />
								</td>
								<td align="left">发票类型</td>
								<td>
									<select id="redReceiptApplyInfo.fapiaoType" name="redReceiptApplyInfo.fapiaoType">
										<option value="">全部</option>
										<option value="0" <s:if test='redReceiptApplyInfo.fapiaoType=="0"'>selected</s:if> <s:else></s:else>>增值税专用发票</option>
										<option value="1" <s:if test='redReceiptApplyInfo.fapiaoType=="1"'>selected</s:if> <s:else></s:else>>增值税普通发票</option>
									</select>
								</td>
								<s:if test='configCustomerFlag.equals("KBC")'>
								<td align="left">客户号</td>
								<td>
									<input type="text" class="tbl_query_text" name="redReceiptApplyInfo.customerId" value="<s:property value='redReceiptApplyInfo.customerId'/>" />
								</td>
								</s:if>
								<td align="left">承保日期</td>
								<td><input class="tbl_query_time" id="billBeginDate"
									type="text" name="redReceiptApplyInfo.hissDteBegin"
									value="<s:property value='redReceiptApplyInfo.hissDteBegin'/>"
									onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'billBeginDate\')}'})"
									size='11' "/> -- <input class="tbl_query_time" id="redReceiptApplyInfo.hissDteEnd"
									type="text" name="redReceiptApplyInfo.hissDteEnd"
									value="<s:property value='redReceiptApplyInfo.hissDteEnd'/>"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'billEndDate\')}'})"
									size='11' "/></td>
							</tr>
							<tr>
							<td>
							开具类型
							</td>
							<td>
								<s:select list="#{'':'全部','1':'单笔','2':'合并','3':'拆分'}" name="redReceiptApplyInfo.issueType"label="abc" listKey="key" listValue="value" />
							</td>
							<td></td>
							<td></td>
							<td></td>
							<td align="right">
									<input type="button" class="tbl_query_button" value="查询" onMouseMove="this.className='tbl_query_button_on'" onMouseOut="this.className='tbl_query_button'" name="BtnView" id="BtnView" onclick="search()"/>
							</td>
							</tr>
						</table>
					</div>
					<table id="tbl_tools" width="100%" border="0">
						<tr>
							<td align="left">
								<!-- <input type="button" class="tbl_query_button" value="审核通过"
					onMouseMove="this.className='tbl_query_button_on'" onMouseOut="this.className='tbl_query_button'"
					name="BtnView" id="BtnView" onclick="cancel(17)" />
				<input type="button" class="tbl_query_button" value="审核拒绝"
					onMouseMove="this.className='tbl_query_button_on'" onMouseOut="this.className='tbl_query_button'"
					name="BtnView" id="BtnView" onclick="cancel(1)" /> 
					<input type="button" class="tbl_query_button" value="导出"
					onMouseMove="this.className='tbl_query_button_on'" onMouseOut="this.className='tbl_query_button'"
					name="BtnView" id="BtnView" onclick="exportExcel()" /> 
				<input type="button" class="tbl_query_button" value="导出申请word表"
					onMouseMove="this.className='tbl_query_button_on'" onMouseOut="this.className='tbl_query_button'"
					name="BtnView" id="BtnView" onclick="exportWord()" />
				<input type="button" class="tbl_query_button" value="导出申请xml表"
					onMouseMove="this.className='tbl_query_button_on'" onMouseOut="this.className='tbl_query_button'"
					name="BtnView" id="BtnView" onclick="commit()" /> -->
								<a href="#" onclick="cancel(17)">
									<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1017.png" />
									审核通过
								</a>
								<a href="#" onclick="cancel(1)">
									<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1018.png" />
									审核打回
								</a>
								<a href="#" onclick="exportExcel()">
									<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1003.png" />
									导出
								</a>
								<!-- <a href="#" onclick="exportWord()" ><img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1034.png"/>导出申请WORD表</a>
				<a href="#" onclick="commit()"><img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1035.png"/>导出申请XML表</a> -->
							</td>
						</tr>
					</table>
					<div id="lessGridList1" style="overflow: auto; width: 100%;">
						<table class="lessGrid" cellspacing="0" rules="all" border="0" cellpadding="0" style="border-collapse: collapse; width: 100%;">
							<tr class="lessGrid head">
								<th style="text-align: center">
									<input style="width: 13px; height: 13px;" id="CheckAll" type="checkbox" onclick="cbxselectall(this,'selectBillIds')" />
								</th>
								<th style="text-align: center">序号</th>
<!-- 								metlife begin -->
								<th style="text-align: center">投保单号</th>
								<th style="text-align: center">保单号</th>
								<th style="text-align: center">保全受理号</th>
<!-- 								metlife end -->
								<th style="text-align: center">开票日期</th>
								<th style="text-align: center">发票代码</th>
								<th style="text-align: center">发票号码</th>
								<th style="text-align: center">客户纳税人名称</th>
								<s:if test='configCustomerFlag.equals("KBC")'>
								<th style="text-align: center">客户号</th>
								</s:if>
								<th style="text-align: center">客户纳税人识别号</th>
								<th style="text-align: center">合计金额</th>
								<th style="text-align: center">合计税额</th>
								<th style="text-align: center">价税合计</th>
								<th style="text-align:center">冲帐金额</th>
								<th style="text-align: center">发票类型</th>
								<th style="text-align: center">状态</th>	
<!-- 								metlife begin -->
								<th style="text-align: center">渠道</th>
								<th style="text-align: center">费用类型	</th>
								<th style="text-align: center">承保日期</th>
								<th style="text-align: center">缴费频率</th>
								<th style="text-align: center">数据来源</th>
<!-- 								metlift end -->
								<th style="text-align: center">操作</th>
							</tr>
							<s:iterator value="paginationList.recordList" id="iList" status="stuts">
								<tr align="center" class="<s:if test='#stuts.odd'>lessGrid rowA</s:if><s:else>lessGrid rowB</s:else>">
									<td align="center" style="width:30px;">
										<input style="width:13px;height:13px;" type="checkbox" name="selectBillIds" value="<s:property value="billId"/>" />
										<s:hidden name="selectBillDates" value="%{billDate}"></s:hidden>
									</td>
									<td align="center">
										<s:property value="#stuts.index+1" />
									</td>
<!-- 									metlife  begin -->
									<td align="center">
										<s:property value="ttmprcno" />
									</td>
									<td align="center">
										<s:property value="insureId" />
									</td>
									<td align="center">
										<s:property value="repnum" />
									</td>
<!-- 									metlife end -->
									<td align="center">
										<s:property value="billDate" />
									</td>
									<td align="center">
										<s:property value="billCode" />
									</td>
									<td align="center">
										<s:property value="billNo" />
									</td>
									<td align="center">
										<s:property value="customerName" />
									</td>
									
									<td align="center">
										<s:property value="customerTaxno" />
									</td>
									<td align="right">
										<fmt:formatNumber value="${amtSum}" pattern="#,##0.00"></fmt:formatNumber>
									</td>
									<td align="right">
										<fmt:formatNumber value="${taxAmtSum}" pattern="#,##0.00"></fmt:formatNumber>
									</td>
									<td align="right">
										<fmt:formatNumber value="${sumAmt}" pattern="#,##0.00"></fmt:formatNumber>
									</td>
									<td align="right">
										<fmt:formatNumber value="${reverseSumAmt*-1}" pattern="#,##0.00"></fmt:formatNumber>
									</td>
									<td align="center">
									<s:property value="fapiaoType" />
										<s:property value="@com.cjit.vms.trans.util.DataUtil@getFapiaoTypeCH(fapiaoType)" />
										<s:hidden id="bill%{billId}" name="fapiaoType"></s:hidden>
									</td>
									</td>
									<td align="center">
									<s:property value="datastatus" />
										<s:property value="@com.cjit.vms.trans.util.DataUtil@getDataStatusCH(datastatus,'BILL')" />
									</td>
<!-- 									metlife begin -->
									<td align="center">
										<s:property value="channelch" />
									</td>
									<td align="center">
										<s:property value="feeTypCh" />
									</td>
									<td align="center">
										<s:property value="hissDte" />
									</td>
									<td align="center">
										<s:property value="billFreq" />
									</td>
									<td align="center">
										<s:property value="dSource" />
									</td>
<!-- 									metlife  end -->
									<td align="center">
										<a href="viewTransList.action?curPage=<s:property value='paginationList.currentPage'/>&billId=<s:property value="reverseBillId"/>">
											<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1014.png" title="查看交易" style="border-width: 0px;" />
										</a>
										<a href="javascript:void(0);" onClick="OpenModalWindowSubmit('viewImgFromBillEdit.action?fromFlag=red&billId=<s:property value="reverseBillId"/>',1000,650,false)">
											<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1015.png" title="查看票样" style="border-width: 0px;" />
										</a>
									</td>
								</tr>
							</s:iterator>
						</table>
					</div>
					<div id="anpBoud" align="Right" style="overflow:auto;width:100%;">
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