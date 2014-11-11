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
    logger.output.should.be.an('object')
    logger = new Logger("test", "fatal", {outputs: ['console']})
    logger.output.should.be.an('object')
    logger.output.should.have.property('console')
  it "##clear", ()->
    logger = new Logger("test", "fatal", {outputs: []})
    logger.messages.should.have.length.of(1)
    logger.clear() 
    logger.messages.should.have.length.of(0)
  it "## save should be called every 10 add", ()->
    logger = new Logger("test", "fatal", {outputs: []})
    logger.clear()
    logger.warn("Message #{i}") for i in [1..10]
    logger.messages.should.have.length.of(10)
  it "## display should return all the messges", ()->
    logger = new Logger("test", "fatal", {outputs: []})
    logger.clear()
    logger.warn("Message #{i}") for i in [0..9]
    logger.display().should.be.an('Array').with.length.of(10)