<#import "/spring.ftl" as spring />

<!-- Button trigger modal -->
<button <#if reservation.status != "PAYMENT_WAITING" >disabled</#if> type="button" class="btn btn-success"
        data-toggle="modal"
        data-target="#bookModal">
    <#if reservation.status == "PAYMENT_WAITING" >
        <@spring.message "reservations.action.payment.confirm"/>
    <#else>
        <@spring.message "reservations.action.payment.confirmed"/>
    </#if>
</button>

<!-- Modal -->
<div class="modal fade" id="bookModal" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form action="/payment-confirm" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Enter receipt id to confirm</h5>
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="receiptId" class="col-4 col-form-label">Receipt ID: </label>
                        <div class="col-8">
                            <input class="form-control" name="receiptId" type="text"
                                   id="receiptId">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-success">Confirm</button>
                </div>
            </div>
        </form>
    </div>
</div>