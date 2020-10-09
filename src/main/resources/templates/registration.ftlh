<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page "Login page">
    Add new user
    ${message!}
    <@l.login "/registration" />
</@c.page>