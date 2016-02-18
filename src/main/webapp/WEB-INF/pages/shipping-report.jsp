<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: nni
  Date: 2/17/2016
  Time: 3:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Report For Load #70800</title>
</head>
<body>



<center>
    <table border="1" cellpadding="10" cellspacing="0">
        <thead>
            <th>Shipping Report Page</th>
        </thead>

        <tr>
            <td><a href="">Vew ReportFor All Sales Order</a></td>
        </tr>
        <s:iterator value="#request.reports" var="report">
            <tr>
                <td><a href="shipping-report-detail?salesOrder=${report}">View Report For Sales Order #${report}</a></td>
            </tr>
        </s:iterator>
    </table>
</center>

</body>
</html>
