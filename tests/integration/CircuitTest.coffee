chai      = require 'chai'
sinon     = require 'sinon'
sinonChai = require 'sinon-chai'

chai.should()
chai.use sinonChai

noop = ->

Flux = require '../../src'
Flux.injectTestHelpers()

TEST = Flux.Constants.create [
  'ACTION1',
  'ACTION2',
  'ACTION3'
]

TestDispatcher = Flux.Dispatcher.create
  handleTestAction: (action) ->
    @dispatch
      source: 'TEST_ACTION'
      action: action

describe 'TestDispatcher#handleTestAction()', ->
  it 'should proxy TestDispatcher#dispatch()', ->
    spy = sinon.spy TestDispatcher, 'dispatch'
    TestDispatcher.handleTestAction {}
    spy.should.have.been.calledOnce
    spy.restore()

  it 'should run through TestStore#dispatcherIndex', ->
    spy = sinon.spy()

    TestStore = Flux.Store.create
      dispatcherIndex: TestDispatcher.register (payload) ->
        action = payload.action
        switch action.actionType
          when TEST.ACTION1 then spy()

    TestDispatcher.handleTestAction
      actionType: TEST.ACTION1

    spy.should.have.been.calledOnce
