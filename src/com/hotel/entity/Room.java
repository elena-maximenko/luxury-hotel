package com.hotel.entity;

import com.hotel.enums.Capacity;
import com.hotel.enums.Category;
import com.hotel.enums.State;

import java.util.ArrayList;
import java.util.List;

public class Room {
    private int number;
    private double price;
    private Category category;
    private Capacity capacity;
    private State state;

    private List<Image> images;
    private List<User> users;

    public Room(int number, double price, Category category, Capacity capacity, State state) {
        this.number = number;
        this.price = price;
        this.category = category;
        this.capacity = capacity;
        this.state = state;

        this.users = new ArrayList<>();
        this.images = new ArrayList<>();
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Capacity getCapacity() {
        return capacity;
    }

    public void setCapacity(Capacity capacity) {
        this.capacity = capacity;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public List<Image> getImages() {
        return images;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }
}
