<#include "security.ftlh">
<#import "login.ftlh" as l>
<#import "/spring.ftl" as spring />

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <#--    <a class="navbar-brand" href="/">Booking Project</a>-->
    <div class="navbar-brand"><@spring.message "nav.project_name"/></div>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/"><@spring.message "nav.home"/></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/about"><@spring.message "nav.about"/></a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="languageChanger" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <@spring.message "footer.language"/>
                </a>
                <div class="dropdown-menu" aria-labelledby="languageChanger">
                    <a class="dropdown-item" href="<@spring.message "main.url"/>${springMacroRequestContext.requestUri}?lang=uk">Українська </a>
                    <a class="dropdown-item" href="<@spring.message "main.url"/>${springMacroRequestContext.requestUri}?lang=en">English </a>
                </div>
            </li>
        </ul>

        <#if role == "ADMIN">
            <a class="nav-link" href="/applications-admin"><@spring.message "nav.users_applications"/></a>
        </#if>
        <#if role == "USER">
            <a class="nav-link" href="/applications"><@spring.message "nav.my_applications"/></a>
            <a class="nav-link" href="/reservations"><@spring.message "nav.my_reservations"/></a>
        </#if>
<#--        <div class="navbar-text mr-3">${name}</div>-->
        <#if name != "unknown">
            <@l.logout name/>
        <#else>
            <a href="/login" class="btn btn-primary" role="button" aria-pressed="true"><@spring.message "nav.login"/></a>
        </#if>
    </div>
</nav>