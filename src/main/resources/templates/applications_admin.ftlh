<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page "Main">
    <div class="container">
        <table class="table">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Room photo</th>
                <th scope="col">Required capacity</th>
                <th scope="col">Required type</th>
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
                    <#if application.status != "LOOKING_FOR">
                        <th scope="row">${application?counter}</th>
                        <td><img class="img-thumbnail" src="/img/${application.room.imgName}"></td>
                        <td>${application.requirementCapacity}</td>
                        <td>${application.requirementType}</td>
                        <td>${application.checkInDate}</td>
                        <td>${application.checkOutDate}</td>
                        <td>${application.status}</td>
                        <td><#if application.bill??>${application.bill.totalPrice}$</#if></td>
                    <#else>
                        <th scope="row">${application?counter}</th>
                        <td>Not selected yet</td>
                        <td>${application.requirementCapacity}</td>
                        <td>${application.requirementType}</td>
                        <td>${application.checkInDate}</td>
                        <td>${application.checkOutDate}</td>
                        <td>${application.status}</td>
                        <td><#if application.bill??>${application.bill.totalPrice}$<#else>?</#if></td>
                    </#if>

                    <td>
                        <#if application.status == "LOOKING_FOR" || application.status == "REJECTED">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <form action="/applications-accept" method="post">
                                        <button type="submit" class="btn btn-success">Find</button>
                                        <input type="hidden" name="id" value="${application.owner.id}">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    </form>
                                </div>
                            </div>
                        </#if>
                        <#--                        <div class="form-group col-md-6">-->
<#--                        <form action="/application-remove" method="post">-->
<#--                            <button type="submit" class="btn btn-danger">Remove</button>-->
<#--                            <input type="hidden" name="id" value="${application.id}">-->
<#--                            <input type="hidden" name="_csrf" value="${_csrf.token}">-->
<#--                        </form>-->
                        <#--                        </div>-->
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
</@c.page>