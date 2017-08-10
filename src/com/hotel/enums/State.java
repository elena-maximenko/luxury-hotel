package com.hotel.enums;

public enum  State {
    AVAILABLE("Available"), UNAVAILABLE("Unavailable"), RESERVED("Reserved"), OCCUPIED("Occupied");
        private String value;
        State(String value) {
            this.value = value;
        }
    public String getValue(){
        return value;
    }
}
