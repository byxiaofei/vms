<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cjit.vms.input.model.InputInvoiceNew" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD html 4.0 Transitional//EN" >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="../../../page/include.jsp"%>
<link href="<%=bopTheme2%>/css/main.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=webapp%>/page/webctrl/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=webapp%>/page/js/jquery/jquery_1.42.js"></script>
<script type="text/javascript" src="<%=webapp%>/page/js/window.js"></script>
<script type="text/javascript" src="<%=bopTheme%>/js/validator.js"></script>
<!-- MessageBox -->
<script src="<%=bopTheme%>/js/MessageBox/js/messageBox.js" type="text/javascript"></script>
<link href="<%=bopTheme%>/js/MessageBox/css/messageBox.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="<%=bopTheme%>/js/main.js"></script>
<meta http-equiv="Pragma" content="no-cache" />
<title>抵扣预警</title>
<script type="text/javascript">
	function openViewData(url) {
		OpenModalWindow(url, 900, 650, true);
	}
	function openViewImg(url) {
		OpenModalWindow(url, 800, 600, true);
	}
	function checkForm() {
		// 去掉字符串两边的空格
		var startNum = document.getElementById("billStartDate").value;
		var endNum = document.getElementById("billEndDate").value;
		startNum = startNum.replace(/^(\s)*|(\s)*$/g, "");
		endNum = endNum.replace(/^(\s)*|(\s)*$/g, "");
		//认证剩余时间
		if (startNum.length > 0) {
			if (fucIsInteger(document.getElementById("billStartDate"),
					"认证剩余时间必须为数字") == false) {
				return false;
			}
		}
		if (endNum.length > 0) {
			if (fucIsInteger(document.getElementById("billEndDate"),
					"认证剩余时间必须为数字") == false) {
				return false;
			}
		}
		return true;
	}
	function submitForm(actionUrl) {
		if (true == checkForm()) {
			document.forms[0].action = actionUrl;
			document.forms[0].submit();
			document.forms[0].action = "inputInvoiceInfoListNew.action";
		}
	}
</script>
</head>
<body>
	<form id="main" action="<c:out value='${webapp}'/>/inputInvoiceInfoList.action" method="post">
		<table id="tbl_main" cellpadding="0" cellspacing="0" class="tablewh100">
			<tr>
				<td class="centercondition">
					<div id="tbl_current_status">
						<img src="<%=bopTheme%>/themes/images/icons/icon13.png" />
						<span class="current_status_menu">当前位置：</span>
						<span class="current_status_submenu1">进项税管理</span>
						<span class="current_status_submenu">认证管理</span>
						<span class="current_status_submenu">抵扣预警</span>
					</div>
					<div class="widthauto1">
						<table id="tbl_query" cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								<td>开票日期</td>
								<td>
									<input id="billDate" name="billDate" type="text" value="<s:property value='billDate' />" class="tbl_query_time" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
									&nbsp;&nbsp;&nbsp;
								</td>
								<td>供应商纳税人识别号</td>
								<td>
									<input id="vendorTaxno" class="tbl_query_text" name="vendorTaxno" type="text" value="<s:property value='vendorTaxno' />" style="width:150px" />
								</td>
								<td>发票状态</td>
								<td>
									<select id="datastatus" name="datastatus">
										<option value="" <s:if test='datastatus==""'>selected</s:if> <s:else></s:else>>所有</option>
										<s:iterator value="mapDataStatus" id="entry">
											<option value="<s:property value="key"/>" <s:if test='datastatus==#entry.key'>selected</s:if> <s:else></s:else>><s:property value="value" /></option>
										</s:iterator>
									</select>
								</td>
							</tr>
							<tr>
								<td>机构</td>
								<!-- <td>
									<input type="hidden" id="inst_id" name="instCode" value='<s:property value="instCode"/>'>
									<input type="text" class="tbl_query_text" id="inst_Name" name="instName" value='<s:property value="instName"/>' onclick="setOrg(this);" readonly="readonly">
									<%-- <s:if test="authInstList != null && authInstList.size > 0">
							<s:select name="instCode" list="authInstList" listKey='id' listValue='name' headerKey="" headerValue="所有"/>
							</s:if>
							<s:if test="authInstList == null || authInstList.size == 0">
							<select name="instCode" class="readOnlyText">
							<option value="">请分配机构权限</option>
							</select>
							</s:if> --%> 
								</td> -->
								<td><s:select id="industryType"
                                          name="industryType" list="industryTypeList"
                                          headerKey="" headerValue="全部" listKey='code' listValue='name'
                                          cssClass="tbl_query_text"/>
                            </td>
								<td>发票代码</td>
								<td>
									<input id="billCode" class="tbl_query_text" name="billCode" type="text" value="<s:property value='billCode' />" style="width:100px" />
								</td>
								<td>发票号码</td>
								<td>
									<input id="billNo" class="tbl_query_text" name="billNo" type="text" value="<s:property value='billNo' />" style="width:100px" />
								</td>
							</tr>
							<tr>
								<!-- 	<td>发票类型:</td> 
						<td>
							<select id="fapiaoType" name="fapiaoType" ><option value="" <s:if test='fapiaoType==""'>selected</s:if><s:else></s:else>>所有</option>
								<s:iterator value="mapVatType" id="entry">  
								<option value="<s:property value="key"/>" <s:if test='fapiaoType==#entry.key'>selected</s:if><s:else></s:else>><s:property value="value"/></option>
						       </s:iterator>
							</select>
						</td> -->
								<td>认证剩余时间</td>
								<td>
									<input id="billStartDate" class="tbl_query_text" name="billStartDate" type="text" value="<s:property value='billStartDate' />" style="width:60px" />
									-
									<input id="billEndDate" class="tbl_query_text" name="billEndDate" type="text" value="<s:property value='billEndDate' />" style="width:60px" />
								</td>
								<td colspan="4">
									<input type="button" class="tbl_query_button" onMouseMove="this.className='tbl_query_button_on'" onMouseOut="this.className='tbl_query_button'"
										onclick="submitForm('inputInvoiceInfoListNew.action');" name="cmdSelect" value="查询" id="cmdSelect"
									/>
								</td>
							</tr>
						</table>
					</div>
					<table id="tbl_tools" width="100%" border="0">
						<tr>
							<td align="left">
								<a href="#" onclick="submitForm('inputInvoiceInfoExcel.action');">
									<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1003.png" />
									导出
								</a>
							</td>
						</tr>
					</table>
					<div id="lessGridList3" style="overflow: auto; width: 100%;">
						<table class="lessGrid" cellspacing="0" rules="all" border="0" cellpadding="0" style="border-collapse: collapse;width: 100%;">
							<tr class="lessGrid head">
								<th width="3%" style="text-align:center">
									<input id="CheckAll" style="width:13px;height:13px;" type="checkbox" onClick="checkAll(this,'selectTaxDisks')" />
								</th>
								<th style="text-align: center">序号</th>
								<th style="text-align: center">发票代码</th>
								<th style="text-align: center">发票号码</th>
								<th style="text-align: center">开票日期</th>
								<th style="text-align: center">所属机构</th>
								<th style="text-align: center">金额</th>
								<th style="text-align: center">税额</th>
								<th style="text-align: center">发票类型</th>
								<th style="text-align: center">供应商名称</th>
								<th style="text-align: center">供应商纳税人识别号</th>
								<th style="text-align: center">发票状态</th>
								<th style="text-align: center">认证剩余时间</th>
								
							</tr>
							<s:iterator value="paginationList.recordList" id="iList" status="stuts">
								<tr align="center" class="<s:if test='#stuts.index%2 == 0'>lessGrid rowA</s:if><s:else>lessGrid rowB</s:else>">
									<td>
										<input type="checkbox" style="width:13px;height:13px;" name="selectInfos" value="<s:property value="#iList.billId"/>" />
									</td>
									<td align="center">
										<s:property value='#stuts.count' />
									</td>
									<td>
										<s:property value='billCode' />
									</td>
									<td>
										<s:property value='billNo' />
									</td>
									<td>
										<s:property value='billDate' />
									</td>
									<td>
										<s:property value='instName' />
									</td>
									<td>
										<s:property value='amtSum' />
									</td>
									<td>
										<s:property value='taxAmtSum' />
									</td>
									<td>
										<s:iterator value="mapVatType" id="entry">
											<s:if test='fapiaoType==#entry.key'>
												<s:property value="value" />
											</s:if>
										</s:iterator>
									</td>
									<td>
										<s:property value='vendorName' />
									</td>
									<td>
										<s:property value='vendorTaxno' />
									</td>
									<td>
										<!--<s:property value='mapDataStatus[#iList.datastatus]' />-->
										<s:property value='mapDataStatus[#iList.datastatus]' />
									</td>
									<td>
										
										<s:if test="verifyDataRemain<0">已过期</s:if>
										<s:else><s:property value='verifyDataRemain' /></s:else>
									</td>
									<td>
										<a href="javascript:void(0);" onClick="openViewData('inputInvoiceInfoViewDataNew.action?billNoAndCode=<s:property value='#iList.billNo'/><s:property value='#iList.billCode'/>');">
											<img src="<c:out value="${bopTheme}"/>/themes/images/icons/icon1014.png" title="查看数据" style="border-width: 0px;" />
										</a>
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
	<c:import url="${webapp}/page/webctrl/instTree/tree_include.jsp" charEncoding="UTF-8">
		<c:param name="treeType" value="radio" />
		<c:param name="bankName_tree" value="inst_Name" />
		<c:param name="bankId_tree" value="inst_id" />
		<c:param name="taskId_tree" value="" />
		<c:param name="task_tree" value="task_tree" />
		<c:param name="webapp" value="${webapp}" />
	</c:import>
</body>
</html>
