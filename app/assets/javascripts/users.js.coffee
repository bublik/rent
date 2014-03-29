$ ->
  $('#users').tab()
  # таб навигация по типам пользователей
  $('#users a').click (e)->
    target_path = $(this).data('targer')
    tab_pane = $( $(this).attr('href'))
    $(tab_pane).load(target_path)
    $(this).tab('show')

    e.preventDefault()
    e.stopPropagation()

  $('#users a:first').trigger('click')

