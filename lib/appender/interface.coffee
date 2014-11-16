Message = require '../message'
###
 Interface for the Appender with all the methods to implement in order ot be an Interface.
###
module.exports = class AppenderInterface
  constructor:(@config = {})->
    @messages = []
  ###
    @param level   - string - Level of the message to log (shoul be in levels.coffee)
    @param message - string - String message associated with the log.
    @param context - object - Object containing the context to log.
  ###
  log: (message) ->
    if(!message instanceof Message)
      throw new Error("The message should be a Message object")
  checkClear: ->
    return if messages.length > @config.maxLength
  clear: ->
    @save()
    @messages.length = 0
  ###
    Save the messages into the appender.
  ###
  save:()->
    throw new Error("The save interface is not implemented.")
   ###
    Save the messages into the appender.
  ###
  display:->
    throw new Error("The save interface is not implemented.")