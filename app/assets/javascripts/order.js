$(document).on("click", '#cms-comfirm-order', function(e) {
    var _data, _url;
    e.preventDefault();
    _data = {
    'order':{'name': $('#order_name').val(),
        'surname': $('#order_surname').val(),
        'email': $('#order_email').val(),
        'phone': $('#order_phone').val()}
    };
    console.log(_data);
    _url = $('.cms-url-order').data('url');
    console.log(_url);
    return $.ajax({
        method: 'put',
        dataType: 'json',
        data: _data,
        url: _url,
        success: function(response) {
            return swal({
                title: 'Przyjęto zamówienie!',
                text: 'Na Twój adres e-mail została wysłana wiadomość z linkiem aktywacyjnym. Należy go aktywować w ciągu 5 minut!<br><button class="swall-ok">Ok</button>',
                type: 'success',
                html: true,
                showConfirmButton: false
            });
        },
        error: function(response) {
            return swal({
                title: 'Błąd',
                text: 'Błędne dane<br><button class="swall-error">Ok</button>',
                type: 'warning',
                html: true,
                showConfirmButton: false
            });
        }
    });
});




// $(document).on("click", '#cms-comfirm-paypal', function(e) {
//     var _data, _url;
//     e.preventDefault();
//     _data = {
//         'order':{'name': $('#order_name').val(),
//             'surname': $('#order_surname').val(),
//             'email': $('#order_email').val(),
//             'phone': $('#order_phone').val()}
//     };
//     console.log(_data);
//     _url = $('.cms-url-order').data('url');
//     console.log(_url);
//     return $.ajax({
//         method: 'put',
//         dataType: 'json',
//         data: _data,
//         url: _url,
//         success: function(response) {
//             return swal({
//                 title: 'Przyjeto zamówienie!',
//                 text: 'Życzymy miłego seansu!<br><button class="swall-ok">Ok</button>',
//                 type: 'success',
//                 html: true,
//                 showConfirmButton: false
//             });
//         },
//         error: function(response) {
//             return swal({
//                 title: 'Błąd',
//                 text: 'Błedne dane<br><button class="swall-error">Ok</button>',
//                 type: 'warning',
//                 html: true,
//                 showConfirmButton: false
//             });
//         }
//     });
// });

HTML = null;
PAYPALHTML = null;

var seatsManagement = {
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
                console.log("to to",this.selectedFields, this.selectedSeatingNumber, this.selectedFields.length);

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

            seatsManagement.toggleSeating(event.currentTarget.dataset.seatingId, event.currentTarget.dataset.seatingNumber, this);
        });
    }
};

$(document).on('turbolinks:load', function() {
    ticketsManagement.deploy($("#dom0"), $("#dom1"), $("#dom2"), $("#dom3"), $("#dom4"), $('#dom5'), $("#dom6"));
    HTML = document.getElementById('cms-submit-order').href;
    PAYPALHTML = document.getElementById('cms-submit-order-paypal').href;
    seatsManagement.deploy($('.cms-seatable'));
});

HASH_OF_SELECTED_TICKETS = {};
HASH_PRICE_TICKET = {};

var ticketsManagement = {
    maxSeats: null,
    ticketsNumber: 0,
    ticketsLeft: 0,
    sumTicketsPrice: 0,
    ticketsArr: [],
    ticketsName: [],



    DOMs: {
        ticketType: null,
        ticketNumber: null,
        ticketAdd: null,
        listRender: null,
        seatingsLeftCounter: null,
        ticketPrice: null
    },

    addTicket: function() {
        var type = this.DOMs.ticketType.val();
        var text = this.DOMs.ticketType.text();
        ticketsName = text.split("\n");
        console.log(ticketsName);
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
        delete HASH_OF_SELECTED_TICKETS[ticket.substr(0,ticket.indexOf(' '))];
        delete HASH_PRICE_TICKET[ticket];
        this.ticketsPrice();
    },

    reRender: function() {
        this.DOMs.listRender.html("");

        for (var i=0; i<this.ticketsArr.length; i++) {
            this.DOMs.listRender.append(this.htmlTicketProto(this.ticketsArr[i], i));
            this.DOMs.listRender.append(this.ticketToHash(this.ticketsArr[i]));
        }

        this.rebindDelete();
        this.refreshTicketsLeft();
        // console.log('tuuuuuuuuuuuu');
        // console.log(this.DOMs.ticketNumber.children.val());
    },

    refreshTicketsLeft: function() {
        this.DOMs.seatingsLeftCounter.html(this.ticketsLeft);
    },

    refreshTicketsPrice: function () {
        this.DOMs.ticketPrice.html(this.sumTicketsPrice);
    },

    ticketProto: function(type, number) {
        this.type = type;
        this.number = parseInt(number);
    },

    htmlTicketProto: function(ticket, index) {
        return (
            "<div class='row cms-payments-tickets-chosen'>" +
            "<div class='col-xs-5 cms-ticket-type-a'>" +
            "<div class='panel panel-default cms-ticket-type-b'>" +
            "<div class='panel-body'>" +
            ticketsName[ticket.type - 1] +
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='col-xs-4 cms-ticket-number-a' >" +
            "<div class='panel panel-default cms-ticket-number-b'>" +
            "<div class='panel-body'>" +
            ticket.number +
            "</div>" +
            "</div>" +
            "</div>" +
            "<button class='col-xs-3 btn btn-default btn-ticket-delete' data-ticket-count='" + ticket.number + "' data-ticket-name='" + ticketsName[ticket.type - 1] + "' data-index='" + index + "'>Usuń</button>" +
            "</div>"
        );
    },

    ticketToHash: function(ticket) {
        HASH_OF_SELECTED_TICKETS[ticketsName[ticket.type - 1].substr(0,ticketsName[ticket.type - 1].indexOf(' '))] = ticket.number;
        HASH_PRICE_TICKET[ticketsName[ticket.type - 1]] = ticket.number;
        this.ticketsPrice();
        console.log(HASH_OF_SELECTED_TICKETS);
        // console.log(HASH_PRICE_TICKET);
    },

    ticketsPrice: function() {
        this.sumTicketsPrice = 0;
        for (var i in HASH_PRICE_TICKET) {
            if (HASH_PRICE_TICKET.hasOwnProperty(i)) {
                this.sumTicketsPrice = this.sumTicketsPrice + parseFloat(i.substring(i.indexOf(' '),i.indexOf('zł'))) * parseInt(HASH_PRICE_TICKET[i]);
                // console.log('key is: ' + i.substring(i.indexOf(' '),i.indexOf('zł')) + ', value is: ' + HASH_PRICE_TICKET[i]);
            };
        };
        console.log(this.sumTicketsPrice);
        this.refreshTicketsPrice();
    },

    rebindDelete: function() {
        $(".btn-ticket-delete").click(function() {
            ticketsManagement.removeTicket(this.dataset.index, this.dataset.ticketCount);
            ticketsManagement.removeHash(this.dataset.ticketName);
        });
    },

    deploy: function(maxSeatsDom, ticketTypeDom, ticketNumberDom, ticketAdd, listDom, ticketsLeftCounter, price) {
        this.maxSeats = parseInt(maxSeatsDom.html());
        this.DOMs.ticketType = ticketTypeDom;
        this.DOMs.ticketNumber = ticketNumberDom;
        this.DOMs.ticketAdd = ticketAdd;
        this.DOMs.listRender = listDom;
        this.DOMs.seatingsLeftCounter = ticketsLeftCounter;
        this.DOMs.ticketPrice = price;

        this.DOMs.ticketAdd.click(function() {
            ticketsManagement.addTicket();
        });
    }
};

var ReverseContent;

ReverseContent = function(d) {
    if (d.length < 1) {
        return;
    }
    if (document.getElementById(d).style.display === 'none') {
        document.getElementById(d).style.display = 'block';
    } else {
        document.getElementById(d).style.display = 'none';
    }
};

var SetValue;
SetValue = function(d) {
    if (d.length < 1) {
        return;
    }
    if (document.getElementById(d).value === 'true') {
        document.getElementById(d).value = false;
    } else {
        document.getElementById(d).value = true;
    }
    // console.log(document.getElementById(d).valueOf());
};

var Validate;
Validate = function (d) {
    var tmp = false;
    for (var i = 0, length = d.length; i < length; i++) {
        if (d[i].val().length == 0) {
            SetStyle(d[i]);
            tmp = true;
        }else RemoveStyle(d[i]);
    }
    return tmp;
};

var SetStyle;
SetStyle = function (d) {
  d.css('border', '2px solid red');
  d.css('border-radius', '4px');
};

var RemoveStyle;
RemoveStyle = function (d) {
  d.css('border', '');
  d.css('border-radius', '');
};

$(document).on("click", '#cms-back-payment', function (e) {
   e.preventDefault();
    ReverseContent('cms-cc-payment');
    ReverseContent('cms-data-payment');
    ReverseContent('cms-back-payment');
    SetValue('paid');
    $('#paid').html('Przejdz do płatości');
});

$(document).on("click", '#paid', function(e) {
    var radios = document.getElementsByName('payments');
    var _data, _url, _payment_method;
    var name = $('#order_name');
    var surname = $('#order_surname');
    var email = $('#order_email');
    var selectedTicked = parseInt($('#dom5').html());
    var maxTicked = parseInt($('#dom0').html());
    var tickedDiv = $('#cms-tickets-payment');
    var number = $('#number');
    var firstName = $('#first_name');
    var lastName = $('#last_name');
    var modal = $('#myModal');
    e.preventDefault();
    if (Validate([name,surname,email]) == true){
        return;
    };

    if (selectedTicked != maxTicked){
        SetStyle(tickedDiv);
        return;
    }else RemoveStyle(tickedDiv);

    for (var i = 0, length = radios.length; i < length; i++) {
        if (radios[i].checked) {
            _payment_method = radios[i].value
            if (radios[i].value != 'paypal') {
                if (this.value === 'false') {
                    ReverseContent('cms-cc-payment');
                    ReverseContent('cms-data-payment');
                    ReverseContent('cms-back-payment');
                    SetValue(this.id);
                    console.log($('#paid').html());
                    $('#paid').html('Zapłać');
                    return;
                }else {
                    if (Validate([number, firstName, lastName]) == true){
                        return;
                    };
                };
            };
            modal.css('display', 'block');
            break;
        };
    };

    _data = {
        'order':{
            'name': name.val(),
            'surname': surname.val(),
            'email': email.val(),
            'phone': $('#order_phone').val()},
        HASH_OF_SELECTED_TICKETS: HASH_OF_SELECTED_TICKETS,
        payment_method: _payment_method,
        'credit_card':{
            'number': number.val(),
            'expire_month': $('#expire_month').val(),
            'expire_year': $('#expire_year').val(),
            'first_name': firstName.val(),
            'last_name': lastName.val()}
    };

    console.log(_data);
    _url = $('.cms-url-payment').data('url');
    console.log('dsad'+_url);
    return $.ajax({
        method: 'put',
        dataType: 'json',
        data: _data,
        url: _url,
        success: function(response) {
            if (response.message != 'ok') {
                window.location.href = response.message;
            } else {
                modal.css('display','none');
                return swal({
                    title: 'Przyjęto zamówienie!',
                    text: 'Życzymy miłego seansu!<br><button class="swall-ok">Ok</button>',
                    type: 'success',
                    html: true,
                    showConfirmButton: false
                });
            };
        },
        error: function(response) {
            modal.css('display','none');
            return swal({
                title: 'Błąd',
                text: 'Błędne dane!<br>'+ JSON.parse(response.responseText).message +'<br><button class="swall-error">Ok</button>',
                type: 'warning',
                html: true,
                showConfirmButton: false
            });
        }
    });
});

$(document).on("click", '#cms-order-show', function(e) {
    var selectedTicked = parseInt($('#dom5').html());
    var maxTicked = parseInt($('#dom0').html());
    var tickedDiv = $('#cms-tickets-payment');
    var _url = document.getElementById('cms-order-show').dataset.url;
    var _data = {
        TICKETS: HASH_OF_SELECTED_TICKETS
    }
    console.log(_url);
    console.log(_data);
    e.preventDefault();
    if (selectedTicked != maxTicked){
        SetStyle(tickedDiv);
        return;
    }
    return $.ajax({
        method: 'get',
        dataType: 'json',
        data: _data,
        url: _url,
        success: function(response) {
                return swal({
                    title: 'Przyjęto dane.',
                    text: 'Operacja zakończona powodzeniem!<br><button id="swall-confirm">Ok</button>',
                    type: 'success',
                    html: true,
                    showConfirmButton: false
                });
        },
        error: function(response) {
            return swal({
                title: 'Błąd',
                text: 'Błędne dane!<br><button class="swall-error">Ok</button>',
                type: 'warning',
                html: true,
                showConfirmButton: false
            });
        }
    });
});

$(document).on("click", '#cms-order-buy', function(e) {
    var selectedTicked = parseInt($('#dom5').html());
    var maxTicked = parseInt($('#dom0').html());
    var tickedDiv = $('#cms-tickets-payment');
    var _url = document.getElementById('cms-order-buy').dataset.url;
    var _url2 = document.getElementById('cms-order-buy').dataset.redirect;
    var _data = {
        TICKETS: HASH_OF_SELECTED_TICKETS
    }
    console.log(_url);
    console.log(_url2);
    console.log(_data);
    e.preventDefault();
    if (selectedTicked != maxTicked){
        SetStyle(tickedDiv);
        return;
    }
    return $.ajax({
        method: 'get',
        dataType: 'json',
        data: _data,
        url: _url,
        success: function(response) {
            return swal({
                title: 'Przyjęto dane.',
                text: 'Operacja zakończona powodzeniem!<br><button id="swall-buy" data-redirect='+ _url2 +' >Ok</button>',
                type: 'success',
                html: true,
                showConfirmButton: false
            });
        },
        error: function(response) {
            return swal({
                title: 'Błąd',
                text: 'Błędne dane!<br><button class="swall-error">Ok</button>',
                type: 'warning',
                html: true,
                showConfirmButton: false
            });
        }
    });
});

$(document).on("click", '#swall-buy', function(e){
   var url = location.href;
   var _url2 = document.getElementById('swall-buy').dataset.redirect;
   var url_http = url.replace('http://', '');
   var end_url = url_http.indexOf('/');
   e.preventDefault();
    window.location.href = 'http://' + url_http.substring(0,end_url) + _url2;
});

$(document).on("click", '#swall-confirm', function(){
    location.reload();
});

var Print
Print = function(div) {
    var element = document.getElementById(div);
    var domClone = element.cloneNode(true);
    var $printSection = document.createElement("div");
    $printSection.id = "printSection";
    $printSection.appendChild(domClone);
    document.body.insertBefore($printSection, document.body.firstChild);
    window.print();

    var oldElement = document.getElementById('printSection');
    if (oldElement != null) { oldElement.parentNode.removeChild(oldElement);}

    return true;
};

$(document).on("click", '#button-tickets-print', function(){
    Print('ticket-print');
});