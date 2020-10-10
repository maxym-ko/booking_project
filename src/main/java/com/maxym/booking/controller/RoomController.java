package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.ApplicationStatus;
import com.maxym.booking.domain.application.Bill;
import com.maxym.booking.domain.reservation.Reservation;
import com.maxym.booking.domain.reservation.ReservationStatus;
import com.maxym.booking.domain.room.Room;
import com.maxym.booking.domain.room.RoomStatus;
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
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Optional;

@Controller
@PreAuthorize("hasAuthority('USER')")
public class RoomController {
    private final BillService billService;
    private final ReservationService reservationService;
    private final RoomService roomService;

    public RoomController(BillService billService, ReservationService reservationService, RoomService roomService) {
        this.billService = billService;
        this.reservationService = reservationService;
        this.roomService = roomService;
    }

    @Transactional
    @PostMapping("/book")
    public String bookRoom(@AuthenticationPrincipal User user, @RequestParam("id") long roomId, Reservation reservation) {
        Optional<Room> roomOptional = roomService.findRoomById(roomId);
        // todo: handle if isn't present
        if (!roomOptional.isPresent()) {
            return "redirect:/error";
        }

        Room room = roomOptional.get();
        room.setStatus(RoomStatus.BOOKED);

        Bill bill = new Bill(reservation.getCheckInDate(), reservation.getCheckOutDate(), room.getPrice());
        billService.saveBill(bill);

        reservation.setOwner(user);
        reservation.setRoom(room);

        reservation.setStatus(ReservationStatus.BOOKED);
        reservation.calcTotalPrice();
        reservationService.saveReservation(reservation);
        return "redirect:/reservations";
    }
}
