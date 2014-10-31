$(document).ready(function(){
  $('.filter-trigger').on('click touchstart', function(e){
    $('.filter-panel').toggleClass('is-visible');
    $('.filter-screen').toggleClass('is-visible');
    e.preventDefault();
  });

  $('.filter-screen').on('click touchstart', function(e){
    $('.filter-panel').toggleClass('is-visible');
    $('.filter-screen').toggleClass('is-visible');
    e.preventDefault();
  });
});


$(function() {
    $('.predicate-select select').on('change', function() {
        var condition = $(this).val();
        input = $(this).parent().parent().find('.value input');
        var name = input.attr('id').split('_').splice(-1,1).join('_');
        input.attr('name', "q[" + name + "_" + condition + "]");

    });
});
