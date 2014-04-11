$ ->
  $('div, span').tooltip()

  $('[data-toggle=popover]').popover()

  $("body").on "click", (e) ->
    $("[data-toggle=\"popover\"]").each ->
      #the 'is' for buttons that trigger popups
      #the 'has' for icons within a button that triggers a popup
      $(this).popover "hide"  if not $(this).is(e.target) and $(this).has(e.target).length is 0 and $(".popover").has(e.target).length is 0
      return
    return

  $('#date_picker').datetimepicker({ language: 'ru', pickTime: false}).on 'changeDate', (ev) ->
    $('#date_picker').datetimepicker('hide')