$(function() {
  $('.input.association select, .input.boolean select').select2({
    width: '100%'
  });
  $('select.datetime').select2();
  $('.date-range input').datepicker();
  $('.filter-panel select').dropkick();
});