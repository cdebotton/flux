chai      = require 'chai'
sinon     = require 'sinon'
sinonChai = require 'sinon-chai'

chai.should()
chai.use sinonChai

noop = ->

Flux = require '../../src'

Flux.injectTestHelpers()

describe 'Flux.Constants', ->
  describe '#create()', ->
    it 'should require an [Array] parameter', ->
      Flux.Constants.create.should.throw()

    it 'should return an [Object]', ->
      CONSTANTS = Flux.Constants.create []
      CONSTANTS.should.be.an 'object'

    it 'should convert the [Array] to a set of keys and values equal to each array item', ->
      CONSTANTS = Flux.Constants.create ['FOO', 'BAZ', 'BAR']
      CONSTANTS.FOO.should.equal 'FOO'
      CONSTANTS.BAZ.should.equal 'BAZ'
      CONSTANTS.BAR.should.equal 'BAR'
