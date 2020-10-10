package com.maxym.booking.service;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.repos.ApplicationRepo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ApplicationService {
    private final ApplicationRepo applicationRepo;

    public ApplicationService(ApplicationRepo applicationRepo) {
        this.applicationRepo = applicationRepo;
    }

    public void saveApplicant(Application application) {
        applicationRepo.save(application);
    }

    public List<Application> findAllApplications() {
        return applicationRepo.findAll();
    }

    public Optional<Application> findApplicationById(long id) {
        return applicationRepo.findById(id);
    }

    public void deleteApplicationByIdIfExists(long id) {
        Optional<Application> optionalApplication = applicationRepo.findById(id);

        optionalApplication.ifPresent(application -> applicationRepo.deleteById(id));
    }
}
