package com.atriumwindows.shipping.bean;

/**
 * Created by nni on 2/18/2016.
 */
public class ShippingReportLine {

    private Integer quantity;
    private String partNumber;
    private String extendedPartNumber;
    private String infoPartNumber;
    private String description;
    private String productionText;
    private String glassText;

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getPartNumber() {
        return partNumber;
    }

    public void setPartNumber(String partNumber) {
        this.partNumber = partNumber;
    }

    public String getExtendedPartNumber() {
        return extendedPartNumber;
    }

    public void setExtendedPartNumber(String extendedPartNumber) {
        this.extendedPartNumber = extendedPartNumber;
    }

    public String getInfoPartNumber() {
        return infoPartNumber;
    }

    public void setInfoPartNumber(String infoPartNumber) {
        this.infoPartNumber = infoPartNumber;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProductionText() {
        return productionText;
    }

    public void setProductionText(String productionText) {
        this.productionText = productionText;
    }

    public String getGlassText() {
        return glassText;
    }

    public void setGlassText(String glassText) {
        this.glassText = glassText;
    }

    @Override
    public String toString() {
        return "ShippingReportLine{" +
                "quantity=" + quantity +
                ", partNumber='" + partNumber + '\'' +
                ", extendedPartNumber='" + extendedPartNumber + '\'' +
                ", infoPartNumber='" + infoPartNumber + '\'' +
                ", description='" + description + '\'' +
                ", productionText='" + productionText + '\'' +
                ", glassText='" + glassText + '\'' +
                '}';
    }

    public ShippingReportLine(Integer quantity, String partNumber, String extendedPartNumber, String infoPartNumber, String description, String productionText, String glassText) {
        this.quantity = quantity;
        this.partNumber = partNumber;
        this.extendedPartNumber = extendedPartNumber;
        this.infoPartNumber = infoPartNumber;
        this.description = description;
        this.productionText = productionText;
        this.glassText = glassText;
    }

    public ShippingReportLine() {
    }
}
