describe 'jQuery.seq', ->

  it 'can generate the sequence number', ->
    for i in [1...10]
      (expect $.seq()).toBe i

    $.seq 50

    for i in [51...100]
      (expect $.seq()).toBe i

    $.seq 70

    for i in [100...200]
      (expect $.seq()).toBe i
