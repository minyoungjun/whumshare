# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

client = new Faye.Client('/faye')

client.subscribe '/chat', (payload)->
  time = moment(payload.created_at).format('D/M/YYYY H:mm:ss')
  # You probably want to think seriously about XSS here:
  $('#chat_box').append("<li>#{time} : #{payload.message}</li>")

$(document).ready ->

  input = $('#msg_input')
  button = $('#send_button')
  input_chat_id = $('#chat_id')
  input_user_id = $('#user_id')
  input_msg = input.attr('value')

  button.click ->
    button.attr('disabled', 'disabled')
    button.text('Posting...')
    publication = client.publish '/chat',
      message: input.attr('value') 
      created_at: new Date()
    publication.callback ->
      input.attr('value', '')
      button.removeAttr('disabled')
      button.text('Post')
    publication.errback ->
      button.removeAttr('disabled')
      button.text('Try again')

# in case anyone wants to play with the inspector.
window.client = client
