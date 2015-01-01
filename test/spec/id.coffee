'use strict'

describe 'jQuery.id', ->
  it 'can generate ID number', ->
    for i in [3, 5]
      $.id i
    for i in [1, 2, 4, 6, 7, 8, 9, 10]
      (expect $.id()).toBe i

    for i in [2, 5, 8]
      $.id i, remove: true
    for i in [2, 5, 8, 11, 12, 13]
      (expect $.id()).toBe i
