<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Username: </label>
            <div class="col-sm-5">
                <input class="form-control" type="text" name="username" placeholder="User name"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Password: </label>
            <div class="col-sm-5">
                <input class="form-control" type="password" name="password" placeholder="Password"/>
            </div>
        </div>
        <button class="btn btn-primary mr-2" type="submit">
            <#if isRegisterForm>Create<#else>Sign In</#if>
        </button>
        <#if !isRegisterForm>
            <a href="/registration">Add new user</a>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
    </form>
</#macro>

<#macro logout username>
    <form action="/logout" method="post">
        <input class="btn btn-primary" type="submit" value="Sign Out (${username})"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
    </form>
</#macro>