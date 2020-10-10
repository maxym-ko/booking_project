<a class="btn btn-primary mb-3" data-toggle="collapse" href="#addNewRoomId" role="button" aria-expanded="false"
   aria-controls="collapseExample">
    Add new room
</a>
<div class="collapse" id="addNewRoomId">
    <div class="form-group">
        <form method="post" enctype="multipart/form-data">
            <div class="form-row">
                <div class="form-group col-md">
                    <input class="form-control" type="text" name="capacity" placeholder="capacity">
                </div>
                <div class="form-group col-md">
                    <input class="form-control" type="text" name="price" placeholder="price">
                </div>
                <div class="form-group col-md">
                    <select class="custom-select" name="type" class="form-control">
                        <option disabled selected>Select room type</option>
                        <option value="ECONOMY">ECONOMY</option>
                        <option value="STANDARD">STANDARD</option>
                        <option value="LUXURY">LUXURY</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile">
                    <label class="custom-file-label" for="customFile">Choose room image</label>
                </div>
            </div>
            <div class="form-group">
                <button class="btn btn-success" type="submit">Add</button>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
        </form>
    </div>
</div>