$ ->
  $('#switch_town').change (e)->
    url = window.location.href
    console.log 'dataurl', $(e.target).data('url')
    console.log e.target.value

    window.location =  $(e.target).data('url')+'&town_id='+e.target.value

