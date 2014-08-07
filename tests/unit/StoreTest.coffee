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
    beforeEach ->
      @store = Flux.Store.create {}
      @store.__.flush()

    it 'should require a callback method', ->
      @store.addChangeListener.should.throw()

    it 'should proxy the EventEmitter\'s #on() method.', ->
      spy = sinon.spy @store, 'on'
      @store.addChangeListener noop
      spy.should.have.been.calledOnce

  describe '#removeChangeListener()', ->
    beforeEach ->
      @store = Flux.Store.create {}
      @store.__.flush()

    it 'should require a callback method', ->
      @store.removeChangeListener.should.throw()

    it 'should proxy the EventEmitter\'s #on() method.', ->
      spy = sinon.spy @store, 'removeListener'
      @store.removeChangeListener noop
      spy.should.have.been.calledOnce

  describe '#emitChange()', ->
    beforeEach ->
      @store = Flux.Store.create {}
      @store.__.flush()

    it 'should call registered callbacks', ->
      spy = sinon.spy()
      @store.addChangeListener spy
      @store.emitChange()
      spy.should.have.been.calledOnce
