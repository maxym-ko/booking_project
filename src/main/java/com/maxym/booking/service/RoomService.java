package com.maxym.booking.service;

import com.maxym.booking.domain.room.Room;
import com.maxym.booking.repos.RoomRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomService {

    private final RoomRepo roomRepo;

    public RoomService(RoomRepo roomRepo) {
        this.roomRepo = roomRepo;
    }

    public List<Room> findAllRooms() {
        return roomRepo.findAll();
    }

    public void saveRoom(Room room) {
        roomRepo.save(room);
    }
}
