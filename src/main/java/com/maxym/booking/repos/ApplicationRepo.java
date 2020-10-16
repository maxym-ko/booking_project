package com.maxym.booking.repos;

import com.maxym.booking.domain.application.Application;
import com.maxym.booking.domain.application.ApplicationStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ApplicationRepo extends JpaRepository<Application, Long> {
    List<Application> findAllByStatusOrStatus(ApplicationStatus status, ApplicationStatus status2);
}
