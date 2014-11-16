InterfaceApender = require './interface'
###
 Interface for the Appender with all the methods to implement in order ot be an Interface.
###
module.exports = class ConsoleAppender extends InterfaceApender
  ###
    Log the message given as argument.
  ###
  log: (message) ->
    console.log('log called')
    super(message)
    @clear if @checkClear()
    @messages.push(message)
    console[message.level](message.toString(), message.context)
  checkClear: ->
    return if @messages.length > @config.maxLength
  ###
    Clear all the messages.
  ###
  clear: ->
    @save()
    @messages.length = 0
  ###
    Save the messages into the appender.
  ###
  save:()->
   ###
    Save the messages into the appender.
  ###
  display:->
    throw new Error("The save interface is not implemented.")