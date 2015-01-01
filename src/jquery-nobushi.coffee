###!
# jQuery 野武士
# https://github.com/kou64yama/jquery.nobushi
#
# Copyright 2014 Koji YAMADA and other contributors
# Released under the MIT license.
# https://raw.githubusercontent.com/kou64yama/jquery.nobushi/master/LICENSE
###

'use strict'

factory = ($ = jQuery) ->
  previousInit = $.fn.init
  previousVal = $.fn.val
  sequence = null
  assigned = {}
  id = 0


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
  # @param [String] text not camel case
  # @return [String] camel case
  ###
  $.camelCase = (text) ->
    text.toLowerCase().replace /[-_]+(.)/g, (match, group1) ->
      group1.toUpperCase()


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
  # @overload seq()
  #   @return [Number] sequence
  #
  # @overload seq(num)
  #   @param [Number] num
  #   @return [jQuery]
  ###
  $.seq = (num) -> switch
    when arguments.length is 0 then switch sequence
      when null then sequence = 1
      else ++sequence
    when sequence < num
      sequence = num
      @
    else sequence


  ###
  # @overload id()
  #   @return [Number] ID
  #
  # @overload id(num, options)
  #   @param [Number] num
  #   @param [Boolean] options.delete
  #   @return [jQuery]
  ###
  $.id = (num, {remove} = {}) -> switch
    when arguments.length is 0
      if assigned[++id]
        $.id()
      else
        assigned[id] = true
        id
    when remove
      delete assigned[num]
      id = num - 1 if num <= id
      @
    else
      assigned[num] = true
      @


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


if typeof define is 'function' and define.amd
  # AMD. Register as an anonymous module.
  define ['jquery'], factory
else
  # Browser globals
  factory jQuery
