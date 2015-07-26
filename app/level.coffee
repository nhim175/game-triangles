# Author: Thinh Pham
# Email: nhim175@gmail.com

Storage = require './storage'

class Level
  kStorageLevels = 'levels'

  defaultLevels = [
    {id:1,rows:2,cols:1,slices_per_cell:2,cell_size:75,variance:0.75,x_colors:'YlGnBu',y_colors:'match_x',unlocked:true,result:[2,2],time:10},
    {id:2,rows:2,cols:1,slices_per_cell:3,cell_size:75,variance:0.75,x_colors:'YlOrRd',y_colors:'match_x',result:[2,3],time:10},
    {id:3,rows:2,cols:1,slices_per_cell:4,cell_size:75,variance:0.75,x_colors:'GnBu',y_colors:'match_x',result:[1,4],time:10},
    {id:4,rows:3,cols:1,slices_per_cell:3,cell_size:75,variance:0.75,x_colors:'YlOrBr',y_colors:'match_x',result:[1,3,2],time:20},
    {id:5,rows:3,cols:1,slices_per_cell:4,cell_size:75,variance:0.75,x_colors:'Purples',y_colors:'match_x',result:[3,2,4],time:20},
    {id:6,rows:3,cols:1,slices_per_cell:5,cell_size:75,variance:0.75,x_colors:'Blues',y_colors:'match_x',result:[2,3,5],time:20},
    {id:7,rows:4,cols:1,slices_per_cell:3,cell_size:75,variance:0.75,x_colors:'Oranges',y_colors:'match_x',result:[2,2,3,3],time:20},
    {id:8,rows:4,cols:1,slices_per_cell:4,cell_size:75,variance:0.75,x_colors:'Reds',y_colors:'match_x',result:[2,3,3,4],time:20},
    {id:9,rows:4,cols:1,slices_per_cell:5,cell_size:75,variance:0.75,x_colors:'Spectral',y_colors:'match_x',result:[5,4,5,3],time:20},
    {id:10,rows:3,cols:2,slices_per_cell:3,cell_size:75,variance:0.75,x_colors:'PuRd',y_colors:'match_x',result:[1,2,3,3,2,1],time:20},
    {id:11,rows:3,cols:2,slices_per_cell:4,cell_size:75,variance:0.75,x_colors:'PRGn',y_colors:'match_x',result:[4,3,4,3,2,2],time:20},
    {id:12,rows:3,cols:2,slices_per_cell:5,cell_size:75,variance:0.75,x_colors:'PuOr',y_colors:'match_x',result:[3,5,4,2,5,2],time:20},
    {id:13,rows:3,cols:3,slices_per_cell:6,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"YlOrRd",result:[6,5,4,5,5,4,6,4,4],time:27},
    {id:14,rows:3,cols:3,slices_per_cell:6,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"PuOr",result:[2,5,2,5,6,5,6,2,2],time:27},
    {id:15,rows:3,cols:3,slices_per_cell:6,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"GnBu",result:[3,2,4,6,2,4,2,4,2],time:27},
    {id:16,rows:3,cols:3,slices_per_cell:6,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"YlOrBr",result:[6,5,5,5,6,4,5,4,6],time:27},
    {id:17,rows:3,cols:3,slices_per_cell:6,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"PRGn",result:[4,4,6,6,5,5,2,6,3],time:27},
    {id:18,rows:3,cols:3,slices_per_cell:6,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"Purples",result:[2,2,2,2,3,2,5,3,6],time:27},
    {id:19,rows:3,cols:3,slices_per_cell:6,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"Blues",result:[6,3,2,4,6,3,4,6,4],time:27},
    {id:20,rows:3,cols:3,slices_per_cell:6,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"Oranges",result:[3,4,2,3,6,4,3,2,5],time:27},
    {id:21,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"Reds",result:[2,3,3,6,7,3,2,4,7,5,6,5],time:42},
    {id:22,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"Spectral",result:[7,3,3,2,6,2,3,6,3,6,5,3],time:42},
    {id:23,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlGnBu",y_colors:"PuRd",result:[2,7,5,7,3,6,6,3,3,3,7,4],time:42},
    {id:24,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"PuOr",result:[6,6,6,4,4,3,6,6,3,5,2,7],time:42},
    {id:25,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"GnBu",result:[4,4,3,4,7,6,7,6,4,3,7,5],time:42},
    {id:26,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"YlOrBr",result:[7,5,6,3,4,7,2,3,3,7,6,4],time:42},
    {id:27,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"PRGn",result:[7,3,3,5,5,2,7,3,3,2,6,4],time:42},
    {id:28,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"Purples",result:[7,6,7,6,2,7,2,3,6,7,5,6],time:42},
    {id:29,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"Blues",result:[5,7,2,5,2,3,7,7,4,6,3,6],time:42},
    {id:30,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"Oranges",result:[6,2,2,5,2,7,2,2,4,6,3,6],time:42},
    {id:31,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"Reds",result:[7,5,3,2,7,2,7,3,3,6,2,7],time:42},
    {id:32,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"Spectral",result:[2,3,2,7,4,5,6,5,5,5,4,5],time:42},
    {id:33,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrRd",y_colors:"PuRd",result:[3,6,3,7,6,2,4,3,7,4,6,4],time:42},
    {id:34,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"GnBu",result:[3,3,4,3,7,2,3,2,6,4,5,3],time:42},
    {id:35,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"YlOrBr",result:[3,7,2,3,3,5,3,5,3,7,2,2],time:42},
    {id:36,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"PRGn",result:[5,5,2,2,5,2,5,5,4,4,3,6],time:42},
    {id:37,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"Purples",result:[5,2,5,2,7,3,6,2,7,2,7,2],time:42},
    {id:38,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"Blues",result:[5,5,5,6,5,2,7,2,2,4,4,5],time:42},
    {id:39,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"Oranges",result:[7,2,6,2,7,2,3,6,3,5,4,2],time:42},
    {id:40,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"Reds",result:[6,4,2,7,3,3,2,3,3,3,4,4],time:42},
    {id:41,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"Spectral",result:[6,4,3,5,5,5,6,3,7,3,3,5],time:42},
    {id:42,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"PuOr",y_colors:"PuRd",result:[7,4,2,5,4,3,4,4,2,7,6,7],time:42},
    {id:43,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"GnBu",y_colors:"YlOrBr",result:[4,5,7,2,6,7,6,7,5,2,5,4],time:42},
    {id:44,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"GnBu",y_colors:"PRGn",result:[6,6,4,3,5,7,4,3,7,4,2,5],time:42},
    {id:45,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"GnBu",y_colors:"Purples",result:[2,6,5,6,6,5,4,4,4,6,6,6],time:42},
    {id:46,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"GnBu",y_colors:"Blues",result:[4,5,2,4,6,2,4,7,4,4,5,6],time:42},
    {id:47,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"GnBu",y_colors:"Oranges",result:[3,2,5,5,6,2,6,4,3,2,3,4],time:42},
    {id:48,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"GnBu",y_colors:"Reds",result:[7,5,5,4,3,2,7,5,6,5,4,6],time:42},
    {id:49,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"GnBu",y_colors:"Spectral",result:[6,5,2,7,2,5,7,6,4,3,7,4],time:42},
    {id:50,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"GnBu",y_colors:"PuRd",result:[5,2,3,2,6,6,4,3,3,7,5,2],time:42},
    {id:51,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrBr",y_colors:"PRGn",result:[3,5,2,7,2,3,4,2,3,4,4,5],time:42},
    {id:52,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrBr",y_colors:"Purples",result:[6,7,6,5,6,2,6,4,7,2,3,6],time:42},
    {id:53,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrBr",y_colors:"Blues",result:[3,5,7,6,2,5,7,3,6,4,4,4],time:42},
    {id:54,rows:4,cols:3,slices_per_cell:7,cell_size:75,variance:0.75,x_colors:"YlOrBr",y_colors:"Oranges",result:[4,6,4,3,2,3,3,6,6,2,5,5],time:42},
    {id:55,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"YlOrBr",y_colors:"Reds",result:[2,3,6,3,7,5,2,4,4,5,5,5,4,7,7],time:60},
    {id:56,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"YlOrBr",y_colors:"Spectral",result:[6,4,8,7,3,7,7,5,6,5,3,6,7,2,3],time:60},
    {id:57,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"YlOrBr",y_colors:"PuRd",result:[2,2,3,3,4,8,2,8,7,4,4,5,8,2,2],time:60},
    {id:58,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"PRGn",y_colors:"Purples",result:[8,7,2,3,5,4,4,3,5,6,6,5,3,3,6],time:60},
    {id:59,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"PRGn",y_colors:"Blues",result:[8,2,3,3,7,6,4,5,5,3,8,3,2,5,4],time:60},
    {id:60,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"PRGn",y_colors:"Oranges",result:[2,2,2,2,6,8,8,5,7,8,2,2,4,6,4],time:60},
    {id:61,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"PRGn",y_colors:"Reds",result:[5,5,3,5,2,3,8,4,5,6,8,5,3,5,4],time:60},
    {id:62,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"PRGn",y_colors:"Spectral",result:[5,3,6,7,7,6,4,2,5,7,4,4,6,3,6],time:60},
    {id:63,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"PRGn",y_colors:"PuRd",result:[3,5,6,4,4,3,8,6,7,6,3,6,7,2,4],time:60},
    {id:64,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Purples",y_colors:"Blues",result:[8,5,3,4,6,2,5,7,4,6,4,6,7,8,6],time:60},
    {id:65,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Purples",y_colors:"Oranges",result:[2,2,4,6,5,6,5,8,5,2,7,8,5,4,8],time:60},
    {id:66,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Purples",y_colors:"Reds",result:[7,4,4,3,2,3,6,5,3,3,7,8,3,5,6],time:60},
    {id:67,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Purples",y_colors:"Spectral",result:[5,8,8,5,6,8,3,3,4,4,2,5,2,5,5],time:60},
    {id:68,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Purples",y_colors:"PuRd",result:[6,6,7,6,4,7,3,8,5,3,7,4,8,3,4],time:60},
    {id:69,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Blues",y_colors:"Oranges",result:[8,8,3,3,5,3,6,2,7,8,2,7,4,8,2],time:60},
    {id:70,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Blues",y_colors:"Reds",result:[7,2,4,2,5,5,2,2,8,5,6,4,8,3,4],time:60},
    {id:71,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Blues",y_colors:"Spectral",result:[4,2,6,2,7,2,4,6,7,7,4,7,5,7,3],time:60},
    {id:72,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Blues",y_colors:"PuRd",result:[4,4,6,6,2,6,3,7,2,2,5,5,3,6,6],time:60},
    {id:73,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Oranges",y_colors:"Reds",result:[5,2,5,5,5,4,6,6,8,7,3,2,3,4,7],time:60},
    {id:74,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Oranges",y_colors:"Spectral",result:[2,6,8,5,4,2,6,2,5,4,7,8,7,7,4],time:60},
    {id:75,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Oranges",y_colors:"PuRd",result:[8,2,3,2,4,5,3,4,3,4,2,7,2,2,7],time:60},
    {id:76,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Reds",y_colors:"Spectral",result:[3,6,4,2,4,8,3,8,7,7,4,4,2,7,7],time:60},
    {id:77,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Reds",y_colors:"PuRd",result:[2,7,3,4,8,8,6,5,2,3,3,2,4,5,5],time:60},
    {id:78,rows:5,cols:3,slices_per_cell:8,cell_size:75,variance:0.75,x_colors:"Spectral",y_colors:"PuRd",result:[7,8,6,7,5,4,5,7,4,2,7,3,4,3,2],time:60}
  ]

  levels = if Storage.get(kStorageLevels) then Storage.get(kStorageLevels) else defaultLevels

  currentLevel = levels[0]

  @getCurrentLevel: -> currentLevel

  @setCurrentLevel: (level) -> currentLevel = level

  @getNextLevel: -> @findById(@getCurrentLevel().id + 1)

  @passCurrentLevel: -> currentLevel.passed = true

  @unlockNextLevel: -> if nextLevel = @getNextLevel() then nextLevel.unlocked = true

  @findById: (id) -> _.findWhere levels, id: parseInt(id)

  @sync: -> 
    Storage.set kStorageLevels, levels
    Storage.sync()

  @all: -> levels

module.exports = Level