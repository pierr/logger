#Load dependencies depending on the fact that we are in a commojs module or not.
if typeof module is 'undefined' and typeof window isnt 'undefined'
  Levels  = window.Levels
else
  Levels = require('./Levels')


# Message class
class Message
  # Constructor of the messgae class.
  constructor:(@level, @message)->
    @date = new Date()
  @levels = new Levels()
  # Stringify the message.
  @toString:()->
    return "#{@levels[@level]} : #{@message} at: #{@date}"
  # Convert the message into a json object
  @toJSON:()->
    return {"level": @level, "message" : @message, label: @toString(), "date": @date}

if typeof module is 'undefined' and typeof window isnt 'undefined'
  window.Message  = Message
else
  module.exports = Message