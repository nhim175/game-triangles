extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

var $$ = Dom7;

var Util = (function() {
  function Util() {

  }

  Util.cloneCanvas = function(oldCanvas) {
    var newCanvas = document.createElement('canvas');
    var context = newCanvas.getContext('2d');
    newCanvas.width = oldCanvas.width;
    newCanvas.height = oldCanvas.height;
    context.drawImage(oldCanvas, 0, 0);
    return newCanvas;
  }

  return Util;

})();

var Sound = (function(){
  var slideSound = new Audio('../sounds/slide.mp3');

  function Sound() {

  }

  Sound.slide = function() {
    slideSound.play();
  }

  return Sound;
})();

var Level = (function() {

  var levels = [
    {id: 1, rows: 2, cols: 1, slices_per_cell: 2, cell_size: 75, variance: 0.75, x_colors: 'YlGnBu', y_colors: 'match_x'},
    {id: 2, rows: 2, cols: 1, slices_per_cell: 3, cell_size: 75, variance: 0.75, x_colors: 'YlOrRd', y_colors: 'match_x'},
    {id: 3, rows: 2, cols: 1, slices_per_cell: 4, cell_size: 75, variance: 0.75, x_colors: 'GnBu', y_colors: 'match_x'},
    {id: 4, rows: 3, cols: 1, slices_per_cell: 3, cell_size: 75, variance: 0.75, x_colors: 'YlOrBr', y_colors: 'match_x'},
    {id: 5, rows: 3, cols: 1, slices_per_cell: 4, cell_size: 75, variance: 0.75, x_colors: 'Purples', y_colors: 'match_x'},
    {id: 6, rows: 3, cols: 1, slices_per_cell: 5, cell_size: 75, variance: 0.75, x_colors: 'Blues', y_colors: 'match_x'},
    {id: 7, rows: 4, cols: 1, slices_per_cell: 3, cell_size: 75, variance: 0.75, x_colors: 'Oranges', y_colors: 'match_x'},
    {id: 8, rows: 4, cols: 1, slices_per_cell: 4, cell_size: 75, variance: 0.75, x_colors: 'Reds', y_colors: 'match_x'},
    {id: 9, rows: 4, cols: 1, slices_per_cell: 5, cell_size: 75, variance: 0.75, x_colors: 'Spectral', y_colors: 'match_x'},
    {id: 10},
    {id: 11},
    {id: 12},
    {id: 13},
    {id: 14},
    {id: 15},
    {id: 16},
    {id: 17},
    {id: 18},
    {id: 19},
    {id: 20}
  ];

  var currentLevel = levels[0];

  function Level() {

  }

  Level.getCurrentLevel = function() { 
    return currentLevel; 
  }

  Level.setCurrentLevel = function(level) {
    currentLevel = level;
  }

  Level.getNextLevel = function() {
    return Level.findById(this.getCurrentLevel().id + 1);
  }

  Level.findById = function(id) {
    return _.findWhere(levels, {
      id: parseInt(id)
    });
  }

  Level.all = function() {
    return levels;
  }

  return Level;

})();

var Exclamation = (function() {
  var positiveExclamation = ["Awesome", "Amazing", "Amazeballs", "Bam", "Bingo", "Boom", "Booyah", "Cha-ching", "Congrats", "Cowabunga", "Fantastic", "Great", "Hot diggety", "Hooray", "Nice", "Niiiiice", "Nice one", "Right on", "Well done", "w00t", "Woo", "Yay", "Yeah", "Yippee", "Zoinks", "Zowie"];

  function Exclamation() {

  }

  Exclamation.getPositiveExclamation = function() {
    return positiveExclamation[_.random(0, positiveExclamation.length - 1)] + "!!";
  }

  return Exclamation;

})();

var Cell = (function() {
  function Cell() {

  }

  return Cell;
});

var Slide = (function() {
  function Slide(config) {
    this.$$el = $$('<div/>').addClass('triangle-slice swiper-slide');
    if (config != null)
      this.$$canvas = $$(Trianglify(config).canvas());
    else
      throw "missing parameters for constructor"
    return this;
  }

  Slide.prototype.setTop = function(top) {
    this.$$canvas.css('top', top + 'px');
    return this;
  }

  Slide.prototype.html = function() {
    this.$$el.html('');
    return this.$$el.append(this.$$canvas);
  }

  return Slide;
})();

var ResultSlide = (function(superClass) {
  extend(ResultSlide, superClass);

  function ResultSlide(config) {
    ResultSlide.__super__.constructor.call(this, config);
    this.config = config;
    this.$$canvas.attr('data-result', true);
    return this;
  }

  ResultSlide.prototype.clone = function() {
    var clone = new ResultSlide(this.config);
    clone.$$canvas = $$(Util.cloneCanvas(this.$$canvas[0])).attr('data-result', true);
    return clone;
  }

  return ResultSlide;

})(Slide);  

var Game = (function() {

  function Game(level) {
    this.level = level;
    this.initLevel();
    this.delegate = null;
  }

  Game.prototype.initLevel = function() {
    var that = this;

    var defaults = {
      cell_size: 75,
      variance: 0.75,
      x_colors: 'random',
      y_colors: 'match_x',
      palette: Trianglify.colorbrewer,
      color_space: 'lab',
      color_function: false,
      stroke_width: 1.51,
      width: window.innerWidth,
      height: window.innerHeight,
      seed: null
    };
    var level = this.level;
    _.defaults(level, defaults);
    
    var result = new ResultSlide(_.pick(level, 'cell_size', 'variance', 'x_colors', 'y_colors', 'palette', 'color_space', 'color_function', 'stroke_width', 'width', 'height', 'seed'));

    $$('.slices').html('');
    for (var row = 0; row < level.rows; row++) {
      var $$row = $$('<div/>').addClass('triangle-row');

      for (var col = 0; col < level.cols; col++) {
        var $$cell = $$('<div/>').addClass('triangle-cell swiper-container');
        var $$slider_wrapper = $$('<div/>').addClass('swiper-wrapper');
        $$cell.append($$slider_wrapper);
        var slides = [];
        for (var slice = 0; slice < level.slices_per_cell - 1; slice++) {
          var slide = new Slide(defaults);
          slides.push(slide);
        }
        
        slides.push(result.clone());
        _.each(_.shuffle(slides), function(slide) {
          slide.setTop(-row/level.rows*window.innerHeight);
          $$slider_wrapper.append(slide.html());
        });
      }

      $$row.append($$cell);
      $$('.slices').append($$row);
    }

    var _class = 'cols-' + level.cols + ' rows-' + level.rows;
    $$('.slices').addClass(_class);

    function onSlideTransitionEnd(swiper) {
      Sound.slide();
      var win = true;
      $$('.swiper-slide-active').each(function() {
        if (!$$(this).find('canvas').attr('data-result')) win = false;
      });
      if (win) {
        $$('.game-over h1').text(Exclamation.getPositiveExclamation());
        $$('.game-over').addClass('show');
        setTimeout(function() {
          $$('.game-over').addClass('win');
        }, 100);
        $$('.back-btn').addClass('hide');
      }
    }

    Swiper('.swiper-container', {
      onTransitionEnd: onSlideTransitionEnd
    });


    $$('.back-btn').removeClass('hide').click(function() {
      that.delegate.navigateBack();
    });

    if ($$('.game-over').hasClass('show')) {
      $$('.game-over').once('webkitTransitionEnd transitionend', function(e) {
        $$(e.currentTarget).removeClass('show').removeClass('win').removeClass('lose').removeClass('zoom-out');
      });
      $$('.game-over').addClass('zoom-out');
    }
  }

  return Game;

})();

var App = (function() {
  function App() {
    var that = this;

    var myApp = new Framework7();
    var mainView = myApp.addView('.view-main', {
      dynamicNavbar: true,
      swipeBackPage: false
    });

    this.buildLevelList();

    myApp.onPageInit('play', function (page) {
      // Do something here for "about" page
      var level = Level.findById(page.query.id)

      if (level) {
        Level.setCurrentLevel(level);
        var game = new Game(level);
        game.delegate = that;
        game.initLevel();
      }

      //TODO: bind once, when the game over popup shows
      
      $$('.game-over .next-btn').on('click', function(e) {
        e.preventDefault();
        e.stopPropagation();

        var level = Level.getNextLevel();

        if (level) {
          Level.setCurrentLevel(level);
          var game = new Game(level);
          game.delegate = that;
          game.initLevel();
        } else {
          console.log('no more levels');
        }
      });
    });

    $$('.level-list .item').on('click', function() {
      mainView.router.load({
        url: 'play.html',
        query: {
          id: $$(this).attr('data-id')
        }
      });
    });
  }

  App.prototype.navigateBack = function() {
    mainView.router.back();
  }

  App.prototype.buildLevelList = function() {
    var levelItemTemplateSource = $$('#level-item-template').html();
    var levelItemTemplate = Template7.compile(levelItemTemplateSource);
    var renderedList = levelItemTemplate({ levels: Level.all() });
    $$('.level-list').html(renderedList);
  }

  return App;

})();

var app = new App();