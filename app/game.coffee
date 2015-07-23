# Author: Thinh Pham
# Email: nhim175@gmail.com
ResultSlide = require './result_slide'
Slide = require './slide'
Sound = require './sound'
Exclamation = require './exclamation'

$$ = Dom7

class Game

  constructor: (level) ->
    @level = level
    @initLevel()
    @delegate = null

  initLevel: ->
    defaults = 
      cell_size: 75
      variance: 0.75
      x_colors: 'random'
      y_colors: 'match_x'
      palette: Trianglify.colorbrewer
      color_space: 'lab'
      color_function: false
      stroke_width: 1.51
      width: window.innerWidth
      height: window.innerHeight
      seed: null

    level = @level

    _.defaults(level, defaults)
    
    result = new ResultSlide(_.pick(level, 'cell_size', 'variance', 'x_colors', 'y_colors', 'palette', 'color_space', 'color_function', 'stroke_width', 'width', 'height', 'seed'))

    $$('.slices').html('')
    for row in [0..level.rows-1]
      
      $$row = $$('<div/>').addClass('triangle-row')

      for col in [0..level.cols-1]
        
        $$cell = $$('<div/>').addClass('triangle-cell swiper-container')
        $$slider_wrapper = $$('<div/>').addClass('swiper-wrapper')
        $$cell.append($$slider_wrapper)
        slides = []
        for slice in [0..level.slices_per_cell-2]
          slide = new Slide(defaults)
          slides.push(slide)
        
        slides.push result.clone()
        for slide in _.shuffle(slides)
          slide.setTop(-row/level.rows*window.innerHeight)
          $$slider_wrapper.append slide.html()

      $$row.append($$cell)
      $$('.slices').append($$row)

    _class = "cols-#{ level.cols } rows-#{level.rows}"
    $$('.slices').addClass(_class)

    onSlideTransitionEnd = (swiper) ->
      Sound.slide()
      win = true
      $$('.swiper-slide-active').each ->
        win = false if !$$(@).find('canvas').attr('data-result') 

      if win
        $$('.game-over h1').text Exclamation.getPositiveExclamation()
        $$('.game-over').addClass('show')
        setTimeout ->
          $$('.game-over').addClass('win')
        , 100
        $$('.back-btn').addClass('hide')

    Swiper '.swiper-container', 
      onTransitionEnd: onSlideTransitionEnd


    $$('.back-btn').removeClass('hide').click =>
      @delegate.navigateBack()

    if $$('.game-over').hasClass('show')
      $$('.game-over').once 'webkitTransitionEnd transitionend', (e) ->
        $$(e.currentTarget).removeClass('show').removeClass('win').removeClass('lose').removeClass('zoom-out')
      $$('.game-over').addClass('zoom-out')

module.exports = Game