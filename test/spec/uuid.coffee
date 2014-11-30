'use strict'

describe 'jQuery.uuid', ->
  it 'should be formatted "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"', ->
    for i in [0...1000]
      (expect $.uuid()).toMatch /^\w{8}-\w{4}-4\w{3}-[89ab]\w{3}-\w{12}$/
