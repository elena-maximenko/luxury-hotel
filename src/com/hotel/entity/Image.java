package com.hotel.entity;

public class Image {
    private String UId;
    private String url;

    public String getUId() {
        return UId;
    }

    public void setUId(String UId) {
        this.UId = UId;
    }

    public Image(String uId, String url) {
        this.UId = uId;
        this.url = url;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
