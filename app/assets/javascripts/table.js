$(function() {
    $('table tr.data-row td').click(function(e) {
        row_url = $(this).parent().data('url')
        window.location.href =  row_url
    });
})
