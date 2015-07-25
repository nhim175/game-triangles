# Author: Thinh Pham
# Email: nhim175@gmail.com

$$ = Dom7

class Slide

  constructor: (config) ->
    @$$el = $$('<div/>').addClass('triangle-slice swiper-slide')
    if config?
      @$$canvas = $$(Trianglify(config).canvas())
    else
      throw "missing parameters for constructor"
    @

  setTop: (top) ->
    @$$canvas.css('top', top + 'px')
    @

  setLeft: (left) ->
    @$$canvas.css('left', left + 'px')
    @    

  html: ->
    @$$el.html('')
    @$$el.append @$$canvas

module.exports = Slide