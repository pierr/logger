should = require('chai').should()
Message = require('../lib/message')
describe '#Test on the message property', ()->
  msgTxt = "Watch out!"
  message = new Message('warn', msgTxt)
  it '## Should have all default properties', ()->
    message.should.have.property('level').that.deep.equals('warn')
    message.should.have.property('message').that.deep.equals(msgTxt)
    message.should.have.property('date')
  it '## The to string method should be functionnal', ()->
    message.toString().should.equal("Warn : #{msgTxt} at: #{message.date}")
  it '## The toJSON method should be functionnal', ()->
    message.toJSON().should.be.deep.equals({"level": "warn", "message": msgTxt, "label": message.toString(), "date": message.date })
     