/**
 * Created by jj on 30.10.16.
 */
$(document).on('ready', function() {
    $(".regular").slick({
        dots: true,
        infinite: true,
        slidesToShow: 6,
        slidesToScroll: 3,
        autoplay: true,
        autoplaySpeed: 4000
    });
});;