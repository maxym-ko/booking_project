<#import "/spring.ftl" as spring />

<a class="btn btn-primary mb-3" data-toggle="collapse" href="#addNewRoomId" role="button" aria-expanded="false"
   aria-controls="collapseExample">
    <@spring.message "room.add.title"/>
</a>
<div class="collapse" id="addNewRoomId">
    <div class="form-group">
        <form method="post" enctype="multipart/form-data">
            <div class="form-row">
                <div class="form-group col-md">
                    <input class="form-control" type="text" name="<@spring.message "room.add.capacity"/>" placeholder="capacity">
                </div>
                <div class="form-group col-md">
                    <input class="form-control" type="text" name="<@spring.message "room.add.price"/>" placeholder="price">
                </div>
                <div class="form-group col-md">
                    <select class="custom-select" name="type" class="form-control">
                        <option disabled selected><@spring.message "room.add.type"/></option>
                        <option value="ECONOMY"><@spring.message "room.type.economy"/></option>
                        <option value="STANDARD"><@spring.message "room.type.standard"/></option>
                        <option value="LUXURY"><@spring.message "room.type.luxury"/></option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile">
                    <label class="custom-file-label" for="customFile"><@spring.message "room.add.image"/></label>
                </div>
            </div>
            <div class="form-group">
                <button class="btn btn-success" type="submit"><@spring.message "room.add"/></button>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
        </form>
    </div>
</div>