package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.ApplicationStatus;
import com.maxym.booking.service.ApplicationService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import sun.applet.AppletListener;

import java.beans.Transient;
import java.util.List;
import java.util.Optional;

@Controller
@PreAuthorize("hasAuthority('USER')")
public class ReservationController {
    private final ApplicationService applicationService;

    public ReservationController(ApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    @GetMapping("/reservations")
    public String showReservations(Model model) {
        List<Application> reservations = applicationService.findAllReservations();
        model.addAttribute("reservations", reservations);

        return "reservations";
    }

    @PostMapping("/payment-confirm")
    @Transient
    public String confirmPayment(@RequestParam("reservationId") long reservationId,
                                 @RequestParam("receiptId") String receiptId) {
        Optional<Application> reservationOptional = applicationService.findApplicationById(reservationId);
        if (!reservationOptional.isPresent()) {
            return "redirect:/error";
        }

        Application application = reservationOptional.get();
        application.getBill().setReceiptId(receiptId);
        application.setStatus(ApplicationStatus.BOOKED);

        applicationService.saveApplication(application);

        return "redirect:/reservations";
    }
}
