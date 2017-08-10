package com.hotel.enums;

public enum Capacity {SINGLE("Single"), DOUBLE("Double"), TWIN("Twin"), TRIPLE("Triple"),
    EXTRA_BED("Extra bed"), QUADRIPLE("Quardiple"), CHILD("Child");
    private final String value;
    Capacity(String value){
        this.value = value;
    }
    public String getValue(){
        return value;
    }
};
