<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: nni
  Date: 2/17/2016
  Time: 3:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Shipping Record Selection</title>
</head>
<body>

<s:form action="" method="POST" theme="simple">
    <table border="1" align="center" id="container" cellspacing="0" cellpadding="10">
        <thead>
            <tr>
                <th colspan="3">Search by Sales Order/Tracking Number</th>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>Sales Order:</td>
            <td><s:textfield name="salesorder"></s:textfield></td>
            <td><s:submit></s:submit></td>
        </tr>
        </tbody>
    </table>
</s:form>

<s:form action="get-report" method="POST">
    <table border="1" align="center" id="container" cellspacing="0" cellpadding="10">
        <s:textfield name="load" label="Load Number"></s:textfield>
        <s:submit value="Print Preview"></s:submit>
    </table>
</s:form>

</body>
</html>
