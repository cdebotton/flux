chai      = require 'chai'
sinon     = require 'sinon'
sinonChai = require 'sinon-chai'

chai.should()
chai.use sinonChai

noop = ->

Flux = require '../../src'

Flux.injectTestHelpers()

describe 'Flux.Dispatcher', ->
  describe '#create()', ->
    it 'should require a prototype to inherit', ->
      Flux.Dispatcher.create.should.throw()

    it 'should return the inherited prototype instance', ->
      MyDispatcher = Flux.Dispatcher.create {noop: noop}
      MyDispatcher.noop.should.equal noop

  describe '#register()', ->
    beforeEach ->
      @dispatcher = Flux.Dispatcher.create {noop:noop}
      @dispatcher.__.flush()

    it 'should require a callback param', ->
      @dispatcher.register.should.throw()

    it 'should return a #dispatcherIndex [Number]', ->
      indexA = @dispatcher.register noop
      indexA.should.be.a 'number'

    it 'should push registered callback into private _callbacks array.', ->
      @dispatcher.register noop
      @dispatcher.__.callbacks()[0].should.equal noop

    it 'should return the length of callbacks as a #dispatcherIndex', ->
      indexA = @dispatcher.register noop
      indexA.should.equal @dispatcher.__.callbacks().length
      indexB = @dispatcher.register noop
      indexB.should.equal @dispatcher.__.callbacks().length

  describe '#dispatch()', ->
    beforeEach ->
      @dispatcher = Flux.Dispatcher.create {noop:noop}
      @dispatcher.__.flush()

    it 'should require a payload object parameter', ->
      @dispatcher.dispatch.should.throw()

    it 'should call registered callbacks exactly one time each', ->
      spy = sinon.spy()
      spy2 = sinon.spy()
      @dispatcher.register spy
      @dispatcher.register spy2
      @dispatcher.dispatch {}
      spy.should.have.been.calledOn()
      spy2.should.have.been.calledOn()

  describe '#waitFor()', ->
    beforeEach ->
      @AppDispatcher = Flux.Dispatcher.create
        handleViewAction: (action) ->
          @dispatch
            source: 'VIEW_ACTION'
            action: action
      @AppDispatcher.__.flush()

    it 'should require an [Array] of promiseIndexes and a callback [Function]', ->
      @AppDispatcher.waitFor.should.throw()

    it 'should call selectedPromises', (done) ->
      spyA = sinon.spy()
      spyB = sinon.spy()
      indexA = @AppDispatcher.register spyA
      indexB = @AppDispatcher.register spyB
      @AppDispatcher.waitFor [indexA, indexB], ->
        spyA.should.have.been.calledOn()
        spyB.should.have.been.calledOn()
        done()
      @AppDispatcher.dispatch {}

