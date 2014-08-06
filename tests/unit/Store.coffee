chai      = require 'chai'
sinon     = require 'sinon'
sinonChai = require 'sinon-chai'

chai.should()
chai.use sinonChai

noop = ->

Flux = require '../../src'
Flux.injectTestHelpers()

describe 'Flux.Store', ->
  it 'should inherit from the EventEmitter prototype', ->
    EventEmitter = require('events').EventEmitter
    for own prop, key of EventEmitter.prototype
      Flux.Store.hasOwnProperty(prop).should.be.true

  describe '#create()', ->
    it 'should require prototype params', ->
      Flux.Store.create.should.throw()

    it 'should return the merged store prototype', ->
      MyStore = Flux.Store.create noop: noop
      MyStore.noop.should.equal noop

  describe '#addChangeListener()', ->
    it 'should require a callback method', ->
      MyStore = Flux.Store.create {}
      MyStore.addChangeListener.should.throw()

    it 'should register a callback for the store\'s event emitter', ->
      spy = sinon.spy()
      MyStore = Flux.Store.create {}
      MyStore.addChangeListener spy
      MyStore.__.getListeners()[0].should.equal spy

  describe '#removeChangeListener()', ->
  describe '#emitChange()', ->
  describe '#dispatchIndex', ->
