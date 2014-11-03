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
    id_tokens = input.attr('id').split('_');
    name = input.data('field');
    input.attr('name', "q[" + name + "_" + condition + "]");
  });
});
