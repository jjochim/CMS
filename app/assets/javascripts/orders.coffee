# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on(
  "click",
  '#next',
  (e)->
    e.preventDefault()
    if ticketsManagement.ticketsLeft < 1
      swal
        title: 'Nie wybrano biletu!'
        text: 'Proszę najpierw wybrać bilet!'
        type: 'warning'
    else
      ticketsManagement.refreshTicketsLeft()
      ReverseContent("reserve_seats")
      ReverseContent("customer_data")
      ReverseContent("next")

)

ReverseContent = (d) ->
  if d.length < 1
    return
  if document.getElementById(d).style.display == 'none'
    document.getElementById(d).style.display = 'block'
  else
    document.getElementById(d).style.display = 'none'
  return

$(document).on(
  "click",
  '.swall-error',
  (e)->
    e.preventDefault()
    ReverseContent("reserve_seats")
    ReverseContent("customer_data")
    ReverseContent("next")
)

$(document).on(
  "click",
  '.swall-ok',
  (e)->
    e.preventDefault()
    url = location.href
    url_http = url.replace('http://', '')
    end_url = url_http.indexOf('/')
    window.location.href = 'http://' + url_http.substring(0,end_url)
)