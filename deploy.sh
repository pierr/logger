#! /usr/local/bin/coffee
coffee --join main/browser/logger.js --compile lib/*.coffee
coffee --output main/amd/ --compile lib/*.coffee