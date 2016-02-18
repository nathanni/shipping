package com.atriumwindows.shipping.bean;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by nni on 2/18/2016.
 */
public class ShippingReport {

    private String salesOrder;
    private String accountId;
    private String accountName;  //same as billName;
    private String cutOffDay;
    private String orderDate;
    private String dueDate;
    private String shipCode;
    private String shipcCodeDesc;
    private String regionCode;
    private String routeCode;
    private String orderId;
    private String jobName;
    private String purchaseOrder;

    /*SHIP TO*/
    private String shipName;
    private String shipStreet1;
    private String shipStreet2;
    private String shipCity;
    private String shipState;
    private String shipZip;

    /*BILL TO*/
    //private String billName;
    private String billAddress1;
    private String billAddress2;
    private String billCity;
    private String billState;
    private String billZip;

    /*LINES*/
    List<ShippingReportLine> shippingLines;


    public String getSalesOrder() {
        return salesOrder;
    }

    public void setSalesOrder(String salesOrder) {
        this.salesOrder = salesOrder;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getCutOffDay() {
        return cutOffDay;
    }

    public void setCutOffDay(String cutOffDay) {
        this.cutOffDay = cutOffDay;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public String getShipCode() {
        return shipCode;
    }

    public void setShipCode(String shipCode) {
        this.shipCode = shipCode;
    }

    public String getShipcCodeDesc() {
        return shipcCodeDesc;
    }

    public void setShipcCodeDesc(String shipcCodeDesc) {
        this.shipcCodeDesc = shipcCodeDesc;
    }

    public String getRegionCode() {
        return regionCode;
    }

    public void setRegionCode(String regionCode) {
        this.regionCode = regionCode;
    }

    public String getRouteCode() {
        return routeCode;
    }

    public void setRouteCode(String routeCode) {
        this.routeCode = routeCode;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(String purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    public String getShipName() {
        return shipName;
    }

    public void setShipName(String shipName) {
        this.shipName = shipName;
    }

    public String getShipStreet1() {
        return shipStreet1;
    }

    public void setShipStreet1(String shipStreet1) {
        this.shipStreet1 = shipStreet1;
    }

    public String getShipStreet2() {
        return shipStreet2;
    }

    public void setShipStreet2(String shipStreet2) {
        this.shipStreet2 = shipStreet2;
    }

    public String getShipCity() {
        return shipCity;
    }

    public void setShipCity(String shipCity) {
        this.shipCity = shipCity;
    }

    public String getShipState() {
        return shipState;
    }

    public void setShipState(String shipState) {
        this.shipState = shipState;
    }

    public String getShipZip() {
        return shipZip;
    }

    public void setShipZip(String shipZip) {
        this.shipZip = shipZip;
    }

    public String getBillAddress1() {
        return billAddress1;
    }

    public void setBillAddress1(String billAddress1) {
        this.billAddress1 = billAddress1;
    }

    public String getBillAddress2() {
        return billAddress2;
    }

    public void setBillAddress2(String billAddress2) {
        this.billAddress2 = billAddress2;
    }

    public String getBillCity() {
        return billCity;
    }

    public void setBillCity(String billCity) {
        this.billCity = billCity;
    }

    public String getBillState() {
        return billState;
    }

    public void setBillState(String billState) {
        this.billState = billState;
    }

    public String getBillZip() {
        return billZip;
    }

    public void setBillZip(String billZip) {
        this.billZip = billZip;
    }

    public List<ShippingReportLine> getShippingLines() {
        return shippingLines;
    }

    @Autowired
    public void setShippingLines(List<ShippingReportLine> shippingLines) {
        this.shippingLines = shippingLines;
    }

    @Override
    public String toString() {
        return "ShippingReport{" +
                "salesOrder='" + salesOrder + '\'' +
                ", accountId='" + accountId + '\'' +
                ", accountName='" + accountName + '\'' +
                ", cutOffDay='" + cutOffDay + '\'' +
                ", orderDate='" + orderDate + '\'' +
                ", dueDate='" + dueDate + '\'' +
                ", shipCode='" + shipCode + '\'' +
                ", shipcCodeDesc='" + shipcCodeDesc + '\'' +
                ", regionCode='" + regionCode + '\'' +
                ", routeCode='" + routeCode + '\'' +
                ", orderId='" + orderId + '\'' +
                ", jobName='" + jobName + '\'' +
                ", purchaseOrder='" + purchaseOrder + '\'' +
                ", shipName='" + shipName + '\'' +
                ", shipStreet1='" + shipStreet1 + '\'' +
                ", shipStreet2='" + shipStreet2 + '\'' +
                ", shipCity='" + shipCity + '\'' +
                ", shipState='" + shipState + '\'' +
                ", shipZip='" + shipZip + '\'' +
                ", billAddress1='" + billAddress1 + '\'' +
                ", billAddress2='" + billAddress2 + '\'' +
                ", billCity='" + billCity + '\'' +
                ", billState='" + billState + '\'' +
                ", billZip='" + billZip + '\'' +
                ", shippingLines=" + shippingLines +
                '}';
    }
}
