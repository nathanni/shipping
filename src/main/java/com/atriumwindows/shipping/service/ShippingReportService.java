package com.atriumwindows.shipping.service;

import com.atriumwindows.shipping.bean.ShippingReport;
import com.atriumwindows.shipping.dao.ShippingReportDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by nni on 2/18/2016.
 */
@Service
public class ShippingReportService {

    /* IOC Bean autowired*/
    private ShippingReportDao shippingReportDao;
    @Autowired
    public void setShippingReportDao(ShippingReportDao shippingReportDao) {
        this.shippingReportDao = shippingReportDao;
    }



    /* Report List*/
    public List<String> getShippingReportList(String loadNumber) {
        return shippingReportDao.getShippingReportList(loadNumber);
    }

    /* Report Detail by salesOrder*/
    public ShippingReport getShippingReport(String salesOrder) {
        return shippingReportDao.getShippingReport(salesOrder);
    }

    /* Suborder Report Detail by salesOrder*/
    public ShippingReport getShippingReportForSubOrder(String salesOrder) {
        return shippingReportDao.getShippingReportForSubOrder(salesOrder);
    }

}




