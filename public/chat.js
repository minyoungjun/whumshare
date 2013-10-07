(function() {
  var client;

  client = new Faye.Client('/faye');

  client.subscribe('/chat', function(payload) {
    var time;
    time = moment(payload.created_at).format('D/M/YYYY H:mm:ss');
    return $('#chat').append("<li>" + time + " : " + payload.message + "</li>");
  });

  $(document).ready(function() {
    var button, input;
    input = $('input');
    button = $('button');
    return button.click(function() {
      var publication;
      button.attr('disabled', 'disabled');
      button.text('Posting...');
      publication = client.publish('/chat', {
        message: input.attr('value'),
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
