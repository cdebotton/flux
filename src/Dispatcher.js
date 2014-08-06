'use strict';

var invariant = require('react/lib/invariant');
var merge     = require('react/lib/merge');
var Promise   = require('es6-promise').Promise;

var _callbacks = [];
var _promises = [];

var Dispatcher = function() {};

Dispatcher.prototype = merge(Dispatcher.prototype, {
  register: function(callback) {
    invariant(
      'function' === typeof callback,
      'Dispatcher#register() requires param1 to be a callback [Function], received `%s`',
      typeof callback
    );

    _callbacks.push(callback);
    return _callbacks.length;
  },

  dispatch: function(payload) {
    var resolves = [];
    var rejects = [];

    invariant(
      'object' === typeof payload,
      'Dispatcher#dispatch() requires param1 to be a payload [Object], received `%s`',
      typeof payload
    );

    _promises = _callbacks.map(function(_, i) {
      return new Promise(function(resolve, reject) {
        resolves[i] = resolve;
        rejects[i] = reject;
      });
    });

    _callbacks.forEach(function(callback, i) {
      Promise.resolve(callback(payload)).then(function() {
        resolves[i](payload);
      }, function() {
        rejects[i](new Error('Dispatcher callback was unsuccessful'));
      });
    });

    _promises = [];
  },

  waitFor: function(promiseIndexes, callback) {

    invariant(
      Object.prototype.hasOwnProperty.call(promiseIndexes, 'length'),
      'First parameter must be an [Array] of promise indices to wait for, received `%s`',
      typeof promiseIndexes
    );

    invariant(
      'function' === typeof callback,
      'Second parameter must be a callback [Function], received `%s`',
      typeof callback
    );

    var selectedPromises = promiseIndexes.map(function(index) {
      return _promises[index];
    });

    Promise.all(selectedPromises).then(callback);
  }
});

Dispatcher.create = function(prototype) {
  invariant(
    'object' === typeof prototype,
    'Expecting an [Object] prototype parameter to create but got `%s`',
    typeof prototype
  );
  return merge(Dispatcher.prototype, prototype);
};

Dispatcher.injectTestHelpers = function() {
  Dispatcher.prototype = merge(Dispatcher.prototype, {
    __: {
      flush: function() {
        _callbacks = [];
        _promises = []
      },

      promises: function() {
        return _promises;
      },

      callbacks: function() {
        return _callbacks;
      }
    }
  });
}

module.exports = Dispatcher;
