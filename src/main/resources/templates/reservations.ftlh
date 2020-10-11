<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page "Main">
    <div class="container">
        <table class="table">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th style="width: 20%" scope="col">Room photo</th>
                <th scope="col">Capacity</th>
                <th scope="col">Type</th>
                <th scope="col">Check-in</th>
                <th scope="col">Check-out</th>
                <th scope="col">Status</th>
                <th scope="col">Price</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>

            <#list reservations as reservation>
                <tr>
                    <th scope="row">${reservation?counter}</th>
                    <td><img class="img-thumbnail" src="/img/${reservation.room.imgName}"></td>
                    <td>${reservation.room.capacity}</td>
                    <td>${reservation.room.type}</td>
                    <td>${reservation.checkInDate}</td>
                    <td>${reservation.checkOutDate}</td>
                    <td>${reservation.status}</td>
                    <td>${reservation.totalPrice}$</td>
                    <td>
                        <form action="/payment-confirm" method="post">
                            <#--                            <#include "parts/confirmPayment.ftlh">-->
                            <#assign paymentWaiting = (reservation.status == "PAYMENT_WAITING")>
                            <#if paymentWaiting>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="receiptId">Receipt ID: </label>
                                        <input class="form-control" name="receiptId" type="text"
                                               id="receiptId">
                                    </div>
                                </div>
                            </#if>
                            <button <#if !paymentWaiting >disabled</#if> type="submit"
                                    class="btn btn-success">
                                <#if paymentWaiting >
                                    Confirm payment
                                <#else>
                                    Payment confirmed
                                </#if>
                            </button>
                            <input type="hidden" name="reservationId" value="${reservation.id}">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                        </form>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
</@c.page>