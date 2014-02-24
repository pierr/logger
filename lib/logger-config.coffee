# Configuration class.
class Config
  max: 10
  outputs: ['console']
if typeof module is 'undefined' and typeof window isnt 'undefined'
  window.Config  = Config
else
  module.exports = Config