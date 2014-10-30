$.fn.modal = ->
    return $(@).each ->
        $(@).on 'click', (e) ->
            href = $(@).attr('href')
            e.preventDefault()
            $.get href, (response) ->
                modal = $(response)
                modal.find('select').select2()

                wrapper = $('<div class="modal-wrapper"></div>')
                wrapper.click ->
                    $(wrapper).remove()
                    $(modal).remove()
                $(document.body).append(wrapper)
                $(document.body).append(modal)
                modal.css 'margin-left', modal.width() / 2 * -1
                modal.css {scale: 0.8}
                modal.transition {opacity: 1, scale: 1}, 400, 'cubic-bezier(0,1,0.5,1.3)'





$ ->
    $('.modal-link').modal()
