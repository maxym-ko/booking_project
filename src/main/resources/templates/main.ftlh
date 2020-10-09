<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page "Main">
    <div>
        <a href="/login">Login</a>
        <@l.logout />
    </div>

    <h3>Rooms: </h3>
    <#list rooms as room>
        <#if room.status == "VACANT">
            <div>
                <b>${room.id}</b>
                <span>${room.capacity}</span>
                <span>${room.status}</span>
                <span>${room.type}</span>
                <i>${room.checkInDate}</i>
                <i>${room.checkOutDate}</i>
                <strong>${room.price}</strong>
            </div>
        </#if>
    <#else>
        No rooms available
    </#list>
</@c.page>