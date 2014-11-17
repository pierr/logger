###
  Dependencies.
###
levels               = require('./levels')
Message              = require('./message')
Appender = {
  console   : require "./appender/console"
  interface : require "./appender/interface"
  localStorage: require "./appender/localStorage"
  server : require "./appender/server"
}
document = require "./util/document"

# Logger class
module.exports = class Logger
  constructor: (@name = "noName", @level = "info", @options = {})->
    # The default output is the console.
    @options.outputs  =  @options.outputs or ['console']
    #Usefull to save the current state outputs.
    @is = {}
    # Messages stack.
    @messages = []
    # Parse all the outputs available
    @el = options.el || document.createElement(@options.tagName or 'ul')
    @options.el = @el
    @initializeOutputs()
    # Notify that the logger has started.
    @display()
    @log('info', "The logger has started.")
    if document?
      document.body.appendChild(@el) if document? and document.body?
  # Log a message with its associated level.
  log:(level, message, context)->
    # Log the message if the level exists and the level value superior or equal to the "authorized" level value.
    if levels[level]? and levels[level].value >= levels[@level].value
      #console.log("logger log called level : #{level} level of level #{JSON.stringify(levels[level])} currentLevel: #{JSON.stringify(levels[@level])}")
      #@save() if @messages.length > (@options.max || 9)
      message = new Message(level, message, context)
      @messages.push message
      @executeForOutputs "log", message
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
  ###
   @description Execute an action foreach output
   @param actionName -  Name of the action to execute.
  ###
  executeForOutputs:(actionName, argument)->
    return if typeof actionName isnt "string"
    for output of @outputs
      @outputs[output][actionName](argument) if @outputs[output][actionName]?
  # Parse all outputs which are availables.
  initializeOutputs:()->
    @outputs = @outputs or {}
    for outputName in @options.outputs
      @outputs[outputName] = new Appender[outputName](@options)
  # Clear all the messages in the current stack.
  clear: ->
    @messages.length = 0
    @executeForOutputs "clear"
  # Print all the messages on the different output
  display: ->
    message.toString() for message in @messages
    @executeForOutputs "display", @el
    return @messages
  #Save all the messages in the stack into the server if defined or with the file api if defined.
  save: ->
    executeForOutputs "clear"