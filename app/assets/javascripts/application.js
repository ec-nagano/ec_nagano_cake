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
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function () {
  var view_box = $('.view_box');

  $(".file").on('change', function(){
     var fileprop = $(this).prop('files')[0],
         find_img = $(this).next('img'),
         fileRdr = new FileReader();

     if(find_img.length){
        find_img.nextAll().remove();
        find_img.remove();
     }

    var img = '<img width="250", alt="" class="img_view">';

    view_box.append(img);

    fileRdr.onload = function() {
      view_box.find('img').attr('src', fileRdr.result);
      img_del(view_box);
    }
    fileRdr.readAsDataURL(fileprop);
  });

  function img_del(target)
  {
     target.find("a.img_del").on('click',function(){

      if(window.confirm('サーバーから画像を削除します。\nよろしいですか？'))
      {
         $(this).parent().find('input[type=file]').val('');
         $(this).parent().find('.img_view, br').remove();
         $(this).remove();
      }

      return false;
    });
  }
});