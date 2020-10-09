package com.maxym.booking.repos;

import com.maxym.booking.domain.room.Room;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepo extends JpaRepository<Room, Long> {

}