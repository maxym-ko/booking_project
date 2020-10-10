package com.maxym.booking.domain.application;

import javax.persistence.*;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "bill")
public class Bill {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private double totalPrice;
    private LocalDateTime created;

    public Bill() {}

    public Bill(LocalDate start, LocalDate end, double price) {
        created = LocalDateTime.now();

        long days = Duration.between(start.atStartOfDay(), end.atStartOfDay()).toDays();

        double totalPrice = price * days;
        this.totalPrice = totalPrice;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getCreated() {
        return created;
    }

    public void setCreated(LocalDateTime created) {
        this.created = created;
    }
}
