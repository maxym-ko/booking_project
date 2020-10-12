<#import "/spring.ftl" as spring />

<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "login.username"/>: </label>
            <div class="col-sm-5">
                <input class="form-control" type="text" name="username" placeholder="User name"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "login.password"/>: </label>
            <div class="col-sm-5">
                <input class="form-control" type="password" name="password" placeholder="Password"/>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="form-group row">
                <label for="role" class="col-sm-2 col-form-label"><@spring.message "login.role"/>: </label>
                <div class="col-sm-5">
                    <select class="custom-select" id="role" name="role">
                        <option disabled selected><@spring.message "login.role"/></option>
                        <option value="USER"><@spring.message "role.user"/></option>
                        <option value="ADMIN"><@spring.message "role.admin"/></option>
                    </select>
                </div>
            </div>
        </#if>
        <button class="btn btn-primary mr-2" type="submit">
            <#if isRegisterForm><@spring.message "role.create"/><#else><@spring.message "login.sign_in"/></#if>
        </button>
        <#if !isRegisterForm>
            <a href="/registration"><@spring.message "login.add_new_user"/></a>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
    </form>
</#macro>

<#macro logout username>
    <form action="/logout" method="post">
        <input class="btn btn-primary" type="submit" value="<@spring.message "nav.sign_out"/> (${username})"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
    </form>
</#macro>