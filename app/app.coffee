# Author: Thinh Pham
# Email: nhim175@gmail.com
Level = require './level'
Game = require './game'
Triangle = require './triangle'

$$ = Dom7

# TODO: set to false in production
window._debug = true

class App

  mainView = null

  constructor: ->

    myApp = new Framework7()
    mainView = myApp.addView '.view-main', 
      dynamicNavbar: true
      swipeBackPage: false

    @buildLevelList()

    myApp.onPageInit 'play', @onPlayPageInit

  onLevelSelected: (event) =>
    id = $$(event.currentTarget).attr('data-id')
    if _debug || Level.findById(id).unlocked
      mainView.router.load
        url: 'play.html'
        query:
          id: id

  onPlayPageInit: (page) =>
      
    level = Level.findById(page.query.id)

    if level
      Level.setCurrentLevel(level)
      game = new Game(level)
      game.delegate = @
      game.initLevel()

  navigateBack: ->
    mainView.router.back()

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