<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>
<#import "parts/pager.ftlh" as p>

<@c.page "Main">
    <@p.pager id url page>
        <div class="card-columns">
            <#list page.getContent() as room>
            <#--            todo: create condition-->
                <#if room.status != "UNAVAILABLE">
                    <div class="card border-dark bg-light mb-3">
                    <#if room.imgName??>
                        <img class="card-img-top" src="/img/${room.imgName}">
                    </#if>

                    <div class="card-body">
                        <p class="card-text">Capacity: ${room.capacity}</p>
                        <p class="card-text">Type: <i>${room.type}</i></p>
                        <p class="card-text">Price: <strong>${room.price}$</strong> (per night)</p>

                        <form action="/room-select" method="post">
                            <button class="btn btn-primary" type="submit">Select</button>
                            <input type="hidden" name="roomId" value="${room.id}">
                            <input type="hidden" name="applicationId" value="${applicationId}">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                        </form>

                    </div>
                </#if>
                </div>
            <#else>
                No rooms available
            </#list>
        </div>
    </@p.pager>
</@c.page>