package com.maxym.booking.service;

import com.maxym.booking.domain.application.Bill;
import com.maxym.booking.domain.reservation.Reservation;
import com.maxym.booking.repos.BillRepo;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class BillService {
    private final BillRepo billRepo;

    public BillService(BillRepo billRepo) {
        this.billRepo = billRepo;
    }

    public Optional<Bill> findBillById(long id) {
        return billRepo.findById(id);
    }

    public void saveBill(Bill bill) {
        billRepo.save(bill);
    }
}
