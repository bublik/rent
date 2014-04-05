$ ->
  $('div, span').tooltip()
  $('#date_picker').datetimepicker({ language: 'ru', pickTime: false}).on 'changeDate', (ev) ->
    $('#date_picker').datetimepicker('hide')