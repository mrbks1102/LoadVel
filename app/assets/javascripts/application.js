// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


//flash非表示//
$(function () {
  setTimeout("$('.flash').fadeOut('slow')", 2000)
})

//スマホナビの表示・非表示//
$(document).on("turbolinks:load", function () {
  const hum = $('#hamburger, .close')
  const nav = $('.sp-nav')
  hum.on('click', function () {
    nav.toggleClass('toggle');
  });
});

//プロフページスライドバー//
$(document).on("turbolinks:load", function () {
  $(".user_nav_item").click(function () {
    $(".user_nav_item").removeClass("active");
    $(this).addClass("active");

    var index = $(".user_nav_item").index(this);
    $(".user_contents_item").eq(index).addClass("item_active");
    $(".user_contents_item").eq(index).siblings().removeClass("item_active");
  });
});

//プロフ編集ページ画像プレビュー//
$(document).on("turbolinks:load", function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $("#avatar_img_prev").attr("src", e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#post_img").change(function () {
    $("#avatar_img_prev").removeClass("hidden");
    $(".avatar_present_img").remove();
    readURL(this);
  });
});
