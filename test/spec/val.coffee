'use strict'

describe 'jQuery(<input type="text" nbs-data-type="number"/>).val', ->
  it 'can get the value as number', ->
    $el = $ '<input type="text" nbs-data-type="number" value="5"/>'
    (expect $el.val()).toBe 5

  it 'should get 0 when the value is empty', ->
    $el = $ '<input type="text" nbs-data-type="number"/>'
    (expect $el.val()).toBe 0

  it 'should get NaN when the value is text', ->
    $el = $ '<input type="text" nbs-data-type="number" value="foo"/>'
    (expect isNaN $el.val()).toBe true

  it 'can set a number', ->
    $el = $ '<input type="text" nbs-data-type="number"/>'
    (expect $el.val(5).val()).toBe 5
    (expect $el.val('7').val()).toBe 7

  it 'cannot set a text', ->
    $el = $ '<input type="text" nbs-data-type="number"/>'
    (expect $el.val('foo').nbs('data-type', 'text').val()).toBe 'NaN'

describe 'jQuery(<select nbs-data-type="number"/>).val', ->
  it 'can get the value as number', ->
    $el = $ '''
      <select nbs-data-type="number">
        <option selected value="71">
      </select>
    '''
    (expect $el.val()).toBe 71

  it 'should get null when it have no option tags', ->
    $el = $ '<select nbs-data-type="number"/>'
    (expect $el.val()).toBe null

describe 'jQuery(<select multiple nbs-data-type="number"/>).val', ->
  it 'can get the number\'s array', ->
    $el = $ '''
      <select multiple nbs-data-type="number">
        <option selected value="2"/>
        <option selected value="abc"/>
      </select>
    '''
    val = $el.val()
    (expect val[0]).toBe 2
    (expect isNaN val[1]).toBe true
