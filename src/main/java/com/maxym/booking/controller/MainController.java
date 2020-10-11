package com.maxym.booking.controller;

import com.maxym.booking.domain.room.Room;
import com.maxym.booking.domain.room.RoomStatus;
import com.maxym.booking.service.RoomService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
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
    public String showRooms(Model model,
                            @RequestParam(name = "sort", defaultValue = "id") String sort,
                            @RequestParam(name = "page", defaultValue = "0") int pageNo) {
        Page<Room> page = roomService.findAllRooms(PageRequest.of(pageNo, 6, Sort.by(sort)));
        model.addAttribute("page", page);
        model.addAttribute("url", "");
        return "main";
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public String addRoom(Room room, Map<String, Object> model,
                          @RequestParam("file") MultipartFile file,
                          @RequestParam(name = "sort", defaultValue = "id") String sort,
                          @RequestParam(name = "page", defaultValue = "0") int pageNo) throws IOException {
        room.setStatus(RoomStatus.VACANT);
        saveImgToRoom(file, room);

        roomService.saveRoom(room);

        Page<Room> page = roomService.findAllRooms(PageRequest.of(pageNo, 6, Sort.by(sort)));

        model.put("page", page);
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
