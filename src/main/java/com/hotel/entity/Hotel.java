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
        return instance.rooms;
    }

    public void setRooms(List<Room> rooms) {
        instance.rooms = rooms;
    }

    public Room getRoomByNumber(int number){
        return rooms.stream().filter(r -> r.getNumber() == number).findFirst().orElse(null);
    }

    public void setRoom(int number, Room room) {
        Room oldRoom = rooms.stream().filter(r -> r.getNumber() == number).findFirst().orElse(null);
       try{
           if(oldRoom.getImages().isEmpty()){
               oldRoom.setImages(DBProxy.getInstance().getImagesByRoomNumber(number));
           }
       }
       catch (SQLException e){
           e.fillInStackTrace();
       }
        room.setImages(oldRoom.getImages());
        rooms.set(rooms.indexOf(oldRoom), room);
    }
}
