# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'turbolinks:load', ->
  $('a.reply').on('click', (e) ->
    e.preventDefault();
    reply = $(this).attr('data-reply')
    $('tr.forum-reply-reply[data-reply="' + reply + '"]').fadeToggle(200);
  )


  'use strict';
  forms = $('.needs-validation')
  forms.each((i, form) ->
    $(form).on('submit', (e) ->
      if form.checkValidity() is false
        e.preventDefault()
        e.stopPropagation()
      $(form).addClass('was-validated')
    )
  )
