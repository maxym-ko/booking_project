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
                <th scope="col"><@spring.message "applications.required_capacity"/></th>
                <th scope="col"><@spring.message "applications.required_capacity"/></th>
                <th scope="col"><@spring.message "applications.check_in"/></th>
                <th scope="col"><@spring.message "applications.check_out"/></th>
                <th scope="col"><@spring.message "applications.status"/></th>
                <th scope="col"><@spring.message "applications.price"/></th>
                <th scope="col"><@spring.message "applications.action"/></th>
            </tr>
            </thead>
            <tbody>

            <#list applications as application>
                <#if application.status != "APPROVED">
                    <tr>
                        <#if application.status != "LOOKING_FOR">
                            <th scope="row">${application?counter}</th>
                            <td><img class="img-thumbnail" src="/img/${application.room.imgName}"></td>
                            <td>${application.requirementCapacity}</td>
                            <td>${application.requirementType}</td>
                            <td>${application.checkInDate}</td>
                            <td>${application.checkOutDate}</td>
                            <td>${application.status}</td>
                            <td>${application.totalPrice}$</td>
                        <#else>
                            <th scope="row">${application?counter}</th>
                            <td><@spring.message "applications.image_not_selected"/></td>
                            <td>${application.requirementCapacity}</td>
                            <td>${application.requirementType}</td>
                            <td>${application.checkInDate}</td>
                            <td>${application.checkOutDate}</td>
                            <td>${application.status}</td>
                            <td>?</td>
                        </#if>

                        <td>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                        <a href="/room-find?id=${application.id}" type="submit" class="btn btn-success">
                                            <#if application.status == "WAITING">
                                                <@spring.message "applications.action.change"/>
                                            <#else>
                                                <@spring.message "applications.action.find"/>
                                            </#if>
                                        </a>
                                </div>
                                <div class="form-group col-md-6">
                                    <form action="/application-remove-admin" method="post">
                                        <button type="submit" class="btn btn-danger"><@spring.message "applications.action.remove"/></button>
                                        <input type="hidden" name="id" value="${application.id}">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    </form>
                                </div>
                            </div>

                        </td>
                    </tr>
                </#if>
            </#list>
            </tbody>
        </table>
    </div>
</@c.page>