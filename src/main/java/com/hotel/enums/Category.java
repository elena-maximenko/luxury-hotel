package com.hotel.enums;

public enum Category {JUNIOR_SUITE("Junior Suite"), DE_LUXE("De Luxe"), SUITE("Suite"), BUSINESS_ROOM("Business room"),
    FAMILY_STUDIO("Family studio"), KING_SUITE("King Suite"), PRESIDENT_SUITE("President Suite");
    private final String value;
    Category(String value){
        this.value = value;
    }
    public String getValue(){
        return value;
    }
};
