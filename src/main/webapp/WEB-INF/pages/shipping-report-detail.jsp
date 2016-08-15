<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: nni
  Date: 2/18/2016
  Time: 4:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Report For Sales Order #${salesOrder}</title>
    <script type="text/javascript" src="scripts/jquery-1.12.0.min.js"></script>
    <script type="text/javascript" src="scripts/jquery-barcode.min.js"></script>
    <link rel="stylesheet" href="style/shipping.css">
    <STYLE TYPE="text/css">
        P.breakhere {page-break-before: always}
    </STYLE>
</head>
<body>
<center>
<table>
    <colgroup>
        <col class="t10">
        <col class="t20">
        <col class="t30">
        <col class="t40">
    </colgroup>
    <tr>
        <th colspan="3">Sales Order</th>
        <td class="white">
            <center>
            <div class="bcTarget">
                <input type="hidden" value="${salesOrder}">
            </div>
            </center>
        </td>
    </tr>
    <tr>
        <th colspan="3">Customer Code</th>
        <td>${accountId} - ${accountName}</td>
    </tr>
    <tr>
        <th colspan="3">Cut Off Day</th>
        <td>${cutOffDay}</td>
    </tr>
    <tr>
        <th colspan="3">Order Date</th>
        <td>${orderDate}</td>
    </tr>
    <tr>
        <th colspan="3">Due Date</th>
        <td>${dueDate}</td>
    </tr>
    <tr>
        <th colspan="3">Sales Order</th>
        <td>${salesOrder}</td>
    </tr>
    <tr>
        <th colspan="3">Ship Code</th>
        <td>${shipCode} - ${shipCodeDesc}</td>
    </tr>
    <tr>
        <th colspan="3">Region Code</th>
        <td>${regionCode}</td>
    </tr>
    <tr>
        <th colspan="3">Route Code</th>
        <td>${routeCode}</td>
    </tr>
    <tr>
        <th colspan="3">Quote Number</th>
        <td>${orderId}</td>
    </tr>
    <tr>
        <th colspan="3">Job Name</th>
        <td>${jobName}</td>
    </tr>
    <tr>
        <th colspan="3">Purchase Order</th>
        <td>${purchaseOrder}</td>
    </tr>
    <tr>
        <td colspan="4" class="white">&nbsp;</td>
    </tr>

    <tr>
        <th colspan="3">Ship To</th>
        <th colspan="3">Bill To</th>
    </tr>
    <tr>
        <td colspan="3" class="white">${shipName}</td>
        <td class="white">${accountName}</td>
    </tr>
    <tr>
        <td colspan="3" class="white">${shipAddress1}</td>
        <td class="white">${billAddress1}</td>
    </tr>
    <tr>
        <td colspan="3" class="white">${shipAddress2}</td>
        <td class="white">${billAddress2}</td>
    </tr>
    <tr>
        <td colspan="3" class="white">${shipCity}&nbsp;${shipState}&nbsp;${shipZip}</td>
        <td class="white">${billCity}&nbsp;${billState}&nbsp;${billZip}</td>
    </tr>
    <s:iterator value="shippingLines" var="shippingLine" status="status">
        <tr><td colspan="4" class="white"><hr /></td></tr>
        <tr>
            <th class="white">Line</th>
            <th class="white">Qty</th>
            <th class="white">Part Number</th>
            <th class="white">Description</th>
        </tr>
        <tr>
            <td class="white">${status.count}</td>
            <td class="white">${shippingLine.quantity}</td>
            <td class="white">${shippingLine.partNumber} / ${shippingLine.extendedPartNumber} (${shippingLine.infoPartNumber})</td>
            <td class="white">${shippingLine.description}</td>
        </tr>
        <tr>
            <th colspan="3" class="white">Production Text:</th>
            <td class="white">${shippingLine.productionText}</td>
        </tr>
        <tr>
            <th colspan="3" class="white">Glass Text:</th>
            <td class="white">${shippingLine.glassText}</td>
        </tr>
    </s:iterator>
    <tr><td colspan="4" class="white"><hr color="red" /></td></tr>
    <tr><td><P CLASS="breakhere">&nbsp;</P></td></tr>
</table>
</center>
</body>
<script type="text/javascript">
    <%--Generate Barcode 39--%>
    $(document).ready(function() {
        $(".bcTarget").each(function(){
            var $this = $(this);
            var salesOrder = $this.find("input:first").val();
            $this.barcode(salesOrder, "code39",{barWidth:2, barHeight:30, fontSize:15});
        });

    });
</script>
</html>
