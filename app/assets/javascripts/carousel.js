/**
 * Created by jj on 30.10.16.
 */
$(document).on('turbolinks:load', function() {
    $(".regular").slick({
        dots: true,
        infinite: true,
        slidesToShow: 4,
        slidesToScroll: 3,
        autoplay: true,
        autoplaySpeed: 4000
    });
});;