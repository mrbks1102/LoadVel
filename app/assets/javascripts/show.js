$(document).on('turbolinks:load', function () {
  $('.nav_item').click(function () {
    $('.nav_item').removeClass('active');
    $(this).addClass('active');

    var index = $('.nav_item').index(this);
    $('.user_contents_item').eq(index).addClass('activ');
    $('.user_contents_item').eq(index).siblings().removeClass('activ');
  });
});

