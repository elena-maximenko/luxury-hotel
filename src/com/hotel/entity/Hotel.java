package com.hotel.entity;

import com.hotel.util.DBProxy;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Hotel {
    private static Hotel instance;
    private List<Room> rooms;

    public static synchronized Hotel getInstance() {
        if (instance == null) {
            instance = new Hotel();
            instance.rooms = new ArrayList<>();
        }
        return instance;
    }

    public List<Room> getRooms() {
        return Hotel.getInstance().rooms;
    }

    public void setRooms(List<Room> rooms) {
        Hotel.getInstance().rooms = rooms;
    }

    // images = null
    public void setRoom(int number, Room room) {
        Room oldRoom = rooms.stream().filter(r -> r.getNumber() == number).findFirst().orElse(null);
       try{
           if(oldRoom.getImages().isEmpty()){
               oldRoom.setImages(new DBProxy().getImagesByRoomNumber(number));
           }
       }
       catch (SQLException e){
           e.fillInStackTrace();
       }
        room.setImages(oldRoom.getImages());
        rooms.set(rooms.indexOf(oldRoom), room);
    }
}
