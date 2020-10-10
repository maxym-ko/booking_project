package com.maxym.booking.repos;

import com.maxym.booking.domain.application.Bill;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BillRepo extends JpaRepository<Bill, Long> {
}
