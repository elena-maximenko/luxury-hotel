package com.hotel.entity;

import java.util.ArrayList;
import java.util.List;

public class Hotel {
    private static Hotel instance;
    private List<Room> rooms;

    public static synchronized Hotel getInstance(){
      if (instance == null){
          instance = new Hotel();
          instance.rooms = new ArrayList<>();
      }
      return instance;
    }

    public  List<Room> getRooms() {
        return Hotel.getInstance().rooms;
    }

    public void setRooms(List<Room> rooms) {
        Hotel.getInstance().rooms = rooms;
    }
}
