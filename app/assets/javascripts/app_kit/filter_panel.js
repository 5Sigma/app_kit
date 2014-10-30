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
