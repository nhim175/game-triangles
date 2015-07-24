# Author: Thinh Pham
# Email: nhim175@gmail.com

class Exclamation
  
  positiveExclamation = ["Awesome", "Amazing", "Amazeballs", "Bam", "Bingo", "Boom", "Booyah", "Cha-ching", "Congrats", "Cowabunga", "Fantastic", "Great", "Hot diggety", "Hooray", "Nice", "Niiiiice", "Nice one", "Right on", "Well done", "w00t", "Woo", "Yay", "Yeah", "Yippee", "Zoinks", "Zowie"]
  negativeExclamation = ["Argh","Aww snap","Boo","Boo-hoo","Bummer","Crickey","Crud","Dagnabit","Dang","Darn","Drat","D’oh","Fiddlesticks","Geez","Golly","Heavens","Jeepers","Oh snap","Oops","Ouch","Phooey","Rats","Shoot","Shucks","Snap","Uh oh","Welp","Whoops","Whoopsie","Yikes","Yowza"]

  @getPositiveExclamation: -> positiveExclamation[_.random(0, positiveExclamation.length - 1)] + "!!"

  @getNegativeExclamation: -> negativeExclamation[_.random(0, negativeExclamation.length - 1)] + "!!"

module.exports = Exclamation