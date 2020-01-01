$(document).on('turbolinks:load', function() {
  $('.banner-area').slick({
      dots: true,
      autoplay: true,
      autoplaySpeed: 3000,
      speed:1500,
      pauseOnFocus: false,
      pauseOnHover: false,
      pauseOnDotsHover: false
  });
});