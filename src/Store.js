'use strict';

var invariant     = require('react/lib/invariant');
var merge         = require('react/lib/merge');
var EventEmitter  = require('events').EventEmitter;

var Store = merge(EventEmitter.prototype, {
  create: function(prototype) {
    invariant(
      'object' === typeof prototype,
      'Expecting a prototype [Object] parameter, received `%s`',
      typeof prototype
    );

    return merge(Store, prototype);
  },

  addChangeListener: function(callback) {
    invariant(
      'function' === typeof callback,
      'Expecting a callback [Function] parameter, received `%s`',
      typeof callback
    );

  }
});

module.exports = Store;
