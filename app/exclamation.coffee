# Author: Thinh Pham
# Email: nhim175@gmail.com

class Exclamation
  
  positiveExclamation = ["Awesome", "Amazing", "Amazeballs", "Bam", "Bingo", "Boom", "Booyah", "Cha-ching", "Congrats", "Cowabunga", "Fantastic", "Great", "Hot diggety", "Hooray", "Nice", "Niiiiice", "Nice one", "Right on", "Well done", "w00t", "Woo", "Yay", "Yeah", "Yippee", "Zoinks", "Zowie"]

  @getPositiveExclamation: -> positiveExclamation[_.random(0, positiveExclamation.length - 1)] + "!!"

module.exports = Exclamation