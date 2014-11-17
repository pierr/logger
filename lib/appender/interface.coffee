Message = require '../message'
document = require "../util/document"

###
 Interface for the Appender with all the methods to implement in order ot be an Interface.
###
module.exports = class AppenderInterface
  constructor:(@config = {})->
    @el = @config.el or document.createElement('div')
    @messages = []
  ###
    @param {Message} - message - Message object message associated with the log.
   
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