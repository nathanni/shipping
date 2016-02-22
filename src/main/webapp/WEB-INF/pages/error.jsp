<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Nathan
  Date: 2/21/2016
  Time: 10:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <s:if test="#request.salesOrder != null">
        <h4><font color="red">No detail report information was found with Sales Order #${requestScope.salesOrder}</font></h4>
    </s:if>
    <s:if test="#request.loadNumber !=null">
        <h4><font color="red">No order was found with Load Number #${requestScope.loadNumber}</font><h4>
    </s:if>
</body>
</html>
