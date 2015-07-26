# Author: Thinh Pham
# Email: nhim175@gmail.com

Array.prototype.insert = (index) ->
  @splice.apply @, [index, 0].concat(Array.prototype.slice.call(arguments, 1))
  @

class Util 

  @cloneCanvas: (oldCanvas) -> 
    newCanvas = document.createElement('canvas')
    context = newCanvas.getContext('2d')
    newCanvas.width = oldCanvas.width
    newCanvas.height = oldCanvas.height
    context.drawImage(oldCanvas, 0, 0)
    newCanvas

module.exports = Util
