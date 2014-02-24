should = require('chai').should()
Message = require('../lib/message')
Logger = require('../lib/logger')

describe '#Logger ', ()->
  it '##logger should have a name', ()->
    logger = new Logger("test", "fatal", {outputs: []})
    logger.should.have.property('name').deep.equals('test')
  it '##log', ()->
    logger = new Logger("test", "fatal", {outputs: []})
    logger.log('warn', 'papa');
    logger.messages.should.have.length.of(2)
    logger.warn('^pierre')
    logger.messages.should.have.length.of(3)
    logger.error("papa");
    logger.messages.should.have.length.of(4)
    logger.debug("papa");
    logger.messages.should.have.length.of(5)
  it "## parseOutputs", ()->
    logger = new Logger("test", "fatal", {outputs: []})
    logger.outputs.should.be.an('Array').with.length.of(0)
    logger = new Logger("test", "fatal", {outputs: ['server']})
    logger.outputs.should.be.an('Array').with.length.of(1)
  it "##clear", ()->
    logger = new Logger("test", "fatal", {outputs: []})
    logger.messages.should.have.length.of(1)
    logger.clear() 
    logger.messages.should.have.length.of(0)
    