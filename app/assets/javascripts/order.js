$(document).on("submit", '#cms-comfirm-order', function(e) {
    var _data, _url;
    e.preventDefault();
    _data = {
        'name': 'order_name',
        'surname': 'order_name1',
        'email': 'order_name2',
        'phone': 'order_name3'
    };
    console.log(_data);
    _url = $('.cms-url-order').data('url')+".json";
    console.log(_url);
    // return $.ajax({
    //     method: 'put',
    //     dataType: 'json',
    //     data: _data,
    //     url: _url,
    //     success: function(response) {
    //         return swal({
    //             title: 'Przyjeto zamówienie!',
    //             text: 'Życzymy miłego seansu!<br><button class="swall-ok">Ok</button>',
    //             type: 'success',
    //             html: true,
    //             showConfirmButton: false
    //         });
    //     },
    //     error: function(response) {
    //         return swal({
    //             title: 'Błąd',
    //             text: 'Błedne dane<br><button class="swall-error">Ok</button>',
    //             type: 'warning',
    //             html: true,
    //             showConfirmButton: false
    //         });
    //     }
    // });
});

HTML = null;
PAYPALHTML = null;

var ticketsManagement = {
    ticketsLeft: 10,
    selectedFields: [],
    selectedSeatingNumber: [],


    DOMs: {
        seatingButtons: null,
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
            this.book(this.selectedFields, this.selectedSeatingNumber);
            this.paypal(this.selectedFields, this.selectedSeatingNumber);

        } else {

            if (this.ticketsLeft > 0) {
                this.selectedFields.push(id);
                this.selectedSeatingNumber.push(number);
                console.log("to to",this.selectedFields, this.selectedSeatingNumber);

                $(dom).addClass('cms-selected-seat');
                this.ticketsLeft--;
                this.book(this.selectedFields, this.selectedSeatingNumber);
                this.paypal(this.selectedFields, this.selectedSeatingNumber);

            } else {
                swal("Uwaga!", "Osiągnięto maksymalną liczbę biletów!", "warning");
            }

        }
    },

    book: function( tab, tab2) {
        document.getElementById('cms-submit-order').href = HTML + '&' + 'ARR_OF_SELECTED_FIELDS=' + tab + '&ARR_OF_SELECTED_SEATING_NUMBRE=' + tab2 + '&payment=false';
    },

    paypal: function( tab, tab2) {
        document.getElementById('cms-submit-order-paypal').href = PAYPALHTML + '&' + 'ARR_OF_SELECTED_FIELDS=' + tab + '&ARR_OF_SELECTED_SEATING_NUMBRE=' + tab2 + '&payment=true';
    },

    deploy: function( seatingButtons) {
        this.DOMs.seatingButtons = seatingButtons;

        this.DOMs.seatingButtons.click(function(event) {
            event.preventDefault();
            event.stopPropagation();

            ticketsManagement.toggleSeating(event.currentTarget.dataset.seatingId, event.currentTarget.dataset.seatingNumber, this);
        });
    }
};

$(document).on('turbolinks:load', function() {
    HTML = document.getElementById('cms-submit-order').href;
    PAYPALHTML = document.getElementById('cms-submit-order-paypal').href;
    ticketsManagement.deploy($('.cms-seatable'));
});

