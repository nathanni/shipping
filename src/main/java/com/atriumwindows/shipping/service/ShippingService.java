package com.atriumwindows.shipping.service;

import com.atriumwindows.shipping.dao.ShippingDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Nathan on 2/17/2016.
 */
@Service
public class ShippingService {

    private ShippingDao shippingInfoDao;

    @Autowired
    public void setShippingInfoDao(ShippingDao shippingInfoDao) {
        this.shippingInfoDao = shippingInfoDao;
    }

    public String getSalesOrderByTrackingNumber(String trackingNumber) {
        return shippingInfoDao.getSalesOrderByTrackingNumber(trackingNumber);
    }

    public String getLoadNumberBySalesOrder(String salesOrder) {
        return shippingInfoDao.getLoadNumberBySalesOrder(salesOrder);
    }

    public String getTrackingNumberBySalesOrder(String salesOrder) {
        return shippingInfoDao.getTrackingNumberBySalesOrder(salesOrder);
    }
}
