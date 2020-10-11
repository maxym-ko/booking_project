package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.reservation.Reservation;
import com.maxym.booking.domain.reservation.ReservationStatus;
import com.maxym.booking.service.ReservationService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.beans.Transient;
import java.util.List;
import java.util.Optional;

@Controller
@PreAuthorize("hasAuthority('USER')")
public class ReservationController {
    private final ReservationService reservationService;

    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }


    @GetMapping("/reservations")
    public String showReservations(Model model) {
        List<Reservation> reservations = reservationService.findAllReservations();
        model.addAttribute("reservations", reservations);

        return "reservations";
    }

    @PostMapping("/payment-confirm")
    @Transient
    public String confirmPayment(@RequestParam("reservationId") long reservationId,
                                 @RequestParam("receiptId") String receiptId) {
        Optional<Reservation> reservationOptional = reservationService.findReservationById(reservationId);
        if (!reservationOptional.isPresent()) {
            return "redirect:/error";
        }

        Reservation reservation = reservationOptional.get();
        reservation.getApplication().getBill().setReceiptId(receiptId);
        reservation.setStatus(ReservationStatus.BOOKED);

        reservationService.saveReservation(reservation);

        return "redirect:/reservations";
    }
}
