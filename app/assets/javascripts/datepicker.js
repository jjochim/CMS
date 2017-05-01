$(document).ready(function(){
    $('.datepicker').datepicker({
        dateFormat: 'yyyy-mm-dd',
        language: "pl"
    });

    $('.input-daterange').datepicker({
        dateFormat: 'yyyy-mm-dd',
        language: "pl"
    });

    $('#seance_date_start').datepicker().on('changeDate', function(){
        var date = $('#seance_date_start').val();
        $('.seance_header_date_start').empty();
        $('.seance_header_date_start').append(date);
    });
});