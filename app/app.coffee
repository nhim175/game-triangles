# Author: Thinh Pham
# Email: nhim175@gmail.com
Level = require './level'
Game = require './game'
Triangle = require './triangle'

$$ = Dom7

# TODO: set to false in production
window._debug = true

class App

  _mainView = null
  _app = null

  constructor: ->

    _app = new Framework7()
    _mainView = _app.addView '.view-main', 
      dynamicNavbar: true
      swipeBackPage: false

    @buildLevelList()

    _app.onPageInit 'play', @onPlayPageInit

  onLevelSelected: (event) =>
    event.preventDefault()
    id = $$(event.currentTarget).attr('data-id')
    if _debug || Level.findById(id).unlocked
      _app.showIndicator()
      setTimeout ->
        _mainView.router.load
          url: 'play.html'
          query:
            id: id
      , 0

  onPlayPageInit: (page) =>
    level = Level.findById(page.query.id)

    if level
      Level.setCurrentLevel(level)
      game = new Game(level)
      game.delegate = @
      game.initLevel()
      setTimeout ->
        _app.hideIndicator()
      , 0

  navigateBack: ->
    _mainView.router.back()

  buildLevelList: ->
    levelItemTemplateSource = $$('#level-item-template').html()
    levelItemTemplate = Template7.compile(levelItemTemplateSource)
    renderedList = levelItemTemplate
      levels: Level.all()
    $$('.level-list').html(renderedList)
    $$('.level-list .item').on 'click', @onLevelSelected
    $$('.level-list .level-passed').each ->
      id = parseInt $$(@).attr('data-id')
      level = Level.findById id
      $$(@).append $$(Triangle.getThumbForLevel(level))

module.exports = App