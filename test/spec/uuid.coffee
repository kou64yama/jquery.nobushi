'use strict'

FORMAT = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/

describe 'jQuery.uuid', ->

  it 'should be formatted "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"', ->
    for i in [0...1000]
      (expect $.uuid()).toMatch FORMAT
