package com.maxym.booking.service;

import com.maxym.booking.domain.room.Room;
import com.maxym.booking.repos.RoomRepo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoomService {

    private final RoomRepo roomRepo;

    public RoomService(RoomRepo roomRepo) {
        this.roomRepo = roomRepo;
    }

    public void saveRoom(Room room) {
        roomRepo.save(room);
    }

    public List<Room> findAllRooms() {
        return roomRepo.findAll();
    }

    public Optional<Room> findRoomById(long id) {
        return roomRepo.findById(id);
    }

    public void deleteRoomById(long id) {
        roomRepo.deleteById(id);
    }
}
