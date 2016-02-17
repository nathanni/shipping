<%@ Language=VBScript %>
<!--#include file="./include/incConSQL_VB.asp"-->
<%	
	dim strLoadNumber
	strLoadNumber = Request.QueryString("LoadNumber")
	If Len(strLoadNumber) = 0 Then
		strLoadNumber = Request.Form("LoadNumber")
	End If
	
	dim strOrderId
	strOrderId = Request.QueryString("OrderId")
	
	dim bProcess
	bProcess = Request.QueryString("Process")
	If Len(bProcess) = 0 Then
		bProcess = 0
	End If
	
	'processing
	dim strSQL
	
	set dbCon = Server.CreateObject("ADODB.Connection")
	dbCon.Open dbSQL
%>
<html>
	<head>
		<title>Report For Load #<%=strLoadNumber%></title>		
		<STYLE TYPE="text/css">
			P.breakhere {page-break-before: always}
		</STYLE>
	</head>
	<body>
		<table align="center">
<%
	'fetch records
	strSQL = "" & _
"SELECT om.salesorder," & _
"       c.accountid," & _
"       c.account_name," & _
"       To_char(om.cutoffdate, 'Day')             CutOffDay," & _
"       To_char(om.dateproofed, 'MONTH DD, YYYY') DateProofed," & _
"       To_char(om.duedate, 'MONTH DD, YYYY')     DueDate," & _
"       om.shipcode," & _
"       s.shipcodedesc," & _
"       om.orderid," & _
"       om.namejob," & _
"       om.purchaseorder," & _
"       om.shipname," & _
"       c.address1," & _
"       om.shipstreet1," & _
"       c.address2," & _
"       om.shipstreet2," & _
"       c.address3," & _
"       om.shipcity," & _
"       c.city," & _
"       om.shipstate," & _
"       c.state," & _
"       a.planregion                              Region," & _
"       a.route," & _
"       om.shipzip," & _
"       c.postal_code" & _
" FROM   ordermaster om" & _
"       join address c" & _
"         ON om.accountid = c.accountid" & _
"       join accountsmaster a" & _
"         ON a.accountid = c.accountid" & _
"       join shipcode s" & _
"         ON om.shipcode = s.shipcode"
	strSQL = strSQL & "" & _
" WHERE  om.bol = '" & strLoadNumber & "'" & _
"       AND c.shipid = om.shipid" & _
"       AND dateproofed > Add_months(SYSDATE, -12)"


	If Len(strOrderId) > 0 Then
		strSQL = strSQL & " AND OrderId = " & strOrderId
	Else
		strSQL = strSQL & " ORDER BY OrderId DESC"
	End If
		
'Response.Write("<br />" & strSQL)
	set rs = dbCon.Execute(strSQL)
	If rs.BOF And rs.EOF Then
		Response.Write("<font color=red>No order was found with that Load Number.</font>")
	Else		
		dim line
		If bProcess = 1 Then
			'for barcode.asp
			dim strBarCode
			
			dim strZip1
			dim strZip2
			
			Do While Not rs.EOF
				strBarCode = rs("SalesOrder")
				
				strZip1 = rs("ShipZip")
				If Len(strZip1) = 9 Then
					strZip1 = Left(strZip1, 5) & "-" & Right(strZip1, 4)
				End If
				
				strZip2 = rs("postal_code")		
				If Len(strZip2) = 9 Then
					strZip2 = Left(strZip2, 5) & "-" & Right(strZip2, 4)
				End If
%>
			<tr>
				<td bgcolor="#ff973c"><b>Sales Order</b></td>
				<td align="center"><!--#include file="barcode.asp"--><br /><%=rs("SalesOrder")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Customer Code</b></td>
				<td bgcolor="#ffe9d2"><%=rs("AccountId")%> - <%=rs("Account_Name")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Cut Off Day</b></td><td bgcolor="#ffe9d2"><%=rs("CutOffDay")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Order Date</b></td><td bgcolor="#ffe9d2"><%=rs("DateProofed")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Due Date</b></td><td bgcolor="#ffe9d2"><%=rs("DueDate")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Ship Code</b></td><td bgcolor="#ffe9d2"><%=rs("ShipCode")%> - <%=rs("ShipCodeDesc")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Region Code</b></td><td bgcolor="#ffe9d2"><%=rs("Region")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Route Code</b></td><td bgcolor="#ffe9d2"><%=rs("Route")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Quote Number</b></td><td bgcolor="#ffe9d2"><%=rs("OrderId")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Job Name</b></td><td bgcolor="#ffe9d2"><%=rs("NameJob")%></td>
			</tr>
			<tr>
				<td bgcolor="#ff973c"><b>Purchase Order</b></td><td bgcolor="#ffe9d2"><%=rs("PurchaseOrder")%></td>
			</tr>
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td bgcolor="#ff973c"><b>Ship To</b></td><td bgcolor="#ff973c"><b>Bill To</b></td></tr>
			<tr><td><%=rs("ShipName")%></td><td><%=rs("Account_Name")%></td></tr>
			<tr><td><%=rs("ShipStreet1")%></td><td><%=rs("Address1")%></td></tr>
			<tr><td><%=rs("ShipStreet2")%></td><td><%=rs("Address2")%></td></tr>
			<tr>
				<td><%=rs("ShipCity")%>&nbsp;<%=rs("ShipState")%>&nbsp;<%=strZip1%></td>
				<td><%=rs("City")%>&nbsp;<%=rs("State")%>&nbsp;<%=strZip2%></td>
			</tr>
<%
				strSQL = "SELECT l1.Quantity, l2.Description, l2.ProductionText, l2.GlassText, l2.PartNumberExact,"
				strSQL = strSQL & " l2.extendedpartnumber, l2.infopartnumber"
				strSQL = strSQL & " FROM L1_Item l1 JOIN L2_Unit l2 ON l2.ItemId = l1.ItemId WHERE"
				strSQL = strSQL & " OrderId = " & rs("OrderId") & " ORDER BY l1.ItemId"
'Response.Write("<br />" & strSQL)
				set rs2 = dbCon.Execute(strSQL)
				If Not (rs2.BOF And rs2.EOF) Then
%>
			<tr><td colspan="2">
				<table width="100%">
					<tr><td colspan="4"><hr /></td></tr>
					<tr>
						<td><b>Line</b></td>
						<td><b>Quantity</b></td>
						<td><b>Part Number</b></td>
						<td width="50%"><b>Description</b></td>
					</tr>
<%
					line = 0
					Do While Not rs2.EOF
						line = line + 1
%>
					<tr>
						<td><%=line%></td>
						<td><%=rs2("Quantity")%></td>
						<td><%=rs2("PartNumberExact")%> / <%=Left(rs2("extendedpartnumber"), 5)%> (<%=rs2("infopartnumber")%>)</td>
						<td rowspan="2" valign="top"><%=rs2("Description")%></td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr><td colspan="2"><b>Production Text:</b></td><td colspan="2"><%=rs2("ProductionText")%></td></tr>
					<tr><td colspan="2"><b>Glass Text:</b></td><td colspan="2"><%=rs2("GlassText")%></td></tr>
<%
						rs2.MoveNext
						If Not rs2.EOF Then
							Response.Write("<td colspan=4><hr /></td>")
						End If
					Loop
					rs2.Close
%>
				</table>
			</td></tr>
<%
				End If
%>
			<tr><td colspan="4"><hr color="red" /></td></tr>
			<tr><td><P CLASS="breakhere">&nbsp;</P></td></tr>
<%
				rs.MoveNext
			Loop
			rs.Close
		Else
%>
			<tr><td align="center">
				<a href="ShippingReport.asp?process=1&LoadNumber=<%=strLoadNumber%>">
					View Report For All Sales Order #s
				</a>
			</td></tr>
<%
			'print summary
			Do While Not rs.EOF
%>
			<tr><td align="center">
				<a href="ShippingReport.asp?process=1&orderid=<%=rs("OrderId")%>&LoadNumber=<%=strLoadNumber%>">
					View Report For Sales Order #<%=rs("SalesOrder")%>
				</a>
			</td></tr>
<%
				rs.MoveNext
			Loop
			rs.Close
		End If
%>
		</table>
<%
	End If
%>
	</body>
</html>