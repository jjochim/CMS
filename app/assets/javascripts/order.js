$(document).on("click", '.cs-submit-order', function(e) {
    var _data, _url;
    e.preventDefault();
    console.log($('#seance_id'));
    _data = {
        ARR_OF_SELECTED_FIELDS: ticketsManagement.selectedFields,
        HASH_OF_SELECTED_TICKETS: HASH_OF_SELECTED_TICKETS,
        ARR_OF_SELECTED_SEATING_NUMBRE: ticketsManagement.selectedSeatingNumber,
        'id': $('#order_seance_id').val(),
        'name': $('#order_name').val(),
        'surname': $('#order_surname').val(),
        'email': $('#order_email').val(),
        'phone': $('#order_phone').val()
    };
    console.log(_data);
    _url = '/orders/';
    return $.ajax({
        method: 'post',
        dataType: 'json',
        data: _data,
        url: _url,
        success: function(response) {
            return swal({
                title: 'Przyjeto zamówienie!',
                text: 'Życzymy miłego seansu!<br><button class="swall-ok">Ok</button>',
                type: 'success',
                html: true,
                showConfirmButton: false
            });
        },
        error: function(response) {
            return swal({
                title: 'Błąd',
                text: 'Błedne dane<br><button class="swall-error">Ok</button>',
                type: 'warning',
                html: true,
                showConfirmButton: false
            });
        }
    });
});

HASH_OF_SELECTED_TICKETS = {};

var ticketsManagement = {
    maxSeats: null,
    ticketsNumber: 0,
    ticketsLeft: 0,
    selectedFields: [],
    selectedSeatingNumber: [],
    ticketsArr: [],
    ticketsName: [],



    DOMs: {
        ticketType: null,
        ticketNumber: null,
        ticketAdd: null,
        listRender: null,
        seatingButtons: null,
        seatingsLeftCounter: null
    },

    addTicket: function() {
        var type = this.DOMs.ticketType.val();
        var text = this.DOMs.ticketType.text();
        ticketsName = text.split("\n");
        var numb = parseInt(this.DOMs.ticketNumber.val());

        console.log(this.ticketsNumber , numb, this.maxSeats);

        var found = false;
        if (this.ticketsNumber + numb <= this.maxSeats) {
            for (var i=0; i<this.ticketsArr.length && !found; i++) {
                if (this.ticketsArr[i].type === type) {
                    found = true;
                    this.ticketsArr[i].number += numb;
                }
            }

            if (!found) {
                this.ticketsArr.push(new this.ticketProto(type, numb));
            }
            this.ticketsNumber += numb;
            this.ticketsLeft   += numb;
            this.reRender();

        } else {
            swal("Brak miejsc!", "Przekroczyłeś możliwą ilość miejsc!", "warning");
        }

    },

    removeTicket: function(index, count) {
        this.ticketsNumber -= count;
        this.ticketsLeft -= count;
        this.ticketsArr.splice(index, 1);
        this.reRender();
    },

    removeHash: function (ticket) {
        delete HASH_OF_SELECTED_TICKETS[ticket];
    },

    reRender: function() {
        this.DOMs.listRender.html("");

        for (var i=0; i<this.ticketsArr.length; i++) {
            this.DOMs.listRender.append(this.htmlTicketProto(this.ticketsArr[i], i));
            this.DOMs.listRender.append(this.ticketToHash(this.ticketsArr[i]));
        }

        this.rebindDelete();
    },

    refreshTicketsLeft: function() {
        this.DOMs.seatingsLeftCounter.html(this.ticketsLeft);
    },

    toggleSeating: function(id, number, dom) {

        console.info("Toggle seating function input arguments: ", id, "|", number, "|", dom);
        var found = false;
        var index = null;

        for (var i=0; i<this.selectedFields.length && !found; i++) {
            if (this.selectedFields[i] === id) {
                found = true;
                index = i;
            }
        }

        if (found) {

            this.ticketsLeft++;
            this.selectedFields.splice(index, 1);
            this.selectedSeatingNumber.splice(index, 1);

            $(dom).removeClass('cms-selected-seat');
        } else {

            if (this.ticketsLeft > 0) {
                this.selectedFields.push(id);
                this.selectedSeatingNumber.push(number);
                console.log("to to",this.selectedFields, this.selectedSeatingNumber);

                $(dom).addClass('cms-selected-seat');
                this.ticketsLeft--;
            } else {
                swal("Uwaga!", "Osiągnięto maksymalną liczbę biletów!", "warning");
            }

        }

        this.refreshTicketsLeft();
    },

    ticketProto: function(type, number) {
        this.type = type;
        this.number = parseInt(number);
    },

    htmlTicketProto: function(ticket, index) {
        return (
            "<div class='row'>" +
            "<div class='col-xs-4'>" +
            ticketsName[ticket.type - 1] +
            "</div>" +
            "<div class='col-xs-4'>" +
            ticket.number +
            "</div>" +
            "<div class='col-xs-4'>" +
            "<button class='btn-ticket-delete' data-ticket-count='" + ticket.number + "' data-ticket-name='" + ticketsName[ticket.type - 1] + "' data-index='" + index + "'>Usuń</button>" +
            "</div>"
        );
    },

    ticketToHash: function(ticket) {
        HASH_OF_SELECTED_TICKETS[ticketsName[ticket.type - 1]] = ticket.number;
        console.log(HASH_OF_SELECTED_TICKETS);
    },

    rebindDelete: function() {
        $(".btn-ticket-delete").click(function() {
            ticketsManagement.removeTicket(this.dataset.index, this.dataset.ticketCount);
            ticketsManagement.removeHash(this.dataset.ticketName);
        });
    },

    deploy: function(maxSeatsDom, ticketTypeDom, ticketNumberDom, ticketAdd, listDom, seatingButtons, ticketsLeftCounter) {
        this.maxSeats = parseInt(maxSeatsDom.html());
        this.DOMs.ticketType = ticketTypeDom;
        this.DOMs.ticketNumber = ticketNumberDom;
        this.DOMs.ticketAdd = ticketAdd;
        this.DOMs.listRender = listDom;
        this.DOMs.seatingButtons = seatingButtons;
        this.DOMs.seatingsLeftCounter = ticketsLeftCounter;

        this.DOMs.ticketAdd.click(function() {
            ticketsManagement.addTicket();
        });

        this.DOMs.seatingButtons.click(function(event) {
            event.preventDefault();
            event.stopPropagation();

            ticketsManagement.toggleSeating(event.currentTarget.dataset.seatingId, event.currentTarget.dataset.seatingNumber, this);
        });
    }
};

$(document).on('turbolinks:load', function() {
    ticketsManagement.deploy($("#dom0"), $("#dom1"), $("#dom2"), $("#dom3"), $("#dom4"), $('.cms-seatable'), $('#dom5'));
});