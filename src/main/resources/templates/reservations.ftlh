<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>
<#import "/spring.ftl" as spring>

<@c.page "Main">
    <div class="container">
        <table class="table">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th style="width: 20%" scope="col"><@spring.message "applications.image"/></th>
                <th scope="col"><@spring.message "applications.capacity"/></th>
                <th scope="col"><@spring.message "applications.type"/></th>
                <th scope="col"><@spring.message "applications.check_in"/></th>
                <th scope="col"><@spring.message "applications.check_out"/></th>
                <th scope="col"><@spring.message "applications.status"/></th>
                <th scope="col"><@spring.message "applications.status"/></th>
                <th scope="col"><@spring.message "applications.action"/></th>
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
                                        <label for="receiptId"><@spring.message "reservations.action.payment.receipt_id"/>: </label>
                                        <input class="form-control" name="receiptId" type="text"
                                               id="receiptId">
                                    </div>
                                </div>
                            </#if>
                            <button <#if !paymentWaiting >disabled</#if> type="submit"
                                    class="btn btn-success">
                                <#if paymentWaiting >
                                    <@spring.message "reservations.action.payment.confirm"/>
                                <#else>
                                    <@spring.message "reservations.action.payment.confirmed"/>
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