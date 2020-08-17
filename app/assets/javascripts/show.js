$(document).on("turbolinks:load", function () {
  $(".user_nav_item").click(function () {
    $(".user_nav_item").removeClass("active");
    $(this).addClass("active");

    var index = $(".user_nav_item").index(this);
    $(".user_contents_item").eq(index).addClass("item_active");
    $(".user_contents_item").eq(index).siblings().removeClass("item_active");
  });
});

