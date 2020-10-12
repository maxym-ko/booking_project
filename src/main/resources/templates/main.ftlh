<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>
<#import "parts/pager.ftlh" as p>
<#import "/spring.ftl" as spring>

<@c.page "Main">
    <#if role == "ADMIN">
        <#include "parts/room/addRoom.ftlh"/>
        <hr class="mt-2 mb-3"/>
    </#if>

    <@p.pager -1 url page>
        <div class="card-columns">
            <#list page.content as room>
            <#--            todo: create condition-->
                <#if room.status != "UNAVAILABLE">
                    <div class="card border-dark bg-light mb-3">
                        <#if room.imgName??>
                            <img class="card-img-top" src="/img/${room.imgName}">
                        </#if>

                        <div class="card-body">
                            <#if role != "ADMIN">
                                <p class="card-text"><@spring.message "room.capacity"/>: ${room.capacity}</p>
                                <p class="card-text"><@spring.message "room.type"/>: <i>${room.type}</i></p>
                                <p class="card-text"><@spring.message "room.price"/>: <strong>${room.price}$</strong> <@spring.message "room.price.per_night"/></p>
                            </#if>

                            <#if role == "USER">
                                <#include "parts/room/bookRoom.ftlh">
                            </#if>

                            <#if role == "ADMIN">

                                <form action="/room-change" method="post">
                                    <input type="hidden" name="id" value="${room.id}">
                                    <div class="form-group row">
                                        <label for="capacity" class="col-sm-6 col-form-label"><@spring.message "room.capacity"/>: </label>
                                        <div class="col-sm-6">
                                            <input class="form-control" id="capacity" type="number" min="1"
                                                   name="capacity"
                                                   value="${room.capacity}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="type" class="col-sm-6 col-form-label"><@spring.message "room.type"/>: </label>
                                        <div class="col-sm-6">
                                            <select class="custom-select" id="type" name="type">
                                                <option <#if room.type == "ECONOMY"> selected </#if> value="ECONOMY">
                                                    <@spring.message "room.type.economy"/>
                                                </option>
                                                <option <#if room.type == "STANDARD"> selected </#if> value="STANDARD">
                                                    <@spring.message "room.type.standard"/>
                                                </option>
                                                <option <#if room.type == "LUXURY"> selected </#if> value="LUXURY">
                                                    <@spring.message "room.type.luxury"/>
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="price" class="col-sm-6 col-form-label"><@spring.message "room.price"/> ($ <@spring.message "room.price.per_night"/>): </label>
                                        <div class="col-sm-6">
                                            <input class="form-control" id="price" type="number" min="0" name="price"
                                                   value="${room.price}">
                                        </div>
                                    </div>
                                    <div class="form-row ml-1">
                                        <div class="form-group mr-2">
                                            <form action="/room-change" method="post">
                                                <button class="btn btn-secondary" type="submit"><@spring.message "room.change"/></button>
                                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                            </form>
                                        </div>
                                    </div>
                                </form>

                                <div class="form-row ml-1">
                                    <div class="form-group mr-2">
                                        <form action="/room-remove" method="post">
                                            <button class="btn btn-danger" type="submit"><@spring.message "room.remove"/></button>
                                            <input type="hidden" name="id" value="${room.id}">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        </form>
                                    </div>
                                </div>
                            </#if>
                        </div>

                    </div>
                </#if>
            <#else>
                <@spring.message "room.not_available"/>
            </#list>
        </div>
    </@p.pager>
</@c.page>