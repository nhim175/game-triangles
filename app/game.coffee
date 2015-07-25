# Author: Thinh Pham
# Email: nhim175@gmail.com
ResultSlide = require './result_slide'
Slide = require './slide'
Sound = require './sound'
Exclamation = require './exclamation'
Level = require './level'
Triangle = require './triangle'

$$ = Dom7

class Game
  TIME_OUT = 3*1000
  isOver = false

  constructor: (level) ->
    @level = level
    @delegate = null
    @timer = new Tock
      countdown: true
      interval: 30
      callback: @onTimerTicked
      complete: @onTimerCompleted
    @initLevel()
    $$('.game-over .quit-btn').once 'click', => @delegate.navigateBack()

  onTimerTicked: =>
    $$('.time').css 'width', @timer.lap()/TIME_OUT*100 + '%'

  onTimerCompleted: =>
    @lose()

  onSlideTransitionEnd: (swiper) =>
    return if isOver
    Sound.slide()
    win = true
    $$('.swiper-slide-active').each ->
      win = false if !$$(@).find('canvas').attr('data-result') 

    @win() if win

  onNextLevelClicked: (e) =>
    e.preventDefault()
    e.stopPropagation()

    level = Level.getNextLevel()

    if level
      Level.setCurrentLevel(level)
      @level = level
      @initLevel()
    else
      console.log('no more levels')

  onBackBtnClicked: =>
    @timer.stop()
    @delegate.navigateBack()

  win: ->
    $$('.game-over h1').text Exclamation.getPositiveExclamation()
    $$('.game-over h2').text "You've got a new triangle"
    $$('.game-over').addClass('show')
    setTimeout ->
      $$('.game-over').addClass('win')
    , 100
    $$('.back-btn').addClass('hide')
    $$('.game-over .next-btn').once 'click', @onNextLevelClicked
    @timer.stop()
    Level.passCurrentLevel()
    Level.unlockNextLevel()
    @delegate.buildLevelList()

  lose: ->
    $$('.game-over h1').text Exclamation.getNegativeExclamation()
    $$('.game-over h2').text "Time's up"
    $$('.game-over').addClass('show')
    setTimeout ->
      $$('.game-over').addClass('lose')
    , 100
    $$('.back-btn').addClass('hide')
    $$('.game-over .play-again-btn').once 'click', => @initLevel()
    isOver = true

  initLevel: ->
    isOver = false
    level = @level
    
    result = Triangle.getResultForLevel(level)

    $$('.slices').html('')
    for row in [0..level.rows-1]
      
      $$row = $$('<div/>').addClass('triangle-row')

      for col in [0..level.cols-1]
        
        $$cell = $$('<div/>').addClass('triangle-cell swiper-container')
        $$slider_wrapper = $$('<div/>').addClass('swiper-wrapper')
        $$cell.append($$slider_wrapper)
        slides = []
        for slice in [0..level.slices_per_cell-2]
          slide = Triangle.getRandomSlide()
          slides.push(slide)
        
        slides.push result.clone()
        for slide in _.shuffle(slides)
          slide.setTop(-row/level.rows*window.innerHeight)
          $$slider_wrapper.append slide.html()

      $$row.append($$cell)
      $$('.slices').append($$row)

    _class = "cols-#{ level.cols } rows-#{level.rows}"
    $$('.slices').addClass(_class)

    @timer.start TIME_OUT  
    # bind events

    Swiper '.swiper-container', 
      onTransitionEnd: @onSlideTransitionEnd

    $$('.back-btn').removeClass('hide').click @onBackBtnClicked
      

    if $$('.game-over').hasClass('show')
      $$('.game-over').once 'webkitTransitionEnd transitionend', (e) ->
        $$(e.currentTarget).removeClass('show').removeClass('win').removeClass('lose').removeClass('zoom-out')
      $$('.game-over').addClass('zoom-out')

module.exports = Game