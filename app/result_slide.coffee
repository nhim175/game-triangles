# Author: Thinh Pham
# Email: nhim175@gmail.com

Slide = require './slide'
Util = require './util'

$$ = Dom7

class ResultSlide extends Slide

  constructor: (config) ->
    super(config)
    @config = config
    @$$canvas.attr('data-result', true)
    @

  clone: ->
    clone = new ResultSlide(@config)
    clone.$$canvas = $$(Util.cloneCanvas(@$$canvas[0])).attr('data-result', true)
    clone

module.exports = ResultSlide