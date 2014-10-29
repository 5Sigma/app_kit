$(function() {
    $('table tr td').click(function(e) {
        row_url = $(this).parent().data('url')
        if ($(this).hasClass('checkbox-cell')) { 
            return; 
        }
        window.location.href =  row_url
    });
})
