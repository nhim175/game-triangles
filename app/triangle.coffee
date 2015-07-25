# Author: Thinh Pham
# Email: nhim175@gmail.com
ResultSlide = require './result_slide'
Slide = require './slide'

class Triangle
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

  levelToOptions = (level) ->
    _.pick(level, 'cell_size', 'variance', 'x_colors', 'y_colors', 'palette', 'color_space', 'color_function', 'stroke_width', 'width', 'height', 'seed')

  @getResultForLevel: (level) ->
    _.defaults(level, defaults)
    new ResultSlide(levelToOptions(level))

  @getRandomSlide: ->
    new Slide(defaults)

  @getThumbForLevel: (level) ->
    options = levelToOptions(level)
    options.width = 100
    options.height = 100
    options.cell_size /= 3
    Trianglify(options).svg()

module.exports = Triangle