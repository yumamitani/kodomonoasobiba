$(function(){
  $( document ).on('turbolinks:load', function() {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
   
        reader.onload = function (e) {
          $('.image').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
   
    $(".post-image").change(function(){
      $('.image').removeClass('hidden');
      $('.icon').remove();
      readURL(this);
    });
  });
});
