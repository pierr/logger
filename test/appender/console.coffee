should = require('chai').should()
Message = require('../../lib/message')
Logger = require('../../lib/logger')

describe.only '# Console appender', ()->
  it '## warn test', ()->
    logger = new Logger("test", "warn", {outputs: ['console']})
    logger.warn("papap", {papa: "singe"})