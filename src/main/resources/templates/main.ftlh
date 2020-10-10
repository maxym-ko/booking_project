<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page "Main">
    <#if role == "ADMIN">
        <a class="btn btn-primary mb-3" data-toggle="collapse" href="#collapseId" role="button" aria-expanded="false"
           aria-controls="collapseExample">
            Add new room
        </a>
        <div class="collapse" id="collapseId">
            <div class="form-group">
                <form method="post" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-group col-md">
                            <input class="form-control" type="text" name="capacity" placeholder="capacity">
                        </div>
                        <div class="form-group col-md">
                            <input class="form-control" type="text" name="price" placeholder="price">
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
                    <div class="form-group">
                        <div class="custom-file">
                            <input type="file" name="file" id="customFile">
                            <label class="custom-file-label" for="customFile">Choose room image</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary" type="submit">Add</button>
                    </div>
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                </form>
            </div>
        </div>
        <hr class="mt-2 mb-3"/>
    </#if>

    <div class="card-columns">
        <#list rooms as room>
            <#if room.status == "VACANT">
                <div class="card border-dark bg-light mb-3">
                    <#if room.imgName??>
                        <img class="card-img-top" src="/img/${room.imgName}">
                    </#if>
                    <div class="card-body">
                        <p class="card-text">Capacity: ${room.capacity}</p>
                        <p class="card-text">Type: <i>${room.type}</i></p>
                        <p class="card-text">Price: <strong>${room.price}$</strong> (per night)</p>

                        <#if role == "USER">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-primary" data-toggle="modal"
                                    data-target="#bookModal">
                                Book now
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="bookModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog">
                                    <form action="/book" method="post">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Select check-in and
                                                    check-out date</h5>
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="form-group row">
                                                    <label for="check-in" class="col-4 col-form-label">Check-in</label>
                                                    <div class="col-8">
                                                        <input class="form-control" name="checkInDate" type="date"
                                                               id="check-in">
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label for="check-out"
                                                           class="col-4 col-form-label">Check-out</label>
                                                    <div class="col-8">
                                                        <input class="form-control" name="checkOutDate" type="date"
                                                               id="check-out">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                    Close
                                                </button>
                                                <button type="submit" class="btn btn-primary">Book</button>
                                            </div>
                                        </div>
                                        <input type="hidden" name="id" value="${room.id}">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    </form>
                                </div>
                            </div>
                        </#if>
                        <#if role == "ADMIN">
                            <a href="#" class="btn btn-primary">Change</a>
                            <a href="#" class="btn btn-primary">Remove</a>
                        </#if>
                    </div>
                </div>
            </#if>
        <#else>
            No rooms available
        </#list>
    </div>
</@c.page>