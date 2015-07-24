# Author: Thinh Pham
# Email: nhim175@gmail.com
Level = require './level'
Game = require './game'

$$ = Dom7

class App

  mainView = null

  constructor: ->

    myApp = new Framework7()
    mainView = myApp.addView '.view-main', 
      dynamicNavbar: true
      swipeBackPage: false

    @buildLevelList()

    myApp.onPageInit 'play', @onPlayPageInit

    $$('.level-list .item').on 'click', @onLevelSelected

  onLevelSelected: (event) =>
    mainView.router.load
      url: 'play.html'
      query:
        id: $$(event.currentTarget).attr('data-id')

  onPlayPageInit: (page) =>
      
    level = Level.findById(page.query.id)

    if level
      Level.setCurrentLevel(level)
      game = new Game(level)
      game.delegate = @
      game.initLevel()

  onNextLevelClicked: (e) =>
    e.preventDefault()
    e.stopPropagation()

    level = Level.getNextLevel()

    if level
      Level.setCurrentLevel(level)
      game = new Game(level)
      game.delegate = @
      game.initLevel()
    else
      console.log('no more levels')

  navigateBack: ->
    mainView.router.back()

  buildLevelList: ->
    levelItemTemplateSource = $$('#level-item-template').html()
    levelItemTemplate = Template7.compile(levelItemTemplateSource)
    renderedList = levelItemTemplate
      levels: Level.all()
    $$('.level-list').html(renderedList)

module.exports = App