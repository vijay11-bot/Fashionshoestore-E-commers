package com.fashionshoestore.model;

import java.io.Serializable;

public class ProductSize implements Serializable {
    private static final long serialVersionUID = 1L;

    private int productSizeId;
    private int productId;
    private String sizeLabel;
    private int stockQuantity;
    private String skuCode;
    private boolean isAvailable;

    public ProductSize() {
    }

    public ProductSize(int productSizeId, int productId, String sizeLabel, int stockQuantity, String skuCode, boolean isAvailable) {
        this.productSizeId = productSizeId;
        this.productId = productId;
        this.sizeLabel = sizeLabel;
        this.stockQuantity = stockQuantity;
        this.skuCode = skuCode;
        this.isAvailable = isAvailable;
    }

    public int getProductSizeId() {
        return productSizeId;
    }

    public void setProductSizeId(int productSizeId) {
        this.productSizeId = productSizeId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getSizeLabel() {
        return sizeLabel;
    }

    public void setSizeLabel(String sizeLabel) {
        this.sizeLabel = sizeLabel;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getSkuCode() {
        return skuCode;
    }

    public void setSkuCode(String skuCode) {
        this.skuCode = skuCode;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }
}
