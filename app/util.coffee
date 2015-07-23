# Author: Thinh Pham
# Email: nhim175@gmail.com

class Util 

  @cloneCanvas: (oldCanvas) -> 
    newCanvas = document.createElement('canvas')
    context = newCanvas.getContext('2d')
    newCanvas.width = oldCanvas.width
    newCanvas.height = oldCanvas.height
    context.drawImage(oldCanvas, 0, 0)
    newCanvas

module.exports = Util
