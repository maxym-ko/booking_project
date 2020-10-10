<#include "security.ftlh">
<#import "login.ftlh" as l>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <#--    <a class="navbar-brand" href="/">Booking Project</a>-->
    <div class="navbar-brand">Booking Project</div>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/about">About</a>
            </li>
        </ul>

        <#if role == "ADMIN">
            <a class="nav-link" href="/applications-admin">User's applications</a>
        </#if>
        <#if role == "USER">
            <a class="nav-link" href="/applications">My applications</a>
            <a class="nav-link" href="/reservations">My reservations</a>
        </#if>
<#--        <div class="navbar-text mr-3">${name}</div>-->
        <#if name != "unknown">
            <@l.logout name/>
        <#else>
            <a href="/login" class="btn btn-primary" role="button" aria-pressed="true">Login</a>
        </#if>
    </div>
</nav>