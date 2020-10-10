package com.maxym.booking.controller;

import com.maxym.booking.domain.reservation.Reservation;
import com.maxym.booking.service.ReservationService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/reservations")
@PreAuthorize("hasAuthority('USER')")
public class ReservationController {
    private final ReservationService reservationService;

    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @GetMapping
    public String showReservations(Model model) {
        List<Reservation> reservations = reservationService.findAllReservations();
        model.addAttribute("reservations", reservations);

        return "reservations";
    }
}
