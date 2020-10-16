package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.ApplicationStatus;
import com.maxym.booking.domain.user.User;
import com.maxym.booking.service.ApplicationService;
import com.maxym.booking.service.UserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.beans.Transient;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@PreAuthorize("hasAuthority('USER')")
public class ReservationController {
    private final ApplicationService applicationService;
    private final UserService userService;

    public ReservationController(ApplicationService applicationService, UserService userService) {
        this.applicationService = applicationService;
        this.userService = userService;
    }

    @GetMapping("/reservations")
    public String showReservations(@AuthenticationPrincipal User user, Model model) {
        Optional<User> userOptional = userService.findUserById(user.getId());
        if (!userOptional.isPresent()) {
            return "/error";
        }

        user = userOptional.get();
        List<Application> reservations = user.getApplications()
                .stream()
                .filter(application -> application.getStatus() == ApplicationStatus.PAYMENT_WAITING ||
                                application.getStatus() == ApplicationStatus.BOOKED)
                .collect(Collectors.toList());
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
