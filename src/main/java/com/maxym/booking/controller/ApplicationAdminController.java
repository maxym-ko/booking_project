package com.maxym.booking.controller;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.ApplicationStatus;
import com.maxym.booking.domain.application.Bill;
import com.maxym.booking.domain.room.Room;
import com.maxym.booking.service.ApplicationService;
import com.maxym.booking.service.RoomService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Controller
@PreAuthorize("hasAuthority('ADMIN')")
public class ApplicationAdminController {
    private final ApplicationService applicationService;
    private final RoomService roomService;

    public ApplicationAdminController(ApplicationService applicationService, RoomService roomService) {
        this.applicationService = applicationService;
        this.roomService = roomService;
    }


    @PostMapping("/application-remove-admin")
    public String removeApplicantAdmin(@RequestParam("id") long id) {
        applicationService.deleteApplicationByIdIfExists(id);

        return "redirect:/applications-admin";
    }

    @GetMapping("/applications-admin")
    public String showsApplicationsAdmin(Model model) {
        List<Application> applications = applicationService.findAllApplications();
        model.addAttribute("applications", applications);
        return "applications_admin";
    }

    @GetMapping("/room-find")
    public String showRooms2Select(@RequestParam("id") long applicationId, Model model,
                                   @RequestParam(name = "sort", defaultValue = "id") String sort,
                                   @RequestParam(name = "page", defaultValue = "0") int pageNo) {
        Page<Room> page = roomService.findAllRooms(PageRequest.of(pageNo, 6, Sort.by(sort)));
        model.addAttribute("id", applicationId);
        model.addAttribute("page", page);
        model.addAttribute("url", "/room-find");
        model.addAttribute("applicationId", applicationId);

        return "findRoom";
    }

    @PostMapping("/room-select")
    @Transactional
    public String saveRoom2Application(@RequestParam("roomId") @NumberFormat(style = NumberFormat.Style.DEFAULT) Long roomId,
                                       @RequestParam("applicationId") long applicationId) {
        Optional<Application> applicationOptional = applicationService.findApplicationById(applicationId);
        Optional<Room> roomOptional = roomService.findRoomById(roomId);

        if (!applicationOptional.isPresent() || !roomOptional.isPresent()) {
            return "redirect:/error";
        }

        Application application = applicationOptional.get();
        Room room = roomOptional.get();

        Bill bill = new Bill(application.getCheckInDate(), application.getCheckOutDate(), room.getPrice());
        application.setBill(bill);
        application.setRoom(room);
        application.setStatus(ApplicationStatus.ACCEPT_WAITING);
        application.calcTotalPrice();

        applicationService.saveApplication(application);

        return "redirect:/applications-admin";
    }
}
