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

        /*        $(document).ready(function () {
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
         });*/



        $(function() {

            function validatesalesOrders() {
                //validate sales order length
                if($('#salesOrder').val().length != 8) {
                    alert("Sales Order must be exactly 8 characters.");
                    return false;
                }
                return true;
            }


            function validateTrackingNumber() {
                //validate tracking number length
                if($('#trackingNumber').val().length == 0) {
                    alert('Please enter Tracking Number');
                    return false;
                }
                if($('input[name=shippingMethod]:checked').val() == null) {
                    alert('Please select Shipping Method');
                    return false;
                }
                if($('input[name=shippingMode]:checked').val() == null) {
                    alert('Please select Shipping Mode');
                    return false;
                }
                return true;
            }

            function searchSalesOrder() {
                var salesOrder = $('#salesOrder').val();
                var tracking = $('#trackingNumber').val();
                var method = $('input[name=shippingMethod]:checked').val();
                var mode = $('input[name=shippingMode]:checked').val();
                var auto = $('input[name=autoSubmit]:checked').val();

                if ($('#salesOrder').val().length == 8) {
                    if (method == "UPS" && tracking.length == 18 && tracking.substr(0,2) == "1Z" && auto == "true") {
                        saveShippingInfo();
                    } else if (auto == "true" && method == "FedEx" && (tracking.length == 12 || tracking.length == 15 || tracking.length == 22 || tracking.length == 32 || tracking.length == 34)) {
                        saveShippingInfo();
                    } else {
                        //disable anther textfield when users hit "SEARCH"
                        $('#trackingNumber').prop('disabled', true);
                        $('#searchform').submit();
                    }
                }
                return false;
            }

            function searchTrackingNumber() {

                var salesOrder = $('#salesOrder').val();
                var tracking = $('#trackingNumber').val();
                var method = $('input[name=shippingMethod]:checked').val();
                var mode = $('input[name=shippingMode]:checked').val();
                var auto = $('input[name=autoSubmit]:checked').val();

                if($('input[name=shippingMethod]:checked').val() == null) {
                    alert('Please select Shipping Method');
                    return false;
                }
                if($('input[name=shippingMode]:checked').val() == null) {
                    alert('Please select Shipping Mode');
                    return false;
                }

                if (method == "UPS") {
                    if (tracking.length == 18) {
                        if (tracking.substr(0,2) == "1Z") {
                            if (auto == "true" && salesOrder.length == "8") {
                                saveShippingInfo();
                            } else {
                                //disable anther textfield when users hit "SEARCH"
                                $('#salesOrder').prop('disabled', true);
                                $('#searchform').submit();
                            }

                        } else {
                            alert('UPS Tracking Numbers must begin with "1Z".');
                        }
                    }

                } else if (method == "FedEx") {
                    if (auto == "true") {
                        if (tracking.length == 0 || tracking.length == 12 || tracking.length == 15 || tracking.length == 22 || tracking.length == 32 || tracking.length == 34) {
                            if (mode == "Ground" && tracking.length == 34) {
                                if (salesOrder.length == "8") {
                                    saveShippingInfo();
                                } else {
                                    $('#trackingNumber').val(tracking.substring(22));
                                    //disable anther textfield when users hit "SEARCH"
                                    $('#salesOrder').prop('disabled', true);
                                    $('#searchform').submit();
                                }
                            } else if (mode == "Ground" && tracking.length == 22) {
                                if (salesOrder.length == "8") {
                                    saveShippingInfo();
                                } else {
                                    $('#trackingNumber').val(tracking.substring(7, 22));
                                    //disable anther textfield when users hit "SEARCH"
                                    $('#salesOrder').prop('disabled', true);
                                    $('#searchform').submit();
                                }

                            } else {
                                if (salesOrder.length == "8") {
                                    saveShippingInfo();
                                } else {
                                    //disable anther textfield when users hit "SEARCH"
                                    $('#salesOrder').prop('disabled', true);
                                    $('#searchform').submit();
                                }
                            }
                        }
                    }

                }
                return false;
            }


            //Sales Order search button validation
            $('#searchSalesOrder').click(searchSalesOrder);

            //Tracking Number search button validation
            $('#searchTrackingNumber').click(searchTrackingNumber);


            //validate sales order and tracking number when saving
            $('#save').click(saveShippingInfo);


            //save salesOrder and trackingNumber association
            function saveShippingInfo() {
                if(!validatesalesOrders()) return false;
                if(!validateTrackingNumber()) return false;
                var tracking = $('#trackingNumber').val();
                var method = $('input[name=shippingMethod]:checked').val();
                var mode = $('input[name=shippingMode]:checked').val();

                if (method == "FedEx") {
                    if (tracking.length != 12 && tracking.length != 15 && tracking.length != 22 && tracking.length != 32 && tracking.length != 34) {
                        alert('FedEx Tracking Numbers must be exactly 12, 15, 22, 32 or 34 characters.');
                        return false;
                    } else {
                        if (mode == "Ground" && tracking.length == 22) {
                            $('#trackingNumber').val(tracking.substring(7, 22));
                        } else if (mode != "Ground" && tracking.length == 32) {
                            $('#trackingNumber').val(tracking.substring(16, 28));
                        } else if (mode == "Ground" && tracking.length == 34) {
                            $('#trackingNumber').val(tracking.substring(22));
                        }
                    }
                } else if (method == "UPS") {
                    if (tracking.substr(0,2) != "1Z") {
                        alert('UPS Tracking Numbers must begin with "1Z".');
                        return false;
                    }
                    else if(tracking.length != 18) {
                        alert('UPS Tracking Numbers must be exactly 18 characters.');
                        return false;
                    }
                } else {
                    return false;
                }


                $('#searchform').attr('action', 'save-shipping-info');
                $('#searchform').submit();

                return false;
            }



            //validate load number
            $('#searchLoadNumber').click(function () {
                var val = $('#loadNumber').val();
                if (Number(val) > 0) {
                    while (val.length < 5) {
                        val = "0" + val;
                    }
                    $('#loadNumber').val(val);
                }
                else {
                    alert("Invalid Load Number");
                    return false;
                }
            });


            function autoSubmit() {
                var auto = $('input[name=autoSubmit]:checked').val();

                if(auto == "true") {
                    $('#salesOrder').bind('keyup', searchSalesOrder);
                    $('#trackingNumber').bind('keyup', searchTrackingNumber)
                } else {
                    $('#salesOrder').unbind();
                    $('#trackingNumber').unbind();
                }
            }


            //detect when autosubmit change
            $('input[name=autoSubmit]').change(autoSubmit);

            //load autosubmit at the first time
            $(document).ready(autoSubmit);


            function focus() {
                var salesOrder = $('#salesOrder').val();
                var trackingNumber = $('#trackingNumber').val();
                //move cursor to tracking number when salesorder is not empty and trackingnumber is empty
                if (salesOrder && !trackingNumber) {
                    $('#trackingNumber').focus();
                //other cases default the cursor to salesorder
                } else {
                    $('#salesOrder').focus();
                }
            }

            //textfield focus
            $(document).ready(focus);





        });

    </script>
</head>
<body>

<s:form action="shipping-info" method="POST" theme="simple" id="searchform">
    <table border="1" align="center" id="container" cellspacing="0" cellpadding="10">
        <thead>
        <tr>
            <th colspan="3">Search by Sales Order/Tracking Number</th>
        </tr>
        </thead>
        <tbody>
        <tr>
                <%--<td><s:select list="{'Sales Order', 'Tracking Number'}" id="selectlist"></s:select></td>--%>
            <td>Sales Order</td>
            <td><s:textfield name="salesOrder" id="salesOrder"></s:textfield></td>
            <td><s:submit value="Search" id="searchSalesOrder"></s:submit></td>
        </tr>
        <tr>
            <td>Tracking Number</td>
            <td><s:textfield name="trackingNumber" id="trackingNumber"></s:textfield></td>
            <td><s:submit value="Search" id="searchTrackingNumber"></s:submit></td>
        </tr>
        <tr>
            <td>Shipping Method</td>
            <td colspan="2">
                <center>
                    <div><s:radio list="#{'FedEx':'FedEx','UPS':'UPS'}" name="shippingMethod" id="shippingMethod" value="shippingMethod == null ?'FedEx': shippingMethod" ></s:radio></div>
                    <div>Tracking:
                        <a target="_blank" href="https://www.fedex.com/apps/fedextrack/?action=track&ascend_header=1&clienttype=dotcom&cntry_code=us&language=english&tracknumbers=${trackingNumber}">FedEx</a>
                        &nbsp;
                        <a target="_blank" href="https://wwwapps.ups.com/tracking/tracking.cgi?tracknum=${trackingNumber}">UPS</a>
                    </div>
                </center>
            </td>
        </tr>
        <tr>
            <td>Shipping Mode</td>
            <td colspan="2">
                <center>
                    <s:radio list="#{'Ground':'Ground','Express':'Express'}" name="shippingMode" id="shippingMode" value="shippingMode == null ? 'Ground':shippingMode"></s:radio>
                </center>
            </td>
        </tr>
        <tr>
            <td>Auto Submit</td>
            <td colspan="2">
                <center>
                    <s:radio list="#{true:'On',false:'Off'}" name="autoSubmit" id="autoSubmit" value="autoSubmit == null ? true: autoSubmit"></s:radio>
                </center>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <center><s:submit value="Save" id="save"></s:submit></center>
            </td>
        </tr>
        </tbody>
    </table>
</s:form>

<center><font color="red"><s:actionerror></s:actionerror></font></center>

<s:form action="shipping-report" method="POST">
    <table border="1" align="center" id="container" cellspacing="0" cellpadding="10">
        <s:textfield name="loadNumber" label="Load Number" id="loadNumber"></s:textfield>
        <s:submit value="Print Preview" id="searchLoadNumber"></s:submit>
    </table>
</s:form>

<table border="1" align="center" >
    <tr align="center">
        <td>NOTES:</td>
        <td>
            <ul>"Ground" Shipping Mode will parse Tracking # and Auto Submit at 22 characters.</ul>
            <ul>"Express" Shipping Mode will parse Tracking # and Auto Submit at 32 characters.</ul>
            <ul>For manual entry, switch Auto Submit to Off.</ul>
        </td>
    </tr>
</table>

<center><p><font color="blue">This new page supports to pull out "27 how ship" - A and B suborders</font></p></center>
<center><p><font color="blue">If you encount any issues in this page, please use the old link: <a href="http://10.16.2.99/shipping.asp">http://10.16.2.99/shipping.asp</a> instead and report to IT.</font></p></center>

</body>
</html>
