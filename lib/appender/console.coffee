InterfaceApender = require './interface'
###
 Interface for the Appender with all the methods to implement in order ot be an Interface.
###
module.exports = class ConsoleAppender extends InterfaceApender
  log: (message) ->
    super()
    @checkClear()
    console[message.level](message.toString(), message.context)
  checkClear: ->
    return if messages.length > @config.maxLength
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