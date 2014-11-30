###!
# jQuery 野武士
# https://github.com/kou64yama/jquery.nobushi
#
# Copyright 2014 Koji YAMADA and other contributors
# Released under the MIT license.
# https://raw.githubusercontent.com/kou64yama/jquery.nobushi/master/LICENSE
###

((factory) ->
  'use strict'

  if typeof define is 'function' and define.amd
    # AMD. Register as an anonymous module.
    define ['jquery'], factory
  else
    # Browser globals
    factory jQuery
)(($) ->
  'use strict'

  previousInit = $.fn.init
  previousVal = $.fn.val


  ###
  # @param [Integer] length
  # @param [String] text
  # @param [Object] options
  # @return [String] justified text
  ###
  $.pad = (length, text, options) ->
    next = -> $.pad length - 1, text, options
    align = options?.align or 'right'
    fill = options?.fill or ' '

    switch
      when length <= "#{text}".length then "#{text}"
      when align is 'left' then "#{next()}#{fill}"
      when align is 'right' then "#{fill}#{next()}"
      when align is 'center' then switch length % 2
        when 0 then "#{fill}#{next()}"
        when 1 then "#{next()}#{fill}"


  ###
  # @return [Integer] 32 bit random number
  ###
  $.rand32 = ->
    (Math.random() * 0x100000000) >>> 0


  ###
  # @return [String] UUID (version 4)
  ###
  $.uuid = ->
    _pad = (num) -> $.pad 8, (num >>> 0).toString(16), fill: '0'
    [
      (_pad $.rand32()),
      (_pad $.rand32() & 0xffff0fff | 0x00004000),
      (_pad $.rand32() & 0xbfffffff | 0x80000000),
      (_pad $.rand32())
    ].join('').replace /^(.{8})(.{4})(.{4})(.{4})(.{12})$/, '$1-$2-$3-$4-$5'


  ###
  # @overload nbs(name, value)
  #   @param [String] name
  #   @param [any] value
  #   @return [jQuery]
  #
  # @overload nbs(name)
  #   @param [String] name
  #   @return [String]
  ###
  $.fn.nbs = (name, value) -> switch arguments.length
    when 0 then @
    when 1 then (@attr "nbs-#{name}") or (@attr "data-nbs-#{name}")
    else @attr "nbs-#{name}", value


  ###
  # @overload val()
  #   @return [String, Number]
  #
  # @overload val(value)
  #   @param [String, Number] value
  #   @return [jQuery]
  ###
  $.fn.val = (value) -> switch
    when (@nbs 'data-type') isnt 'number' then previousVal.apply @, arguments
    when @length is 0 then previousVal.apply @, arguments
    when 1 <= arguments.length then @each => previousVal.call @, Number value
    when (val = previousVal.call @) is null then val
    when $.isArray val then Number val[i] for i in [0...val.length]
    else Number val
)
