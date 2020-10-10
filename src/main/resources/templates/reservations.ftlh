<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page "Main">
    <div class="container">
        <table class="table">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Room photo</th>
                <th scope="col">Capacity</th>
                <th scope="col">Type</th>
                <th scope="col">Check-in</th>
                <th scope="col">Check-out</th>
                <th scope="col">Status</th>
                <th scope="col">Price</th>
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
                    <td>${reservation.totalPrice}</td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
</@c.page>