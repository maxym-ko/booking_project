package com.maxym.booking.service;

import com.maxym.booking.domain.application.Bill;
import com.maxym.booking.repos.BillRepo;
import org.springframework.stereotype.Service;

@Service
public class BillService {
    private final BillRepo billRepo;

    public BillService(BillRepo billRepo) {
        this.billRepo = billRepo;
    }

    public void saveBill(Bill bill) {
        billRepo.save(bill);
    }
}
