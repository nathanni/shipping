<%@ Language=VBScript %>
<!--#include file="./include/incConSQL_VB.asp"-->
<%
	dim strSalesOrder
	strSalesOrder = Request.Form("SalesOrder")
	
	dim strLoadNumber
	strLoadNumber = Request.Form("LoadNumber")
	
	dim strTracking
	strTracking = Request.Form("Tracking")
	
	dim strMethod
	strMethod = Request.Form("method")
	
	dim fedexCheck
	fedexCheck = " checked"
	
	dim upsCheck
	If strComp(strMethod, "UPS") = 0 Then
		upsCheck = " checked"
		fedexCheck = ""
	End If

'    dim upsCheck
'    upsCheck = " checked"
        
'    dim fedexCheck
'	If strComp(strMethod, "FedEx") = 0 Then
'		fedexCheck = " checked"
'                upsCheck = ""
'	End If
'Response.Write("<br />" & strMethod)
	dim autoCheck
	autoCheck = Request.Form("autosubmit")
	
	dim autoOn
	autoOn = " checked"
    
	dim autoOff
    If strComp(strMethod, "Off") = 0 Then
		autoOff = " checked"
		autoOn = ""
	End If
	
	dim groundCheck
	groundCheck = Request.Form("mode")
	
	dim groundON
	groundOn = " checked"
	
	dim groundOff
	If strComp(groundCheck, "express") = 0 Then
		groundOff = " checked"
		groundOn = ""
	End If
	
	dim strFocus
	strFocus = "SalesOrder"
	
	dim error
	
	'processing
	set dbCon = Server.CreateObject("ADODB.Connection")
	dbCon.Open dbSQL
	
	dim strSQL
	If Len(strSalesOrder) > 0 Then
		If Len(strTracking) > 0 Then
			'search for salesorder/trackingnumber relation in tracking
			strSQL = "SELECT Tracking_Number FROM Tracking WHERE Tracking_Number = '" & strTracking
			strSQL = strSQL & "' AND Sales_Order_Number = '" & strSalesOrder & "'"
'Response.Write("<br />" & strSQL)
			set rs = dbCon.Execute(strSQL)
			If rs.BOF And rs.EOF Then
				'associate trackingnumber with salesorder
				strSQL = "INSERT INTO Tracking (Sales_Order_Number, Tracking_Number, Carrier, DateTime) VALUES('"
				strSQL = strSQL & strSalesOrder & "', '" & strTracking
				If StrComp(strMethod, "UPS", vbTextCompare) = 0 Then
					strSQL = strSQL & "', 'UPS', SYSDATE)"
				Else
					If StrComp(strMethod, "FedEx", vbTextCompare) = 0 Then
						strSQL = strSQL & "', 'FedEx', SYSDATE)"
					End If
				End If
'Response.Write("<br />" & strSQL)
				dbCon.Execute(strSQL)
				
				error1 = "<font color=red>Tracking Number " & strTracking & " was associated with Sales Order "
				error1 = error1 & strSalesOrder & ".</font>"
			Else
				error1 = "<font color=red>Tracking Number " & strTracking & " is already associated with"
				error1 = error1 & " Sales Order " & strSalesOrder & ".</font>"
			End If
			strTracking = ""
			strSalesOrder = ""
		Else
			'fetch trackingnumber by salesorder
			strSQL = "SELECT Tracking_Number FROM Tracking WHERE Sales_Order_Number = '" & strSalesOrder & "'"
'Response.Write("<br />" & strSQL)
			set rs = dbCon.Execute(strSQL)
			If rs.BOF And rs.EOF Then
				error1 = "<font color=red>No Tracking Number was found for that Sales Order.</font>"
				strTracking = ""
				strFocus = "Tracking"
			Else
				strTracking = rs("Tracking_Number")
				rs.Close
			End If
		End If
	Else
		If Len(strTracking) > 0 Then
			'fetch salesorder by trackingnumber
			strSQL = "SELECT Sales_Order_Number FROM Tracking WHERE Tracking_Number = '" & strTracking & "'"
'Response.Write("<br />" & strSQL)
			set rs = dbCon.Execute(strSQL)
			If rs.BOF And rs.EOF Then
				error1 = "<font color=red>No Sales Order was found for that Tracking Number.</font>"
				strSalesOrder = ""
			Else
				strSalesOrder = rs("Sales_Order_Number")
				rs.Close
			End If
		End If
	End If
	
	If Len(strSalesOrder) > 0 Then
		'fetch bol by salesorder
		strSQL = "SELECT DISTINCT BOL FROM OrderMaster WHERE SalesOrder = '" & strSalesOrder & "'"
'Response.Write("<br />" & strSQL)
		set rs = dbCon.Execute(strSQL)
		If rs.BOF And rs.EOF Then
			error2 = "<font color=red>No Load Number was found for that Sales Order.</font>"
			strLoadNumber = ""
		Else
			strLoadNumber = Right("00000" & rs("BOL"), 5)
			rs.Close
		End If
	End If
%>
<html>
	<head>
		<title>Shipping Record Selection</title>
		<script>
<!--
			var oldSalesOrder;
			var oldTracking;
			
			function Lock(which)
			{
				if(which == 0)
				{
					document.searchform.Tracking.disabled = true;
					CheckSalesOrder();
				}
				else
				{
					document.searchform.SalesOrder.disabled = true;
					CheckTracking();
				}
			}
			
			function CheckSalesOrder()
			{
				var salesorder = new String(document.getElementById("SalesOrder").value);
				if(salesorder != "undefined" && salesorder != oldSalesOrder)	//do nothing if the entry has not changed
				{
					if(document.searchform.SalesOrder.value.length == 8)
						document.searchform.submit();
					document.searchform.Tracking.disabled = false;
				}
			}
			
			var strLength = new String();
			function CheckTracking()
			{
				var tracking = new String(document.searchform.Tracking.value);	//do nothing if the entry has not changed
				var auto = document.getElementById("autoOn").checked;
				var ground = document.getElementById("ground").checked;
//alert("1: " + ground);
				if(tracking != "undefined" && tracking != oldTracking)
				{
					var method;
					if(document.getElementById("ups").checked == true)
						method = "UPS";
					else if(document.getElementById("fedex").checked == true)
						method = "FedEx";
					
					if(method == "UPS")
					{
						if(tracking.length == 18)
						{
							if(tracking.substr(0, 2) == "1Z")
								document.searchform.submit();
							else
								alert('UPS Tracking Numbers must begin with "1Z".');
						}
					}
					else if(method == "FedEx")
					{
						if(auto == true)
						{
						
							//if(strLength == 0 || strLength == 12 || strLength == 15 || strLength == 22 || strLength == 32 || strLength == 34) 
							//if(strLength == 0 || strLength == 34) 
//(SR69096) old FedEx length was 34 now 22
                                                        if(strLength == 0 || strLength == 22 || strLength == 34)
							{
							
								if(ground == true && tracking.length == 34) {	//parse for Ground
									document.getElementById("Tracking").value = tracking.substring(22);
									document.searchform.submit();
								} // (SR69096)
								else if(ground == true && tracking.length == 22) {	//parse for Express
									document.getElementById("Tracking").value = tracking.substring(7, 22);
									document.searchform.submit();
                                                                }
								//else if(ground == false && tracking.length == 32) {	//parse for Express
								//	document.getElementById("Tracking").value = tracking.substring(16, 28);
								//	document.searchform.submit();
								//}else if(ground == true && tracking.length == 22) 
								//{	//parse for Ground
								//	document.getElementById("Tracking").value = tracking.substring(7);
								//	document.searchform.submit();
								//}
							}
						}
					}
					document.searchform.SalesOrder.disabled = false;
				}
			}
			
			function CheckSalesTrack()
			{
				var salesorder = document.searchform.SalesOrder.value;
				var tracking = document.searchform.Tracking.value;
				var auto = document.getElementById("autoOn").checked;
				var ground = document.getElementById("ground").checked;
				var method = "FedEx";
//alert("2: " + ground);
				if(document.getElementById("ups").checked == true)
					method = "UPS";
				
				if(salesorder.length == 8)
				{
					if(method == "FedEx")
					{
						if(tracking.length != 12 && tracking.length != 15 && tracking.length != 22 && tracking.length != 32 && tracking.length !=34)
						{
							alert('FedEx Tracking Numbers must be exactly 12, 15, 22 or 32 characters.');
						}
						else
						{
//(SR69096)              				alert("length" + tracking.length);
							if(ground == true && tracking.length == 22) {	//parse for Ground
//(SR69096) document.getElementById("Tracking").value = tracking.substring(8);
                                                                document.getElementById("Tracking").value = tracking.substring(7, 22);   //(SR69096)
							}
							else if(ground == false && tracking.length == 32) {	//parse for Express
								document.getElementById("Tracking").value = tracking.substring(16, 28);
							}
							else if(ground == true && tracking.length == 34) {	//parse for Express
								document.getElementById("Tracking").value = tracking.substring(22);
							}
							document.searchform.submit();
						}
					}
					else if(method == "UPS")
					{
						if(tracking.substr(0, 2) != "1Z")
							alert('UPS Tracking Numbers must begin with "1Z".');
						else if(tracking.length != 18)
							alert('UPS Tracking Numbers must be exactly 18 characters.');
						else
							document.searchform.submit();
					}
				}
				else
					alert('Sales Order must be exactly 8 characters.');
				
				document.searchform.SalesOrder.disabled = false;
				document.searchform.Tracking.disabled = false;
			}
			
			function CheckLoadNumber()
			{
				var tmp = document.reportform.LoadNumber.value;				
				if(Number(tmp) > 0)
				{
					while(tmp.length < 5)
					{
						tmp = "0" + tmp;
					}
					
					document.reportform.LoadNumber.value = tmp;
					document.reportform.submit();
				}
				else
					alert("Invalid Load Number");
			}
-->
		</script>
	</head>
	<body onload="document.searchform.<%=strFocus%>.focus(); oldSalesOrder='<%=strSalesOrder%>'; oldTracking='<%=strTracking%>';">
		<form name="searchform" method="post" id="searchform">
			<table border="0" align="center" id="container">
				<tr><td width="205px">&nbsp;</td><td width="90px">&nbsp;</td><td><table border="1" align="center" id="SOTracking">
					<th colspan="3" bgcolor="#ffe9d2">Search by Sales Order/Tracking Number</th>
					<tr bgcolor="#ff973c">
						<td>Sales Order:</td>
						<td><input type="text" name="SalesOrder" id="SalesOrder" value="<%=strSalesOrder%>" onkeyup="CheckSalesOrder();" tabindex="1"></td>
						<td align="center">
							<input type="button" value="Search" tabindex="4" onclick="Lock(0);" ID="Button1" NAME="Button1">
						</td>
					</tr>
					<tr bgcolor="#ff973c">
						<td>Tracking Number:</td>
						<td colspan>
							<input type="text" name="Tracking" id="Tracking" value="<%=strTracking%>" tabindex="2" onfocus="strLength=String(this.value).length" onkeyup="CheckTracking();">
						</td>
						<td align="center">
							<input type="button" value="Search" onclick="Lock(1);" tabindex="5">
						</td>
					</tr>
					<tr bgcolor="#ff973c">
						<td>Shipping Mode</td>
						<td colspan=2 align="center">
							Ground<input type="radio" name="mode" id="ground" value="Ground"<%=groundOn%> />
							FedEx Express<input type="radio" name="mode" id="express" value="Express"<%=groundOff%> />
						</td>
					</tr>
					<tr bgcolor="#ff973c">
						<td>Auto Submit</td>
						<td colspan=2 align="center">
							<input type="radio" name="autosubmit" id="autoOn" tabindex="4" value="On"<%=autoOn%>>On
							<input type="radio" name="autosubmit" id="autoOff" tabindex="5" value="Off"<%=autoOff%>>Off
						</td>
					</tr>
<%
	If Len(error1) > 0 Then
%>
			<tr><td colspan="3"><%=error1%></td></tr>
<%
	End If
%>
					<tr align="center" bgcolor="#ffe9d2">
						<td colspan="3">
							<input type="button" value="Save" tabindex="3" onclick="CheckSalesTrack();" ID="Button3" NAME="Button3">
						</td>
					</tr>
				</table>
			</td><td width="90px">&nbsp;</td><td><table align="right" cellpadding="0" cellspacing="0" border="1" id="UPSFedex">
				<th colspan="3" bgcolor="#ffe9d2">
					Shipping Method
				</th>
				<tr align="center">
					<td><input type="radio" name="method" id="fedex" value="FedEx"<%=fedexCheck%> /></td>
					<td>
						<a href="http://www.fedex.com/Tracking?ascend_header=1&clienttype=dotcom&cntry_code=us&language=english&tracknumbers=<%=strTracking%>" target="_blank">
							<img src="http://10.16.2.99/images/corp_logo.gif" border="0" /><br />
							<font size="1">Click for Automated Tracking</font>
						</a>
					</td>
				</tr>
				<tr align="center">
					<td><input type="radio" name="method" id="ups" value="UPS"<%=upsCheck%> /></td>
					<td>
						<a href="http://www.ups.com/tracking/tracking.html" target="_blank">
							<img src="http://10.16.2.99/images/ups.gif" border="0" />
						</a>
					</td>
				</tr>
			</table></td></tr>
		</form>
		<table border="1" align="center" ID="Table2">
			<form name="reportform" action="ShippingReport.asp" target="report" method="post" ID="Form2">
				<tr>&nbsp;</tr>
				<th colspan="2" bgcolor="#ffe9d2">Fetch Load Report</th>
				<tr bgcolor="#ff973c">
					<td>Load Number:</td>
					<td><input type="text" name="LoadNumber" value="<%=strLoadNumber%>" tabindex="6" ID="Text3"></td>
				</tr>
<%
	If Len(error2) > 0 Then
%>
			<tr><td colspan="2"><%=error2%></td></tr>
<%
	End If
%>
				<tr align="center" bgcolor="#ffe9d2">
					<td colspan="2"><input type="button" value="Print Preview" tabindex="7" onclick="CheckLoadNumber();" ID="Button4" NAME="Button4"></td>
				</tr>
			</form>
		</table>
		<table border="1" align="center" ID="Table4">
			<tr>&nbsp;</tr>
			<tr align="center">
				<td>NOTES:</td>
				<td>
					<ul>"Ground" Shipping Mode will parse Tracking # and Auto Submit at 22 characters.</ul>
					<ul>"FedEx Express" Shipping Mode will parse Tracking # and Auto Submit at 32 characters.</ul>
					<ul>For manual entry, switch Auto Submit to Off.</ul>
				</td>
			</tr>
		</table>
	</body>
</html>