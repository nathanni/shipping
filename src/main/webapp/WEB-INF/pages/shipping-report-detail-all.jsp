<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: nni
  Date: 2/19/2016
  Time: 3:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Report For Load#${loadNumber}</title>
    <style>
        table {
            width: 100%;
        }
    </style>
</head>
<body>

    <s:iterator value="#session.reports" var="report">
        <s:action name="shipping-report-detail" executeResult="true" namespace="/" ignoreContextParams="true" >
            <s:param name="salesOrder">${report}</s:param>
        </s:action>
        <br><br>
    </s:iterator>



</body>
</html>
