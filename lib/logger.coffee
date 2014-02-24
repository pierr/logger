if typeof module is 'undefined' and typeof window isnt 'undefined'
  Levels  = window.Levels
  Message = window.Message
else
  Levels = require('./levels')
  Message = require('./message')

# Logger class
class Logger
  constructor: (@name = "noName", @level = "info", @options = {})->
    # The default output is the console.
    @outputs = @options.outputs or ['console']
    #Usefull to save the current state outputs.
    @is = {}
    # Messages stack.
    @messages = []
    #Save into the prootype the levels.
    @levels = new Levels()
    # Parse all the outputs available
    @parseOutputs()
    # Notify that the logger has started.
    @log('info', "The logger has started.")
    
  # Log a message with its associated level.
  log:(level, message)->
    # Log the message if the level exists and the level value superior or equal to the "authorized" level value.
    if @levels[level]? and @levels[level].value >= @levels[@level].value
      @save() if @messages.length > (@options.max || 9)
      message = new Message(level, message)
      console[level](message.toString()) if @is.console
      @messages.push message
  # Trace a message
  trace:(message)->
    @log('trace', message)
  # Warn a message
  warn:(message)->
    @log('warn', message)
  # Info a message
  info:(message)->
    @log('info', message)
  # debug a message
  debug:(message)->
    @log('debug', message)
  #error a message
  error:(message)->
    @log('error', message)
  # Parse all outputs which are availables.
  parseOutputs:()->
    @is = @is or {}
    for out in @outputs
      switch out
        when 'console' then @is.console = true
        when 'localStorage' then @is.localStorage = ( window? and window.localStorage?)
        when 'file' then @is.file = true
        when 'server' then @is.server = true
  # Clear all the messages in the current stack.
  clear:()->
    @messages.length = 0
  # Print all the messages on the different output
  display:()->
    message.toString() for message in @messages

  #Save all the messages in the stack into the server if defined or with the file api if defined.
  save:()->
    localStorage.setItem(@name, JSON.stringify(@messages)) if @is.localStorage
    @clear()

if typeof module is 'undefined' and typeof window isnt 'undefined'
  window.Logger  = Logger
else
  module.exports = Logger