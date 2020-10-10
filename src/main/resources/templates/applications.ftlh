<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page "Main">
    <div class="container">
        <a class="btn btn-primary mb-3" data-toggle="collapse" href="#newApplicationsId" role="button"
           aria-expanded="false"
           aria-controls="collapseExample">
            Create new application
        </a>
        <div class="collapse" id="newApplicationsId">
            <div class="form-group">
                <form action="/application-create" method="post" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-group col-md">
                            <input class="form-control" type="text" name="capacity" placeholder="capacity">
                        </div>
                        <div class="form-group col-md">
                            <select class="custom-select" name="type" class="form-control">
                                <option disabled selected>Select room type</option>
                                <option value="ECONOMY">ECONOMY</option>
                                <option value="STANDARD">STANDARD</option>
                                <option value="LUXURY">LUXURY</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="check-in">Check-in</label>
                            <input class="form-control" name="checkInDate" type="date"
                                   id="check-in">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="check-out">Check-out</label>
                            <input class="form-control" name="checkOutDate" type="date"
                                   id="check-out">
                        </div>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-success" type="submit">Create</button>
                    </div>
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                </form>
            </div>
        </div>
    </div>

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

            <#list applications as application>
                <tr>
                    <#if application.room??>
                        <th scope="row">${application?counter}</th>
                        <td><img class="img-thumbnail" src="/img/${application.room.imgName}"></td>
                        <td>${application.room.capacity}</td>
                        <td>${application.room.type}</td>
                        <td>${application.checkInDate}</td>
                        <td>${application.checkOutDate}</td>
                        <td>${application.status}</td>
                        <td><#if application.bill??>${application.bill.totalPrice}$</#if></td>
                    <#else>
                        <th scope="row">${application?counter}</th>
                        <td>Wait for manager to pick you a room</td>
                        <td>${application.requirementCapacity}</td>
                        <td>${application.requirementType}</td>
                        <td>${application.checkInDate}</td>
                        <td>${application.checkOutDate}</td>
                        <td>${application.status}</td>
                        <td><#if application.bill??>${application.bill.totalPrice}$<#else>?</#if></td>
                    </#if>

                    <td>
                        <#if application.status == "WAITING">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <form action="/application-accept" method="post">
                                        <button type="submit" class="btn btn-success">Accept</button>
                                        <input type="hidden" name="id" value="${application.id}">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    </form>
                                </div>
                                <div class="form-group col-md-6">
                                    <form action="/application-decline" method="post">
                                        <button type="submit" class="btn btn-warning">Decline</button>
                                        <input type="hidden" name="id" value="${application.id}">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    </form>
                                </div>
                            </div>
                        </#if>
<#--                        <div class="form-group col-md-6">-->
                            <form action="/application-remove" method="post">
                                <button type="submit" class="btn btn-danger">Remove</button>
                                <input type="hidden" name="id" value="${application.id}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                            </form>
<#--                        </div>-->
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
</@c.page>