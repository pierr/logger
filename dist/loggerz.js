(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){

/*
  Publish Loggerz module into the this which is window in the browser case.
 */
(function() {
  return this.Loggerz = require('./logger');
})();



},{"./logger":7}],2:[function(require,module,exports){
var ConsoleAppender, InterfaceApender,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

InterfaceApender = require('./interface');


/*
 Interface for the Appender with all the methods to implement in order ot be an Interface.
 */

module.exports = ConsoleAppender = (function(_super) {
  __extends(ConsoleAppender, _super);

  function ConsoleAppender() {
    return ConsoleAppender.__super__.constructor.apply(this, arguments);
  }


  /*
    Log the message given as argument.
   */

  ConsoleAppender.prototype.log = function(message) {
    console.log('log called');
    ConsoleAppender.__super__.log.call(this, message);
    if (this.checkClear()) {
      this.clear;
    }
    this.messages.push(message);
    return console[message.level](message.toString(), message.context);
  };

  ConsoleAppender.prototype.checkClear = function() {
    if (this.messages.length > this.config.maxLength) {

    }
  };


  /*
    Clear all the messages.
   */

  ConsoleAppender.prototype.clear = function() {
    this.save();
    return this.messages.length = 0;
  };


  /*
    Save the messages into the appender.
   */

  ConsoleAppender.prototype.save = function() {

    /*
     Save the messages into the appender.
     */
  };

  ConsoleAppender.prototype.display = function() {
    throw new Error("The save interface is not implemented.");
  };

  return ConsoleAppender;

})(InterfaceApender);



},{"./interface":3}],3:[function(require,module,exports){
var AppenderInterface, Message;

Message = require('../message');


/*
 Interface for the Appender with all the methods to implement in order ot be an Interface.
 */

module.exports = AppenderInterface = (function() {
  function AppenderInterface(config) {
    this.config = config != null ? config : {};
    this.messages = [];
  }


  /*
    @param level   - string - Level of the message to log (shoul be in levels.coffee)
    @param message - string - String message associated with the log.
    @param context - object - Object containing the context to log.
   */

  AppenderInterface.prototype.log = function(message) {
    if (!message instanceof Message) {
      throw new Error("The message should be a Message object");
    }
  };

  AppenderInterface.prototype.checkClear = function() {
    if (messages.length > this.config.maxLength) {

    }
  };

  AppenderInterface.prototype.clear = function() {
    this.save();
    return this.messages.length = 0;
  };


  /*
    Save the messages into the appender.
   */

  AppenderInterface.prototype.save = function() {
    throw new Error("The save interface is not implemented.");
  };


  /*
   Save the messages into the appender.
   */

  return AppenderInterface;

})();

({
  display: function() {
    throw new Error("The save interface is not implemented.");
  }
});



},{"../message":8}],4:[function(require,module,exports){
module.exports = function() {};



},{}],5:[function(require,module,exports){
module.exports = function() {};



},{}],6:[function(require,module,exports){
module.exports = {
  fatal: {
    name: "Fatal",
    value: 0
  },
  error: {
    name: "Error",
    value: 1
  },
  warn: {
    name: "Warn",
    value: 2
  },
  info: {
    name: "Info",
    value: 3
  },
  debug: {
    name: "Debug",
    value: 4
  },
  trace: {
    name: "Trace",
    value: 5
  }
};



},{}],7:[function(require,module,exports){
var Appender, Logger, Message, interfaceAppender, levels, localStorageAppender, serverAppender;

levels = require('./levels');

Message = require('./message');

Appender = {
  console: require("./appender/console"),
  "interface": require("./appender/interface"),
  localStorage: require("./appender/localStorage"),
  server: require("./appender/server")
};

interfaceAppender = require("./appender/interface");

localStorageAppender = require("./appender/localStorage");

serverAppender = require("./appender/server");

module.exports = Logger = (function() {
  function Logger(name, level, options) {
    this.name = name != null ? name : "noName";
    this.level = level != null ? level : "info";
    this.options = options != null ? options : {};
    this.options.outputs = this.options.outputs || ['console'];
    this.is = {};
    this.messages = [];
    this.initializeOutputs();
    this.log('info', "The logger has started.");
  }

  Logger.prototype.log = function(level, message, context) {
    if ((levels[level] != null) && levels[level].value >= levels[this.level].value) {
      console.log("logger log called level : " + level + " level of level " + (JSON.stringify(levels[level])) + " currentLevel: " + (JSON.stringify(levels[this.level])));
      message = new Message(level, message, context);
      this.messages.push(message);
      return this.executeForOutputs("log", message);
    }
  };

  Logger.prototype.trace = function(message, context) {
    return this.log('trace', message, context);
  };

  Logger.prototype.warn = function(message, context) {
    return this.log('warn', message, context);
  };

  Logger.prototype.info = function(message, context) {
    return this.log('info', message, context);
  };

  Logger.prototype.debug = function(message, context) {
    return this.log('debug', message, context);
  };

  Logger.prototype.error = function(message, context) {
    return this.log('error', message, context);
  };


  /*
   @description Execute an action foreach output
   @param actionName -  Name of the action to execute.
   */

  Logger.prototype.executeForOutputs = function(actionName, argument) {
    var output, _results;
    if (typeof actionName !== "string") {
      return;
    }
    _results = [];
    for (output in this.outputs) {
      if (this.outputs[output][actionName] != null) {
        _results.push(this.outputs[output][actionName](argument));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  Logger.prototype.initializeOutputs = function() {
    var outputName, _i, _len, _ref, _results;
    this.outputs = this.outputs || {};
    _ref = this.options.outputs;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      outputName = _ref[_i];
      _results.push(this.outputs[outputName] = new Appender[outputName](this.options));
    }
    return _results;
  };

  Logger.prototype.clear = function() {
    this.messages.length = 0;
    return this.executeForOutputs("clear");
  };

  Logger.prototype.display = function() {
    var message, _i, _len, _ref;
    _ref = this.messages;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      message = _ref[_i];
      message.toString();
    }
    this.executeForOutputs("display");
    return this.messages;
  };

  Logger.prototype.save = function() {
    return executeForOutputs("clear");
  };

  return Logger;

})();



},{"./appender/console":2,"./appender/interface":3,"./appender/localStorage":4,"./appender/server":5,"./levels":6,"./message":8}],8:[function(require,module,exports){
var Message, levels;

levels = require('./levels');

module.exports = Message = (function() {
  function Message(level, message, context) {
    this.level = level;
    this.message = message;
    this.context = context;
    this.date = new Date();
  }

  Message.prototype.toString = function() {
    return "" + levels[this.level].name + " : " + this.message + " at: " + this.date;
  };

  Message.prototype.toJSON = function() {
    return {
      "level": this.level,
      "message": this.message,
      "label": this.toString(),
      "date": this.date,
      "context": this.context
    };
  };

  return Message;

})();



},{"./levels":6}]},{},[1]);
