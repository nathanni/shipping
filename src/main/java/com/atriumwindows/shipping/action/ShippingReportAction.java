package com.atriumwindows.shipping.action;

import com.atriumwindows.shipping.bean.ShippingReport;
import com.atriumwindows.shipping.service.ShippingReportService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import org.apache.struts2.interceptor.RequestAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.Map;

/**
 * Created by Nathan on 2/17/2016.
 */
@Controller
@Scope("prototype")
public class ShippingReportAction extends ActionSupport implements RequestAware, ModelDriven<ShippingReport>, Preparable {


    private String loadNumber;
    public void setLoadNumber(String loadNumber) {
        this.loadNumber = loadNumber;
    }

    private String salesOrder;
    public void setSalesOrder(String salesOrder) {
        this.salesOrder = salesOrder;
    }

    private Map<String, Object> request;

    public void setRequest(Map<String, Object> map) {
        request = map;
    }

    private ShippingReportService shippingReportService;

    @Autowired
    public void setShippingReportService(ShippingReportService shippingReportService) {
        this.shippingReportService = shippingReportService;
    }

    public String getShippingReport() {

        List<String> shippingReportList = shippingReportService.getShippingReportList(loadNumber);
        request.put("reports",shippingReportList);

        return "report";
    }



    private ShippingReport shippingReport;

    public String getShippingReportDetail() {

        return "detail";

    }

    public void prepareGetShippingReportDetail() {
        if(salesOrder != null) {
            shippingReport = shippingReportService.getShippingReport(salesOrder);
        }
        else {
            shippingReport = new ShippingReport();
        }

    }


    public ShippingReport getModel() {
        return shippingReport;
    }



    public void prepare() throws Exception {}
}
