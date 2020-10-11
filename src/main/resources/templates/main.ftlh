<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page "Main">
    <#if role == "ADMIN">
        <#include "parts/room/addRoom.ftlh"/>
        <hr class="mt-2 mb-3"/>
    </#if>

    <div class="card-columns">
        <#list rooms as room>
        <#--            todo: create condition-->
            <#if room.status != "UNAVAILABLE">
                <div class="card border-dark bg-light mb-3">
                    <#if room.imgName??>
                        <img class="card-img-top" src="/img/${room.imgName}">
                    </#if>

                    <div class="card-body">
                        <#if role != "ADMIN">
                            <p class="card-text">Capacity: ${room.capacity}</p>
                            <p class="card-text">Type: <i>${room.type}</i></p>
                            <p class="card-text">Price: <strong>${room.price}$</strong> (per night)</p>
                        </#if>

                        <#if role == "USER">
                            <#include "parts/room/bookRoom.ftlh">
                        </#if>

                        <#if role == "ADMIN">

                            <form action="/room-change" method="post">
                                <input type="hidden" name="id" value="${room.id}">
                                <div class="form-group row">
                                    <label for="capacity" class="col-sm-6 col-form-label">Capacity: </label>
                                    <div class="col-sm-6">
                                        <input class="form-control" id="capacity" type="number" min="1" name="capacity"
                                               value="${room.capacity}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="type" class="col-sm-6 col-form-label">Type: </label>
                                    <div class="col-sm-6">
                                        <select class="custom-select" id="type" name="type">
                                            <option <#if room.type == "ECONOMY"> selected </#if> value="ECONOMY">ECONOMY
                                            </option>
                                            <option <#if room.type == "STANDARD"> selected </#if> value="STANDARD">
                                                STANDARD
                                            </option>
                                            <option <#if room.type == "LUXURY"> selected </#if> value="LUXURY">LUXURY
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="price" class="col-sm-6 col-form-label">Price ($ per night): </label>
                                    <div class="col-sm-6">
                                        <input class="form-control" id="price" type="number" min="0" name="price"
                                               value="${room.price}">
                                    </div>
                                </div>
                                <div class="form-row ml-1">
                                    <div class="form-group mr-2">
                                        <form action="/room-change" method="post">
                                            <button class="btn btn-secondary" type="submit">Change</button>
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        </form>
                                    </div>
                                </div>
                            </form>

                            <div class="form-row ml-1">
                                <div class="form-group mr-2">
                                    <form action="/room-remove" method="post">
                                        <button class="btn btn-danger" type="submit">Remove</button>
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
            No rooms available
        </#list>
    </div>
</@c.page>