package com.atriumwindows.shipping.action;

import com.opensymphony.xwork2.ActionSupport;
import org.springframework.stereotype.Controller;

/**
 * Created by Nathan on 2/17/2016.
 */
@Controller
public class ShippingReportAction extends ActionSupport {

    public String getShippingReport() {

        return SUCCESS;
    }
}
