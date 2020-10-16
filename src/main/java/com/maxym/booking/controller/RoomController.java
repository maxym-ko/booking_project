package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.ApplicationStatus;
import com.maxym.booking.domain.application.Bill;
import com.maxym.booking.domain.room.Room;
import com.maxym.booking.domain.room.RoomStatus;
import com.maxym.booking.domain.room.RoomType;
import com.maxym.booking.domain.user.User;
import com.maxym.booking.service.ApplicationService;
import com.maxym.booking.service.RoomService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.Optional;

@Controller
public class RoomController {
    private final ApplicationService applicationService;
    private final RoomService roomService;

    public RoomController(ApplicationService applicationService, RoomService roomService) {
        this.applicationService = applicationService;
        this.roomService = roomService;
    }

    @Transactional
    @PostMapping("/room-book")
    @PreAuthorize("hasAuthority('USER')")
    public String bookRoom(@AuthenticationPrincipal User user, @RequestParam("id") long roomId) {
        Optional<Room> roomOptional = roomService.findRoomById(roomId);
        // todo: handle if isn't present
        if (!roomOptional.isPresent()) {
            return "redirect:/error";
        }

        Room room = roomOptional.get();
        room.setStatus(RoomStatus.BOOKED);

        Bill bill = new Bill(application.getCheckInDate(), application.getCheckOutDate(), room.getPrice());
        application.setBill(bill);
        application.setOwner(user);
        application.setRoom(room);
        application.calcTotalPrice();
        application.setStatus(ApplicationStatus.PAYMENT_WAITING);
        applicationService.saveApplication(application);

        return "redirect:/reservations";
    }

    @PostMapping("/room-remove")
    @PreAuthorize("hasAuthority('ADMIN')")
    public String removeRoom(@RequestParam("id") long roomId) {
        Optional<Room> roomOptional = roomService.findRoomById(roomId);
        // todo: handle if isn't present
        if (!roomOptional.isPresent()) {
            return "redirect:/error";
        }

        roomService.deleteRoomById(roomId);

        return "redirect:/";
    }

    @PostMapping("/room-change")
    @PreAuthorize("hasAuthority('ADMIN')")
    public String removeRoom(@RequestParam("id") long roomId,
                             @RequestParam("capacity") int capacity,
                             @RequestParam("type") String type,
                             @RequestParam("price") double price) {
        Optional<Room> roomOptional = roomService.findRoomById(roomId);
        // todo: handle if isn't present
        if (!roomOptional.isPresent()) {
            return "redirect:/error";
        }

        Room room = roomOptional.get();

        room.setCapacity(capacity);
        room.setType(RoomType.valueOf(type));
        room.setPrice(price);

        roomService.saveRoom(room);

        return "redirect:/";
    }
}
