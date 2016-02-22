package com.atriumwindows.shipping.action;

import com.atriumwindows.shipping.bean.ShippingInfo;
import com.atriumwindows.shipping.service.ShippingService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

/**
 * Created by nni on 2/17/2016.
 */
@Controller
@Scope("prototype")
public class ShippingAction extends ActionSupport implements ModelDriven<ShippingInfo>, Preparable {



    private ShippingService shippingInfoService;

    @Autowired
    public void setShippingInfoService(ShippingService shippingInfoService) {
        this.shippingInfoService = shippingInfoService;
    }

    private ShippingInfo shippingInfo;

    /*action: shipping-info*/
    public String searchShippingInfo() {
        String salesOrder = shippingInfo.getSalesOrder() == null ? "":shippingInfo.getSalesOrder().trim();
        String trackingNumber = shippingInfo.getTrackingNumber() == null ? "":shippingInfo.getTrackingNumber().trim();
        String loadNumber;
        if(!salesOrder.isEmpty()) {
            trackingNumber = shippingInfoService.getTrackingNumberBySalesOrder(salesOrder);
            if (trackingNumber == null) {
                addActionError("No Tracking Number was found.");
            }

        } else if(!trackingNumber.isEmpty()) {
            salesOrder = shippingInfoService.getSalesOrderByTrackingNumber(trackingNumber);
            if(salesOrder == null) {
                addActionError("No Sales Order was found.");
            }
        } else {
            return SUCCESS;
        }

        loadNumber = shippingInfoService.getLoadNumberBySalesOrder(salesOrder);
        if (loadNumber == null) {
            addActionError("No Load Number was found.");
        }
        shippingInfo.setSalesOrder(salesOrder);
        shippingInfo.setLoadNumber(loadNumber);
        shippingInfo.setTrackingNumber(trackingNumber);
        System.out.println(shippingInfo);
        return SUCCESS;
    }

    public ShippingInfo getModel() {
        return shippingInfo;
    }

    public void prepareSearchShippingInfo() {
        shippingInfo = new ShippingInfo();
    }

    public void prepare() throws Exception {
    }
}
