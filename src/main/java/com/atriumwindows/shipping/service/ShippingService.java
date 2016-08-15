package com.atriumwindows.shipping.service;

import com.atriumwindows.shipping.dao.ShippingDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Nathan on 2/17/2016.
 */
@Service
public class ShippingService {

    /* IOC Bean autowired*/
    private ShippingDao shippingInfoDao;
    @Autowired
    public void setShippingInfoDao(ShippingDao shippingInfoDao) {
        this.shippingInfoDao = shippingInfoDao;
    }


    /*tracking -> salesorder*/
    public String getSalesOrderByTrackingNumber(String trackingNumber) {
        return shippingInfoDao.getSalesOrderByTrackingNumber(trackingNumber);
    }

    /*salesorder -> loadnumber*/
    public String getLoadNumberBySalesOrder(String salesOrder) {
        return shippingInfoDao.getLoadNumberBySalesOrder(salesOrder);
    }

    /*salesorder -> trackingnumber*/
    public String getTrackingNumberBySalesOrder(String salesOrder) {
        return shippingInfoDao.getTrackingNumberBySalesOrder(salesOrder);
    }

    /* only insert data if salesOrder is not associate with trackingNumber*/
    public boolean saveShippingInfo(String salesOrder, String trackingNumber, String shippingMethod) {
        if(!checkAssociate(salesOrder, trackingNumber)) {
            shippingInfoDao.saveShippingInfo(salesOrder, trackingNumber, shippingMethod);
            return true;
        }
        else return false;
    }

    public boolean checkAssociate(String salesOrder, String trackingNumber) {
        return shippingInfoDao.checkAssociate(salesOrder, trackingNumber);
    }
}
