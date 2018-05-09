App.posts_comments = App.cable.subscriptions.create "PostsCommentsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#posts_list').append(data)

  speak: (message) -> 
    @perform 'speak', message: message
