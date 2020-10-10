package com.maxym.booking.controller;

import com.maxym.booking.domain.room.Room;
import com.maxym.booking.domain.room.RoomStatus;
import com.maxym.booking.service.RoomService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/")
public class MainController {
    @Value("${upload.path}")
    private String uploadPath;

    private final RoomService roomService;

    public MainController(RoomService roomService) {
        this.roomService = roomService;
    }

    @GetMapping
    public String showRooms(Model model) {
        List<Room> rooms = roomService.findAllRooms();
        model.addAttribute("rooms", rooms);
        return "main";
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public String addRoom(Room room, Map<String, Object> model,
                          @RequestParam("file") MultipartFile file) throws IOException {
        room.setStatus(RoomStatus.VACANT);
        saveImgToRoom(file, room);

        roomService.saveRoom(room);

        List<Room> messages = roomService.findAllRooms();

        model.put("rooms", messages);
        return "main";
    }

    private void saveImgToRoom(MultipartFile file, Room room) throws IOException {
        if (file != null && !file.isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String imgResultName = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + imgResultName));

            room.setImgName(imgResultName);
        }
    }
}
