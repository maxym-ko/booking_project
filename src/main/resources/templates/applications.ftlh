<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>
<#import "/spring.ftl" as spring />

<@c.page "Main">
    <div class="container">
        <a class="btn btn-primary mb-3" data-toggle="collapse" href="#newApplicationsId" role="button"
           aria-expanded="false"
           aria-controls="collapseExample">
            <@spring.message "applications.create"/>
        </a>
        <div class="collapse" id="newApplicationsId">
            <div class="form-group">
                <form action="/application-create" method="post" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-group col-md">
                            <input class="form-control" type="number" min="0" name="capacity" placeholder="<@spring.message "room.add.capacity"/>">
                        </div>
                        <div class="form-group col-md">
                            <select class="custom-select" name="type" class="form-control">
                                <option disabled selected><@spring.message "applications.type_select"/></option>
                                <option value="ECONOMY"><@spring.message "room.type.economy"/></option>
                                <option value="STANDARD"><@spring.message "room.type.standard"/></option>
                                <option value="LUXURY"><@spring.message "room.type.luxury"/></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="check-in"><@spring.message "applications.check_in"/></label>
                            <input class="form-control" name="checkInDate" type="date"
                                   id="check-in">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="check-out"><@spring.message "applications.check_out"/></label>
                            <input class="form-control" name="checkOutDate" type="date"
                                   id="check-out">
                        </div>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-success" type="submit"><@spring.message "applications.action.create"/></button>
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
                <th style="width: 20%" scope="col"><@spring.message "applications.image"/></th>
                <th scope="col"><@spring.message "applications.required_capacity"/></th>
                <th scope="col"><@spring.message "applications.required_type"/></th>
                <th scope="col"><@spring.message "applications.check_in"/></th>
                <th scope="col"><@spring.message "applications.check_out"/></th>
                <th scope="col"><@spring.message "applications.status"/></th>
                <th scope="col"><@spring.message "applications.price"/></th>
                <th scope="col"><@spring.message "applications.action"/></th>
            </tr>
            </thead>
            <tbody>

            <#list applications as application>
                <tr>
                    <#if application.status != "APPROVED">

                        <#if application.room??>
                            <th scope="row">${application?counter}</th>
                            <td><img class="img-thumbnail" src="/img/${application.room.imgName}"></td>
                            <td>${application.room.capacity}</td>
                            <td>${application.room.type}</td>
                            <td>${application.checkInDate}</td>
                            <td>${application.checkOutDate}</td>
                            <td>${application.status}</td>
                            <td>${application.totalPrice}$</td>
                        <#else>
                            <th scope="row">${application?counter}</th>
                            <td><@spring.message "applications.image_waiting"/></td>
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
                                            <button type="submit" class="btn btn-success"><@spring.message "applications.action.accept"/></button>
                                            <input type="hidden" name="id" value="${application.id}">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        </form>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <form action="/application-reject" method="post">
                                            <button type="submit" class="btn btn-warning"><@spring.message "applications.action.reject"/></button>
                                            <input type="hidden" name="id" value="${application.id}">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        </form>
                                    </div>
                                </div>
                            </#if>
                            <form action="/application-remove" method="post">
                                <button type="submit" class="btn btn-danger"><@spring.message "applications.action.remove"/></button>
                                <input type="hidden" name="id" value="${application.id}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                            </form>
                        </td>

                    </#if>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
</@c.page>