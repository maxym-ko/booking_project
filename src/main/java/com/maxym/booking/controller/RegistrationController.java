package com.maxym.booking.controller;

import com.maxym.booking.domain.user.Role;
import com.maxym.booking.domain.user.User;
import com.maxym.booking.repos.UserRepo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
    private final UserRepo userRepo;

    public RegistrationController(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @GetMapping
    public String registration() {
        return  "registration";
    }

    @PostMapping
    public String addUser(User user, Map<String, Object> model) {
        User userFromDb = userRepo.findByUsername(user.getUsername());
        if (userFromDb != null) {
            model.put("message", "User exists!");
            return "registration";
        }

//        user.setRole(Role.USER);
        userRepo.save(user);

        return "redirect:/login";
    }
}
