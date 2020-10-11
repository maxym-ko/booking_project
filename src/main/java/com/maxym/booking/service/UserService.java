package com.maxym.booking.service;

import com.maxym.booking.domain.user.User;
import com.maxym.booking.repos.UserRepo;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService implements UserDetailsService {
    private final UserRepo userRepo;

    public UserService(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @Override
    public UserDetails loadUserByUsername(String username) {
        return userRepo.findByUsername(username);
    }

    public Optional<User> findUserById(long id) {
        return userRepo.findById(id);
    }
}
