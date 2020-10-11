package com.maxym.booking.service;

import com.maxym.booking.domain.room.Room;
import com.maxym.booking.repos.RoomRepo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

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

    public Page<Room> findAllRooms(Pageable pageable) {
        return roomRepo.findAll(pageable);
    }

    public Optional<Room> findRoomById(long id) {
        return roomRepo.findById(id);
    }

    public void deleteRoomById(long id) {
        roomRepo.deleteById(id);
    }
}
