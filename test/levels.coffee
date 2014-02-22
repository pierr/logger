Levels = require('../lib/levels')
describe '#The levels should exists', ()->
  it 'Should not be null', ()->
    levels = new Levels()
    console.log 'Levels %j', levels.fatal
