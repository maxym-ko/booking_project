package com.maxym.booking.repos;

import com.maxym.booking.domain.application.Application;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ApplicationRepo extends JpaRepository<Application, Long> {

}
