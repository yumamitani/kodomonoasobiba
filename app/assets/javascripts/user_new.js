$(function(){
  $( document ).on('turbolinks:load', function() {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
   
        reader.onload = function (e) {
          $('.avatar').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
   
    $(".file-field").change(function(){
      $('.avatar').removeClass('hidden');
      $('.icon').remove();
      readURL(this);
    });
  });
});