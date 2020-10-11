package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.ApplicationStatus;
import com.maxym.booking.domain.reservation.Reservation;
import com.maxym.booking.domain.room.RoomType;
import com.maxym.booking.domain.user.User;
import com.maxym.booking.service.ApplicationService;
import com.maxym.booking.service.ReservationService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Controller
@PreAuthorize("hasAuthority('USER')")
public class ApplicationUserController {
    private final ApplicationService applicationService;
    private final ReservationService reservationService;

    public ApplicationUserController(ApplicationService applicationService, ReservationService reservationService) {
        this.applicationService = applicationService;
        this.reservationService = reservationService;
    }

    @GetMapping("/applications")
    public String showApplications(Model model) {
        List<Application> applications = applicationService.findAllApplications();
        model.addAttribute("applications", applications);

        return "applications";
    }

    @PostMapping("/application-create")
    public String createApplicant(@AuthenticationPrincipal User user,
                                  @RequestParam("capacity") int capacity,
                                  @RequestParam("type") String type,
                                  @RequestParam(name = "checkInDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkInDate,
                                  @RequestParam(name = "checkOutDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkOutDate) {
        Application application = new Application();
        application.setOwner(user);
        application.setRequirementCapacity(capacity);
        application.setCheckInDate(checkInDate);
        application.setCheckOutDate(checkOutDate);
        application.setRequirementType(RoomType.valueOf(type));
        application.setStatus(ApplicationStatus.LOOKING_FOR);

        applicationService.saveApplicant(application);

        return "redirect:/applications";
    }

    @PostMapping("/application-accept")
    @Transactional
    public String acceptApplicant(@RequestParam("id") long id) {
        Optional<Application> applicationOptional = applicationService.findApplicationById(id);
        if (!applicationOptional.isPresent()) {
            return "redirect:/error";
        }

        Application application = applicationOptional.get();
        Reservation reservation = new Reservation(application);

        reservationService.saveReservation(reservation);
        application.setStatus(ApplicationStatus.APPROVED);

        return "redirect:/applications";
    }

    @PostMapping("/application-reject")
    @Transactional
    public String rejectApplicant(@RequestParam("id") long id) {
        Optional<Application> applicationOptional = applicationService.findApplicationById(id);
        if (!applicationOptional.isPresent()) {
            return "/error";
        }

        Application application = applicationOptional.get();
        application.setRoom(null);
        application.setStatus(ApplicationStatus.LOOKING_FOR);

        applicationService.saveApplicant(application);

        return "redirect:/applications";
    }

    @PostMapping("/application-remove")
    public String removeApplicant(@RequestParam("id") long id) {
        applicationService.deleteApplicationById(id);

        return "redirect:/applications";
    }
}
