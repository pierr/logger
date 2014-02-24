# Log levels.
class Levels
  fatal: {name: "Fatal", value:0}
  error: {name: "Error", value:1}
  warn : {name: "Warn", value:2}
  info : {name: "Info", value:3}
  debug: {name: "Debug", value:4}
  trace: {name: "Trace", value:5}

if typeof module is 'undefined' and typeof window isnt 'undefined'
  window.Levels  = Levels
else
  module.exports = Levels