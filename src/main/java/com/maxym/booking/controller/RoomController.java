package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.Bill;
import com.maxym.booking.domain.reservation.Reservation;
import com.maxym.booking.domain.reservation.ReservationStatus;
import com.maxym.booking.domain.room.Room;
import com.maxym.booking.domain.room.RoomStatus;
import com.maxym.booking.domain.room.RoomType;
import com.maxym.booking.domain.user.User;
import com.maxym.booking.service.ApplicationService;
import com.maxym.booking.service.BillService;
import com.maxym.booking.service.ReservationService;
import com.maxym.booking.service.RoomService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.transaction.Transactional;
import java.util.Optional;

@Controller
public class RoomController {
    private final ApplicationService applicationService;
    private final ReservationService reservationService;
    private final RoomService roomService;

    public RoomController(ApplicationService applicationService, ReservationService reservationService, RoomService roomService) {
        this.applicationService = applicationService;
        this.reservationService = reservationService;
        this.roomService = roomService;
    }

    @Transactional
    @PostMapping("/room-book")
    @PreAuthorize("hasAuthority('USER')")
    public String bookRoom(@AuthenticationPrincipal User user, @RequestParam("id") long roomId, Reservation reservation) {
        Optional<Room> roomOptional = roomService.findRoomById(roomId);
        // todo: handle if isn't present
        if (!roomOptional.isPresent()) {
            return "redirect:/error";
        }

        Room room = roomOptional.get();
        room.setStatus(RoomStatus.BOOKED);

        Bill bill = new Bill(reservation.getCheckInDate(), reservation.getCheckOutDate(), room.getPrice());
        Application application = new Application();
        application.setBill(bill);
        applicationService.saveApplicant(application);

        reservation.setApplication(application);
        reservation.setOwner(user);
        reservation.setRoom(room);

        reservation.setStatus(ReservationStatus.PAYMENT_WAITING);
        reservation.calcTotalPrice();
        reservationService.saveReservation(reservation);
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
