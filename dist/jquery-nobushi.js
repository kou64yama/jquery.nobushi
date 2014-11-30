
/*!
 * jQuery 野武士
 * https://github.com/kou64yama/jquery.nobushi
 *
 * Copyright 2014 Koji YAMADA and other contributors
 * Released under the MIT license.
 * https://raw.githubusercontent.com/kou64yama/jquery.nobushi/master/LICENSE
 */

(function() {
  'use strict';
  var factory;

  factory = function($) {
    var previousInit, previousVal;
    if ($ == null) {
      $ = jQuery;
    }
    previousInit = $.fn.init;
    previousVal = $.fn.val;

    /*
     * @param [Integer] length
     * @param [String] text
     * @param [Object] options
     * @return [String] justified text
     */
    $.pad = function(length, text, options) {
      var align, fill, next;
      next = function() {
        return $.pad(length - 1, text, options);
      };
      align = (options != null ? options.align : void 0) || 'right';
      fill = (options != null ? options.fill : void 0) || ' ';
      switch (false) {
        case !(length <= ("" + text).length):
          return "" + text;
        case align !== 'left':
          return "" + (next()) + fill;
        case align !== 'right':
          return "" + fill + (next());
        case align !== 'center':
          switch (length % 2) {
            case 0:
              return "" + fill + (next());
            case 1:
              return "" + (next()) + fill;
          }
      }
    };

    /*
     * @return [Integer] 32 bit random number
     */
    $.rand32 = function() {
      return (Math.random() * 0x100000000) >>> 0;
    };

    /*
     * @return [String] UUID (version 4)
     */
    $.uuid = function() {
      var _pad;
      _pad = function(num) {
        return $.pad(8, (num >>> 0).toString(16), {
          fill: '0'
        });
      };
      return [_pad($.rand32()), _pad($.rand32() & 0xffff0fff | 0x00004000), _pad($.rand32() & 0xbfffffff | 0x80000000), _pad($.rand32())].join('').replace(/^(.{8})(.{4})(.{4})(.{4})(.{12})$/, '$1-$2-$3-$4-$5');
    };

    /*
     * @overload nbs(name, value)
     *   @param [String] name
     *   @param [any] value
     *   @return [jQuery]
     *
     * @overload nbs(name)
     *   @param [String] name
     *   @return [String]
     */
    $.fn.nbs = function(name, value) {
      switch (arguments.length) {
        case 0:
          return this;
        case 1:
          return (this.attr("nbs-" + name)) || (this.attr("data-nbs-" + name));
        default:
          return this.attr("nbs-" + name, value);
      }
    };

    /*
     * @overload val()
     *   @return [String, Number]
     *
     * @overload val(value)
     *   @param [String, Number] value
     *   @return [jQuery]
     */
    return $.fn.val = function(value) {
      var i, val, _i, _ref, _results;
      switch (false) {
        case (this.nbs('data-type')) === 'number':
          return previousVal.apply(this, arguments);
        case this.length !== 0:
          return previousVal.apply(this, arguments);
        case !(1 <= arguments.length):
          return this.each((function(_this) {
            return function() {
              return previousVal.call(_this, Number(value));
            };
          })(this));
        case (val = previousVal.call(this)) !== null:
          return val;
        case !$.isArray(val):
          _results = [];
          for (i = _i = 0, _ref = val.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
            _results.push(Number(val[i]));
          }
          return _results;
          break;
        default:
          return Number(val);
      }
    };
  };

  if (typeof define === 'function' && define.amd) {
    define(['jquery'], factory);
  } else {
    factory(jQuery);
  }

}).call(this);
