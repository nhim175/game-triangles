# Author: Thinh Pham
# Email: nhim175@gmail.com

class Level

  levels = [
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
  ]

  currentLevel = levels[0]

  @getCurrentLevel: () -> currentLevel

  @setCurrentLevel: (level) -> currentLevel = level

  @getNextLevel: () -> @findById(@getCurrentLevel().id + 1)

  @findById: (id) -> _.findWhere levels, id: parseInt(id)

  @all: () -> levels

module.exports = Level