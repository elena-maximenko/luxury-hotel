package com.hotel.enums;

public enum Role {
    ADMIN("Admin"), MANAGER("Manager"), CLIENT("Client");

    private String value;
    Role(String value){
        this.value = value;
    }
    public String getValue(){
        return value;
    }
}
