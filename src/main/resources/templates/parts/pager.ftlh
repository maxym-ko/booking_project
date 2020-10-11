<#macro pager id url page>
    <div class="container mr-3">
        <div class="row">
            <ul class="pagination">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">Sort by...</a>
                </li>
                <li class="page-item active">
                    <a class="page-link" href="${url}?<#if id != -1>id=${id}&</#if>page=0&sort=capacity" tabindex="-1">capacity</a>
                </li>
                <li class="page-item active">
                    <a class="page-link" href="${url}?<#if id != -1>id=${id}&</#if>page=0&sort=price" tabindex="-1">price</a>
                </li>
                <li class="page-item active">
                    <a class="page-link" href="${url}?<#if id != -1>id=${id}&</#if>page=0&sort=type" tabindex="-1">type</a>
                </li>
            </ul>
        </div>
    </div>
    <#nested>
    <div class="container mr-3">
        <div class="row">
            <ul class="pagination">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">Pages</a>
                </li>
                <#list 1..page.getTotalPages() as p>
                    <#if (p - 1) == page.getNumber()>
                        <li class="page-item active">
                            <a class="page-link" href="#" tabindex="-1">${p}</a>
                        </li>
                    <#else>
                        <li class="page-item">
                            <a class="page-link"
                               href="${url}?<#if id != -1>id=${id}&</#if>page=${p - 1}&sort=${page.getSort()?substring(0, page.getSort()?index_of(':'))}"
                               tabindex="-1">#{p}</a>
                        </li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>
</#macro>