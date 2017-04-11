// $(document).ready(function() {
//     $("div.movies-item")
//         .mouseout(function () {
//             var id = $(this).data('toltip');
//             $('#' + id).css('display', 'none');
//
//     })
//         .mouseover(function () {
//             var id = $(this).data('toltip');
//             var top = $(this).position().top;
//             var left = $(this).position().left;
//             $('#' + id).css('top', top + 133);
//             $('#' + id).css('left', left + 250);
//             $('#' + id).css('display', 'block');
//             console.log($(this).position().left);
//             console.log($(this).position().top);
//         });
// });
//
// $(document).on("click", '#trailer', function() {
//     $('#my-trailer').css('display','block');
//     var span = $('#close-trailer');
//     span.css('position', 'absolute');
//     span.css('top', 10);
//     span.css('left', 20);
// });
//
// $(document).on("click", '#close-trailer', function() {
//     $('#my-trailer').css('display','none');
// });
//
