package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.Bill;
import com.maxym.booking.domain.room.Room;
import com.maxym.booking.domain.room.RoomStatus;
import com.maxym.booking.domain.user.User;
import com.maxym.booking.service.ApplicationService;
import com.maxym.booking.service.BillService;
import com.maxym.booking.service.RoomService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.transaction.Transactional;
import java.util.Optional;

@Controller
@PreAuthorize("hasAuthority('USER')")
public class RoomController {
    private final BillService billService;
    private final ApplicationService applicationService;
    private final RoomService roomService;

    public RoomController(BillService billService, ApplicationService applicationService, RoomService roomService) {
        this.billService = billService;
        this.applicationService = applicationService;
        this.roomService = roomService;
    }

    @Transactional
    @PostMapping("/book")
    public String bookRoom(@AuthenticationPrincipal User user, @RequestParam("id") long roomId, Application application) {
        Optional<Room> roomOptional = roomService.findRoomById(roomId);
        // todo: handle if isn't present
        if (!roomOptional.isPresent()) {
            return "/error";
        }

        Room room = roomOptional.get();
        room.setStatus(RoomStatus.BOOKED);

        Bill bill = new Bill(application.getCheckInDate(), application.getCheckOutDate(), room.getPrice());
        billService.saveBill(bill);

        application.setBill(bill);
        application.setOwner(user);
        application.setRoom(room);
        applicationService.saveApplicant(application);

        return "redirect:/applications";
    }
}
