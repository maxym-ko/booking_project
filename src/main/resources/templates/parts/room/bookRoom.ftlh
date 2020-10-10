<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal"
        data-target="#bookModal">
    Book now
</button>

<!-- Modal -->
<div class="modal fade" id="bookModal" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form action="/book" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Select check-in and
                        check-out date</h5>
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="check-in" class="col-4 col-form-label">Check-in</label>
                        <div class="col-8">
                            <input class="form-control" name="checkInDate" type="date"
                                   id="check-in">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="check-out"
                               class="col-4 col-form-label">Check-out</label>
                        <div class="col-8">
                            <input class="form-control" name="checkOutDate" type="date"
                                   id="check-out">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        Close
                    </button>
                    <button type="submit" class="btn btn-success">Book</button>
                </div>
            </div>
            <input type="hidden" name="id" value="${room.id}">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
        </form>
    </div>
</div>