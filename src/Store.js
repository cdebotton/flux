'use strict';

var invariant     = require('react/lib/invariant');
var merge         = require('react/lib/merge');
var EventEmitter  = require('events').EventEmitter;

var CHANGE_EVENT = 'change';

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

    this.on(CHANGE_EVENT, callback);
  },

  removeChangeListener: function(callback) {
    invariant(
      'function' === typeof callback,
      'Expecting a callback [Function] parameter, received `%s`',
      typeof callback
    );

    this.removeListener(CHANGE_EVENT, callback);
  },

  emitChange: function() {
    this.emit(CHANGE_EVENT);
  }
});

Store.injectTestHelpers = function() {
  Store = merge(Store, {
    __: {
      flush: function() {
        Store.removeAllListeners()
      }
    }
  });
};

module.exports = Store;
