package com.hotel.entity;

import com.hotel.enums.Role;

public class User {
    private String uId;
    private int id;
    private Role role;
    private String login;
    private String firstName;
    private String lastName;
    private String password;

    public User(String uId, int id, Role role, String firstName, String lastName, String login, String password) {
        this.uId = uId;
        this.id = id;
        this.role = role;
        this.firstName = firstName;
        this.lastName = lastName;
        this.login = login;
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getUId() {
        return uId;
    }

    public void setUId(String UId) {
        this.uId = UId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
