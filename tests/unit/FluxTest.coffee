chai      = require 'chai'
sinon     = require 'sinon'
sinonChai = require 'sinon-chai'

chai.should()
chai.use sinonChai

noop = ->

Flux = require '../../src'
Flux.injectTestHelpers()

describe 'Flux', ->
  it 'should be an object', ->
    Flux.should.be.an 'object'

  it 'should have a Dispatcher property', ->
    Flux.Dispatcher.should.be.ok

  it 'should have a Store property', ->
    Flux.Store.should.be.ok
