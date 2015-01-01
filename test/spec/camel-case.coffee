'use strict'

describe 'jQuery.camelCase()', ->
  it 'should convert "foo_bar" to "fooBar"', ->
    expect($.camelCase 'foo_bar').toBe 'fooBar'
  it 'should convert "foo-bar" to "fooBar"', ->
    expect($.camelCase 'foo-bar').toBe 'fooBar'
  it 'should convert "foo[-_]{2}bar" to "fooBar"', ->
    expect($.camelCase 'foo--bar').toBe 'fooBar'
    expect($.camelCase 'foo-_bar').toBe 'fooBar'
    expect($.camelCase 'foo_-bar').toBe 'fooBar'
    expect($.camelCase 'foo__bar').toBe 'fooBar'
