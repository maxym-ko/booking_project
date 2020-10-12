<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>
<#import "parts/pager.ftlh" as p>
<#import "/spring.ftl" as spring>

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
                        <p class="card-text"><@spring.message "room.capacity"/>: ${room.capacity}</p>
                        <p class="card-text"><@spring.message "room.type.luxury"/>: <i>${room.type}</i></p>
                        <p class="card-text"><@spring.message "room.price"/>: <strong>${room.price}$</strong> (<@spring.message "room.price.per_night"/>)</p>

                        <form action="/room-select" method="post">
                            <button class="btn btn-primary" type="submit"><@spring.message "room.add.select"/></button>
                            <input type="hidden" name="roomId" value="${room.id}">
                            <input type="hidden" name="applicationId" value="${applicationId}">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                        </form>

                    </div>
                </#if>
                </div>
            <#else>
                <@spring.message "room.not_available"/>
            </#list>
        </div>
    </@p.pager>
</@c.page>