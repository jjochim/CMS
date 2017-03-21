/**
 * Created by jj on 02.11.16.
 */

var SeatingUtils = {
    /**
     * sprytne castowanie stringow/intow do booleana
     * @param value
     * @returns {boolean}
     */
    castBoolean: function(value) {
        return value === "true" || !(value === "false" || (value * 1) === 0 || isNaN(value * 1));

    },
    /**
     * initializacja widoku, uruchomienie logiki klienckiej
     */
    initialize: function() {
        var elements = $('.seat');
        elements.each(function(i, el) {
            this.setSeatingStatus($(el), this.castBoolean($(el).find('.seating-status').val()));
        }.bind(this));

        this.observe(elements);
    },
    /**
     * aktualizacja wiersza po wykonaniu requestu
     * @param $div
     * @param data
     */
    updateRow: function($div, data) {
        this.setSeatingStatus($div, data.slot);
    },
    /**
     * aktualizuje wartość inputa "space" oraz zarządza zmianami wizualnymi
     * @param $div
     * @param value
     */
    setSeatingStatus: function($div, value) {
        $div.find('.seating-status').val(value);
        if(value) {
            $div.addClass('is-na-true');
        } else {
            $div.removeClass('is-na-true');
        }
    },
    /**
     * wykonuje zapis wiersza z obecnym stanem
     * @param $div
     */
    save: function($div) {
        var form = $div.find('form');
        $.rails.handleRemote(form);
    },
    /**
     * podpina sie na zdarzenia pod zbior elementow
     * @param elements jQuery
     */
    observe: function(elements) {

        elements.on('ajax:success',function(e, data, status, xhr) {
            //console.log("CZYM SĄ ELEMENTY", elements);
            //console.log(e.currentTarget);
            this.updateRow($(e.currentTarget), data);
        }.bind(this));
    }

};

$(document).ready(function() {
    // your stuff here
    // uruchamiam obsluge jsa
    SeatingUtils.initialize();
    //console.log("INI");
    // podpinam obsluge zmiany i zapisu
    $('.seat').on('click', function(e) {
        var $div = $(e.currentTarget);
        //console.log("CLICKED", e.currentTarget);
        var $input = $div.find('.seating-status');
        //console.log($input.val( (!SeatingUtils.castBoolean($input.val())).toString() ))
        $input.val( (!SeatingUtils.castBoolean($input.val())).toString() );
        SeatingUtils.save($div);
    });
});

// $(document).on('page:load', function() {
//     // your stuff here
//     // uruchamiam obsluge jsa
//     SeatingUtils.initialize();
//     //console.log("INI");
//     // podpinam obsluge zmiany i zapisu
//     $('.seat').on('click', function(e) {
//         var $div = $(e.currentTarget);
//         //console.log("CLICKED", e.currentTarget);
//         var $input = $div.find('.seating-status');
//         //console.log($input.val( (!SeatingUtils.castBoolean($input.val())).toString() ))
//         $input.val( (!SeatingUtils.castBoolean($input.val())).toString() );
//         SeatingUtils.save($div);
//     });
// });

$(document).on("click", '#cms-room-create', function(e) {
    $('#myModal').css('display', 'block');
});


$(document).ready(function() {
    var colums = $('#cms-columns').text();
    var margin = 5;
    var seat = (1115/colums-2*margin);
    var width = $(".seatings-container").css("width");
    if( parseFloat(colums.trim()) > 18){
        $(".seatings-container").css('width','100%');
        $(".seatings-container").css('height','auto');
        // $(".seatings-container").css('margin_right','25px')
        $(".seat").css("width", seat + "px");
        $(".seat").css("height", seat + "px");
        // $(".seating-legend-vertical").css("left", ((1170/$('#cms-columns').text()-2*margin)/2)+12.5+"px")
        $(".seating-legend-vertical").css("width", 1115+"px");
        $(".seating-legend-vertical").css("display", 'flex');
        // $(".seating-legend-vertical").css("justify-content", 'space-around')
        $(".seating-legend-vertical").css("left", '25px');
        $(".legend-item").css("padding-top", '0');
        $(".legend-item").css("height", 'auto');
        $('.seatings').ready(function(){
            $(".seating-legend-horizontal").css("height", $('.seatings').height()+"px");
        });
        $(".seating-legend-horizontal").css("display", 'flex');
        $(".seating-legend-horizontal").css("justify-content", 'space-around');
        $(".seating-legend-horizontal").css("left", '0px');
        $(".seating-legend-horizontal").css("top", '25px');
        $(".seating-legend-horizontal").css("flex-direction", 'column');
        $(".seating-row").css('display', 'flex');
        $(".seating-row").css('height', 'auto');
        $(".seating-row").css('width', 'auto');
        console.log((1170/$('#responseObject').text()) + "px");

        $(".cms-screen-wrapper").css("width", colums * seat + "px");
    }else {
        $(".cms-screen-wrapper").css("width", parseFloat(width) * 0.8 + "px");
    }
});