//スマホナビの表示・非表示//
$(document).on("turbolinks:load", function () {
  const hum = $('#hamburger, .close')
  const nav = $('.sp-nav')
  hum.on('click', function () {
    nav.toggleClass('toggle');
  });
});
