'use strict';

var Flux = {};
Flux.Dispatcher = require('./Dispatcher');
Flux.Store = require('./Store');

Flux.injectTestHelpers = function() {
  this.Dispatcher.injectTestHelpers();
};

module.exports = Flux;
