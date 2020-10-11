package com.maxym.booking.domain.application;

import com.maxym.booking.domain.room.Room;
import com.maxym.booking.domain.room.RoomType;
import com.maxym.booking.domain.user.User;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.Duration;
import java.time.LocalDate;

@Entity
public class Application {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private int requirementCapacity;

    @Enumerated(EnumType.STRING)
    private RoomType requirementType;

    private double totalPrice;

    @Enumerated(EnumType.STRING)
    private ApplicationStatus status;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkInDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOutDate;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Bill bill;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User owner;

    @OneToOne(fetch = FetchType.EAGER)
    private Room room;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getRequirementCapacity() {
        return requirementCapacity;
    }

    public void setRequirementCapacity(int requirementCapacity) {
        this.requirementCapacity = requirementCapacity;
    }

    public RoomType getRequirementType() {
        return requirementType;
    }

    public void setRequirementType(RoomType requirementType) {
        this.requirementType = requirementType;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public ApplicationStatus getStatus() {
        return status;
    }

    public void setStatus(ApplicationStatus status) {
        this.status = status;
    }

    public LocalDate getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDate checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDate getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDate checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public Bill getBill() {
        return bill;
    }

    public void setBill(Bill bill) {
        this.bill = bill;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }


    public void calcTotalPrice() {
        long days = Duration.between(checkInDate.atStartOfDay(), checkOutDate.atStartOfDay()).toDays();
        this.totalPrice = room.getPrice() * days;
    }
}
