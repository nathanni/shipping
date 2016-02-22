package com.atriumwindows.shipping.action;

import com.atriumwindows.shipping.bean.ShippingReport;
import com.atriumwindows.shipping.service.ShippingReportService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;

/**
 * Created by Nathan on 2/17/2016.
 */
@Controller
@Scope("prototype")
public class ShippingReportAction extends ActionSupport implements RequestAware,SessionAware, ModelDriven<ShippingReport>, Preparable {


    private String loadNumber;

    public void setLoadNumber(String loadNumber) {
        this.loadNumber = loadNumber;
    }

    public String getLoadNumber() {
        return loadNumber;
    }

    private String salesOrder;

    public void setSalesOrder(String salesOrder) {
        this.salesOrder = salesOrder;
    }


    private ShippingReportService shippingReportService;

    @Autowired
    public void setShippingReportService(ShippingReportService shippingReportService) {
        this.shippingReportService = shippingReportService;
    }

    /* get shipping report list*/
    public String getShippingReport() {

        List<String> shippingReportList = shippingReportService.getShippingReportList(loadNumber);
        if (shippingReportList == null || shippingReportList.size() == 0) {
            request.put("loadNumber", loadNumber);
            throw new NoSuchElementException();
        }
        session.put("reports", shippingReportList);

        return "report";
    }


    public String getShippingReportDetailAll() {

        return "all";
    }


    /* get shipping report detail*/
    private ShippingReport shippingReport;

    public String getShippingReportDetail() {

        if(shippingReport == null) {
            request.put("salesOrder", salesOrder);
            throw new NoSuchElementException();
        }
        return "detail";

    }

    public void prepareGetShippingReportDetail() {
        if (salesOrder != null && !salesOrder.isEmpty()) {
            if (salesOrder.matches("^[AB]{1}\\d+")) //A B SubOrder
                shippingReport = shippingReportService.getShippingReportForSubOrder(salesOrder);
            else
                shippingReport = shippingReportService.getShippingReport(salesOrder);
        }
    }


    public ShippingReport getModel() {
        return shippingReport;
    }


    public void prepare() throws Exception {
    }

    private Map<String, Object> session;

    public void setSession(Map<String, Object> map) {
        this.session = map;
    }

    private Map<String, Object> request;
    public void setRequest(Map<String, Object> map) {
        request = map;
    }
}
