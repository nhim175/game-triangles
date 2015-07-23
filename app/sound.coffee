# Author: Thinh Pham
# Email: nhim175@gmail.com 

class Sound

  slideSound = new Audio('./sounds/slide.mp3')

  @slide: () ->
    slideSound.play()

module.exports = Sound