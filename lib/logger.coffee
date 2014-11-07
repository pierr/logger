levels = require('./levels')
Message = require('./message')

# Logger class
module.exports = class Logger
  constructor: (@name = "noName", @level = "info", @options = {})->
    # The default output is the console.
    @outputs = @options.outputs or ['console']
    #Usefull to save the current state outputs.
    @is = {}
    # Messages stack.
    @messages = []
    # Parse all the outputs available
    @parseOutputs()
    # Notify that the logger has started.
    @log('info', "The logger has started.")
    
  # Log a message with its associated level.
  log:(level, message, context)->
    # Log the message if the level exists and the level value superior or equal to the "authorized" level value.
    if levels[level]? and levels[level].value >= levels[@level].value
      @save() if @messages.length > (@options.max || 9)
      message = new Message(level, message, context)
      console[level](message.toString(), context) if @is.console
      @messages.push message
  # Trace a message
  trace:(message, context)->
    @log('trace', message, context)
  # Warn a message
  warn:(message, context)->
    @log('warn', message, context)
  # Info a message
  info:(message, context)->
    @log('info', message, context)
  # debug a message
  debug:(message, context)->
    @log('debug', message, context)
  #error a message
  error:(message, context)->
    @log('error', message, context)
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