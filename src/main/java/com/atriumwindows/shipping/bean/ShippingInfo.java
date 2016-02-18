package com.atriumwindows.shipping.bean;

/**
 * Created by Nathan on 2/17/2016.
 */
public class ShippingInfo {

    private String salesOrder;
    private String trackingNumber;
    private String shippingMode;
    private Boolean autoSubmit;
    private String loadNumber;
    private String shippingMethod;

    public String getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public String getSalesOrder() {
        return salesOrder;
    }

    public void setSalesOrder(String salesOrder) {
        this.salesOrder = salesOrder;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getShippingMode() {
        return shippingMode;
    }

    public void setShippingMode(String shippingMode) {
        this.shippingMode = shippingMode;
    }

    public Boolean getAutoSubmit() {
        return autoSubmit;
    }

    public void setAutoSubmit(Boolean autoSubmit) {
        this.autoSubmit = autoSubmit;
    }

    public String getLoadNumber() {
        return loadNumber;
    }

    public void setLoadNumber(String loadNumber) {
        this.loadNumber = loadNumber;
    }

    @Override
    public String toString() {
        return "ShippingInfo{" +
                "salesOrder='" + salesOrder + '\'' +
                ", trackingNumber='" + trackingNumber + '\'' +
                ", shippingMode='" + shippingMode + '\'' +
                ", autoSubmit=" + autoSubmit +
                ", loadNumber='" + loadNumber + '\'' +
                ", shippingMethod='" + shippingMethod + '\'' +
                '}';
    }
}
