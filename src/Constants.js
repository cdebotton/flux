'use strict';

var invariant = require('react/lib/invariant');
var keyMirror = require('react/lib/keyMirror');

var Constants = {};

Constants.create = function(constants) {
  invariant(
    Object.hasOwnProperty.call(constants, 'length'),
    'Expecting an [Array] parameter, received a `%s`',
    typeof constants
  );

  return constants.reduce(function(memo, key) {
    memo[key] = key;
    return memo;
  }, {});
};

module.exports = Constants;
