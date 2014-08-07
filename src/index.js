'use strict';

var Flux = {};
Flux.Dispatcher = require('./Dispatcher');
Flux.Store      = require('./Store');
Flux.Constants  = require('./Constants');

Flux.injectTestHelpers = function() {
  this.Dispatcher.injectTestHelpers();
  this.Store.injectTestHelpers();
};

module.exports = Flux;
