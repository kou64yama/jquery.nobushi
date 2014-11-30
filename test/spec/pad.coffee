'use strict'

describe 'jQuery.pad', ->
  it 'can make the text right-justified', ->
    (expect $.pad 10, 'foo', align: 'right', fill: ' ').toBe '       foo'

  it 'can make the text left-justified', ->
    (expect $.pad 10, 'foo', align: 'left', fill: ' ').toBe 'foo       '

  it 'can make the text center-justified', ->
    (expect $.pad 10, 'foobar', align: 'center', fill: ' ').toBe '  foobar  '
    (expect $.pad 10, 'foo', align: 'center', fill: ' ').toBe '    foo   '
    (expect $.pad 9, 'foo', align: 'center', fill: ' ').toBe '   foo   '

  it 'can make the number right-justified and filled "0"', ->
    (expect $.pad 10, 15, fill: '0').toBe '0000000015'

  it 'should make the text left-justified when "align" was not specified', ->
    (expect $.pad 10, 'foo', fill: ' ').toBe '       foo'

  it 'should make the text filled space when "fill" was not specified', ->
    (expect $.pad 10, 'foo', align: 'right').toBe '       foo'
