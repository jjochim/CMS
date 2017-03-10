$(document).on("click", '.cs-submit-order', function(e) {
    var _data, _url;
    e.preventDefault();
    console.log($('#seance_id'));
    _data = {
        ARR_OF_SELECTED_FIELDS: ticketsManagement.selectedFields,
        ARR_OF_SELECTED_SEATING_NUMBRE: ticketsManagement.selectedSeatingNumber,
    'name': 'order_name',
        'surname': 'order_name1',
        'email': 'order_name2',
        'phone': 'order_name3',
        'seance_id': 2
    };
    console.log(_data);
    _url = '/orders/';
    return $.ajax({
        method: 'get',
        dataType: 'json',
        data: _data,
        url: _url,
        success: function(response) {
            return swal({
                title: 'Przyjeto zamówienie!',
                text: 'Życzymy miłego seansu!<br><button>Ok</button>',
                type: 'success',
                html: true,
                showConfirmButton: false
            });
        },
    });
});

HTML = null;

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
            this.tr(this.selectedFields, this.selectedSeatingNumber);

        } else {

            if (this.ticketsLeft > 0) {
                this.selectedFields.push(id);
                this.selectedSeatingNumber.push(number);
                console.log("to to",this.selectedFields, this.selectedSeatingNumber);

                $(dom).addClass('cms-selected-seat');
                this.ticketsLeft--;
                this.tr(this.selectedFields, this.selectedSeatingNumber);

            } else {
                swal("Uwaga!", "Osiągnięto maksymalną liczbę biletów!", "warning");
            }

        }
    },

    tr: function( tab, tab2) {
        document.getElementById('cms-submit-order').href = HTML + '&' + 'ARR_OF_SELECTED_FIELDS=' + tab + '&ARR_OF_SELECTED_SEATING_NUMBRE=' + tab2;
        console.log(document.getElementById('cms-submit-order').href);
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
    ticketsManagement.deploy($('.cms-seatable'));
});

