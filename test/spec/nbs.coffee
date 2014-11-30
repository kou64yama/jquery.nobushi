'use strict'

describe 'jQuery(...).nbs', ->
  it 'can get an attribute value data-nbs-*', ->
    $el = $ '<div data-nbs-foo="bar"/>'
    (expect $el.nbs 'foo').toBe 'bar'

  it 'can get an attribute value nbs-*', ->
    $el = $ '<div nbs-foo="bar"/>'
    (expect $el.nbs 'foo').toBe 'bar'

  it 'should get an attribute value nbs-* than data-nbs-*', ->
    $el = $ '<div data-nbs-foo="fail" nbs-foo="bar"/>'
    (expect $el.nbs 'foo').toBe 'bar'

  it 'should return jQuery object when it was called as a setter', ->
    $el = $ '<div/>'
    (expect $el.nbs 'foo', 'bar').toBe $el

  it 'can set an attribute value nbs-*', ->
    $el = $ '<div/>'
    (expect ($el.nbs 'foo', 'bar').nbs 'foo').toBe 'bar'

  it 'should set an attribute value data-nbs-*', ->
    $el = $ '<div/>'
    (expect ($el.nbs 'foo', 'bar').attr 'data-nbs-foo').not.toBe 'bar'
