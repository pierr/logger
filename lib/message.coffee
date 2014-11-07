levels = require './levels'
# Message class
module.exports = class Message
  # Constructor of the messgae class.
  constructor:(@level, @message, @context)->
    @date = new Date()
  # Stringify the message.
  toString:()->
    return "#{levels[@level].name} : #{@message} at: #{@date}"
  # Convert the message into a json object
  toJSON:()->
    return {"level": @level, "message" : @message, "label": @toString(), "date": @date , "context": @context}