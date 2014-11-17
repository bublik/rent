$ ->
  $('#switch_town').change (e)->
    window.location =  $(e.target).data('url')+'&town_id='+e.target.value
