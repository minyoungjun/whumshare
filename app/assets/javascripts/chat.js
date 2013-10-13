(function() {
  var client;

  client = new Faye.Client('/faye');

  client.subscribe('/chat', function(payload) {
    var time;
    time = moment(payload.created_at).format('D/M/YYYY H:mm:ss');
    return $('#chat_box').append("<li>" +"!!"+ payload.user_id+"!!"+ time + " : " + payload.message + "</li>");
  });

  $(document).ready(function() {
    var button, input, input_chat_id, input_msg, input_user_id;
    input = $('#msg_input');
    button = $('#send_button');
    input_chat_id = $('#chat_id');
    input_user_id = $('#user_id');
    input_msg = input.attr('value');
    return button.click(function() {
      var publication;
      button.attr('disabled', 'disabled');
      button.text('Posting...');
      publication = client.publish('/chat', {
        message: input.attr('value'),
        chat_id: input_chat_id.attr('value'),
        user_id: input_user_id.attr('value'),
        created_at: new Date()
      });
      publication.callback(function() {
        input.attr('value', '');
        button.removeAttr('disabled');
        return button.text('Post');
      });
      return publication.errback(function() {
        button.removeAttr('disabled');
        return button.text('Try again');
      });
    });
  });

  window.client = client;

}).call(this);

