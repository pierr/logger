should = require('chai').should()
Levels = require('../lib/levels')
describe '#The levels should exists', ()->
  it 'Should not be null', ()->
    levels = new Levels()
    levels.should.have.property('fatal')
    #console.log 'Levels %j', levels.fatal
