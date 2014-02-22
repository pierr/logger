if typeof module is 'undefined' and typeof window isnt 'undefined'
  Levels  = window.Levels
  Message = window.Message
else
  Levels = require('./Levels')
  Message = require('./message')

# Logger class
class Logger
  constructor: (@name = "noName", @level = "info", @options = {})->
    # The default output is the console.
    @outputs = @options.outputs or ['console']
    @log('info', "The logger has started.")
  #Usefull to save the current state outputs.
  @is = {}
  @levels = new Levels()
  # Messages stack.
  @messages:[]
  @log:(level, message)->
    # Log the message if the level exists and the level value superior or equal to the "authorized" level value.
    if @levels[level]? and @levels[level].value >= @levels[@level].value
      message = new Message(level, message)
      console.log(message.toString()) if @is.console
      @messages.push message
  @parseOutputs:()->
    for out in @outputs
      switch out
        when 'console' then @is.Console = true
        when 'localStorage' then @is.localStorage = true
        when 'file' then @is.file = true
        when 'server' then @is.server = true
  @clear:()->
    @messages.length = 0
  # Print all the messages on the different output
  @display:()->
    throw new Error("Not Yet Implemented")


  #Save all the messages in the stack into the server if defined or with the file api if defined.
  @save:()->
    throw new Error("Not Yet Implemented")


if typeof module is 'undefined' and typeof window isnt 'undefined'
  window.Logger  = Logger
else
  module.exports = Logger