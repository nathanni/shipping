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
    <title>Request For Sales Order #${salesOrder}</title>
    <script type="text/javascript" src="../../scripts/jquery-1.12.0.min.js"></script>
    <script type="text/javascript" src="../../scripts/jquery-barcode.min.js"></script>

</head>
<body>

<table border="1" cellpadding="10" cellspacing="0">
    <tr>
        <td>Sales Order</td>
        <td>
            <div class="bcTarget">
                <input type="hidden" value="${salesOrder}">
            </div>
        </td>
    </tr>
    <tr>
        <td>Customer Code</td>
        <td>${accountId} - ${accountName}</td>
    </tr>
    <tr>
        <td>Cut Off Dayr</td>
        <td>${cutOffDay}</td>
    </tr>
    <tr>
        <td>Order Date</td>
        <td>${orderDate}</td>
    </tr>
    <tr>
        <td>Due Date</td>
        <td>${dueDate}</td>
    </tr>
    <tr>
        <td>Sales Order</td>
        <td>${salesOrder}</td>
    </tr>
    <tr>
        <td>Ship Code</td>
        <td>${shipCode} - ${shipCodeDesc}</td>
    </tr>
    <tr>
        <td>Region Code</td>
        <td>${salesOrder}</td>
    </tr>
    <tr>
        <td>Route Code</td>
        <td>${routeCode}</td>
    </tr>
    <tr>
        <td>Quote Number</td>
        <td>${orderId}</td>
    </tr>
    <tr>
        <td>Job Name</td>
        <td>${jobName}</td>
    </tr>
    <tr>
        <td>Purchase Order</td>
        <td>${purchaseOrder}</td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>

    <tr>
        <td>Ship To</td>
        <td>Bill To</td>
    </tr>
    <tr>
        <td>${shipName}</td>
        <td>${accountName}</td>
    </tr>
    <tr>
        <td>${shipAddress1}</td>
        <td>${billAddress1}</td>
    </tr>
    <tr>
        <td>${shipAddress2}</td>
        <td>${billAddress2}</td>
    </tr>
    <tr>
        <td>${shipCity}&nbsp;${shipState}&nbsp;${shipZip}</td>
        <td>${billCity}&nbsp;${billState}&nbsp;${billZip}</td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
    <s:iterator value="shippingLines" var="shippingLine" status="status">
        <tr>
            <th>Line</th>
            <th>Quantity</th>
            <th>Part Number</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>${status.count}</td>
            <td>${shippingLine.quantity}</td>
            <td>${shippingLine.partNumber}</td>
            <td>${shippingLine.description}</td>
        </tr>
        <tr>
            <th>Production Text:</th>
            <td>${shippingLine.productionText}</td>
        </tr>
        <tr>
            <th>Glass Text:</th>
            <td>${shippingLine.glassText}</td>
        </tr>
    </s:iterator>
</table>

</body>
<script type="text/javascript">
    <%--Generate Barcode 39--%>
    $(document).ready(function() {
        $(".bcTarget").each(function(){
            var $this = $(this);
            var salesOrder = $this.find("input:first").val();
            $this.barcode(salesOrder, "code39",{barWidth:2, barHeight:40, fontSize:15});
        });

    });
</script>
</html>
