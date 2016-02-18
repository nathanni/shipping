package com.atriumwindows.shipping.action;

import com.atriumwindows.shipping.bean.ShippingInfo;
import com.atriumwindows.shipping.service.ShippingInfoService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 * Created by nni on 2/17/2016.
 */
@Controller
public class ShippingAction extends ActionSupport implements ModelDriven<ShippingInfo>, Preparable {



    /*property: ShippingInfoService*/
    private ShippingInfoService shippingInfoService;

    @Autowired
    public void setShippingInfoService(ShippingInfoService shippingInfoService) {
        this.shippingInfoService = shippingInfoService;
    }

    private ShippingInfo shippingInfo;

    /*action: shipping-info*/
    public String searchShippingInfo() {
        System.out.println(shippingInfo);

        String loadNumber = shippingInfoService.getLoadNumberBySalesOrder(shippingInfo.getSalesOrder());
        String trakcingNumber = shippingInfoService.getTrackingNumberBySalesOrder(shippingInfo.getSalesOrder());

        if (loadNumber == null) {
            addActionError("No Load Number was found for that Sales Order.");
        }
        if (trakcingNumber == null) {
            addActionError("No Tracking Number was found for that Sales Order.");
        }

        shippingInfo.setLoadNumber(loadNumber);
        shippingInfo.setTrackingNumber(trakcingNumber);

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
