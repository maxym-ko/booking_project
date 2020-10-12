<#import "/spring.ftl" as spring />

<a class="btn btn-primary mb-3" data-toggle="collapse" href="#newApplicationsId" role="button"
   aria-expanded="false"
   aria-controls="collapseExample">
    <@spring.message "room.book_now"/>
</a>
<div class="collapse" id="newApplicationsId">
    <div class="form-group">
        <form action="/room-book" method="post" enctype="multipart/form-data">
            <div class="form-group row">
                <label for="check-in" class="col-sm-5 col-form-label"><@spring.message "room.check_in"/>: </label>
                <div class="col-sm-7">
                    <input class="form-control" id="check-in" type="date" name="checkInDate">
                </div>
            </div>
            <div class="form-group row">
                <label for="check-out" class="col-sm-5 col-form-label"><@spring.message "room.check_out"/>: </label>
                <div class="col-sm-7">
                    <input class="form-control" id="check-out" type="date" name="checkOutDate">
                </div>
            </div>
            <div class="form-group">
                <button class="btn btn-success" type="submit"><@spring.message "room.book"/></button>
            </div>
            <input type="hidden" name="id" value="${room.id}">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
        </form>
    </div>
</div>