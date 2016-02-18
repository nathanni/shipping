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
    <script type="text/javascript" src="scripts/jquery-1.12.0.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $('#selectlist').change(function() {
                var $this = $(this);
                var td = $this.parent().next("td");
                td.find("input").remove();
                var select = $this.val();
                if(select == "Sales Order") {
                    td.append("<input type='text' name='salesOrder'/>");
                } else if(select == "Tracking Number") {
                    var tr = $this.parent().parent();
                    td.append("<input type='text' name='trackingNumber'/>");
                }
            });
        });
    </script>
</head>
<body>


<s:actionmessage></s:actionmessage>
<s:form action="shipping-info" method="POST" theme="simple" id="searchform">
    <table border="1" align="center" id="container" cellspacing="0" cellpadding="10">
        <thead>
        <tr>
            <th colspan="3">Search by Sales Order/Tracking Number</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><s:select list="{'Sales Order', 'Tracking Number'}" id="selectlist"></s:select></td>
            <td><s:textfield name="salesOrder"></s:textfield></td>
            <td><s:submit value="Search"></s:submit></td>
        </tr>
        <tr>
            <td>Shipping Method</td>
            <td colspan="2">
                <center>
                    <s:radio list="{'FedEx','UPS'}" name="shippingMethod"></s:radio>
                </center>
            </td>
        </tr>
        <tr>
            <td>Shipping Mode</td>
            <td colspan="2">
                <center>
                    <s:radio list="{'Ground','Express'}" name="shippingMode"></s:radio>
                </center>
            </td>
        </tr>
        <tr>
            <td>Auto Submit</td>
            <td colspan="2">
                <center>
                    <s:radio list="#{true:'On',false:'Off'}" name="autoSubmit"></s:radio>
                </center>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <center><s:submit value="Save"></s:submit></center>
            </td>
        </tr>
        </tbody>
    </table>
</s:form>

<center><font color="red"><s:actionerror></s:actionerror></font></center>

<s:form action="shipping-report" method="POST">
    <table border="1" align="center" id="container" cellspacing="0" cellpadding="10">
        <s:textfield name="loadNumber" label="Load Number"></s:textfield>
        <s:submit value="Print Preview"></s:submit>
    </table>
</s:form>

</body>
</html>
