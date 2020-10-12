<#import "parts/common.ftlh" as c>
<#import "/spring.ftl" as spring />

<@c.page "About project">

    <h2><@spring.message "about.hotel"/></h2>

    <div class="container">
        <p class="text-left"><@spring.message "about.info"/></p>
    </div>

</@c.page>