package com.maxym.booking.service;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.repos.ApplicationRepo;
import org.springframework.stereotype.Service;

@Service
public class ApplicationService {
    private final ApplicationRepo applicationRepo;

    public ApplicationService(ApplicationRepo applicationRepo) {
        this.applicationRepo = applicationRepo;
    }

    public void saveApplicant(Application application) {
        applicationRepo.save(application);
    }
}
