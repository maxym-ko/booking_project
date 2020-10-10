package com.maxym.booking.service;

import com.maxym.booking.domain.reservation.Reservation;
import com.maxym.booking.repos.ReservationRepo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReservationService {
    private final ReservationRepo reservationRepo;

    public ReservationService(ReservationRepo reservationRepo) {
        this.reservationRepo = reservationRepo;
    }

    public void saveReservation(Reservation reservation) {
        reservationRepo.save(reservation);
    }

    public List<Reservation> findAllReservations() {
        return reservationRepo.findAll();
    }

    public Optional<Reservation> findReservationById(long id) {
        return reservationRepo.findById(id);
    }

    public void deleteReservationByIdIfExists(long id) {
        Optional<Reservation> optionalReservation = reservationRepo.findById(id);

        optionalReservation.ifPresent(application -> reservationRepo.deleteById(id));
    }
}
