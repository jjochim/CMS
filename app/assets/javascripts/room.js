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
})

$(document).on('page:load', function() {
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
