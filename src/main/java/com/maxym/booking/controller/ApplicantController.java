package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.ApplicationStatus;
import com.maxym.booking.domain.room.Room;
import com.maxym.booking.domain.room.RoomType;
import com.maxym.booking.domain.user.User;
import com.maxym.booking.service.ApplicationService;
import com.maxym.booking.service.RoomService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;

@Controller
@PreAuthorize("hasAuthority('USER')")
public class ApplicantController {
    private final ApplicationService applicationService;
    private final RoomService roomService;

    public ApplicantController(ApplicationService applicationService, RoomService roomService) {
        this.applicationService = applicationService;
        this.roomService = roomService;
    }

    @GetMapping("/applications")
    public String showApplicants(Model model) {
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

    @PostMapping("/application-remove")
    public String removeApplicant(@RequestParam("id") long id) {
        applicationService.deleteApplicationByIdIfExists(id);

        return "redirect:/applications";
    }

    @GetMapping("/applications-admin")
    @PreAuthorize("hasAuthority('ADMIN')")
    public String showUsersApplications(Model model) {
        List<Application> applications = applicationService.findAllApplications();
        List<Room> rooms = roomService.findAllRooms();
        model.addAttribute("applications", applications);
        model.addAttribute("rooms", rooms);

        return "applications_admin";
    }
}
