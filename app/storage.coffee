# Author: Thinh Pham
# Email: nhim175@gmail.com

class Storage
  _cache = {}

  @get: (key) ->
    unless _cache[key]
      _cache[key] = JSON.parse(localStorage[key] or 'null')
    _cache[key]

  @set: (key, value) ->
    _cache[key] = value

  @sync: (key) ->
    unless key
      for key, value of _cache
        if _cache.hasOwnProperty key
          localStorage[key] = JSON.stringify _cache[key]
    else
      if _cache.hasOwnProperty key
        localStorage[key] = JSON.stringify _cache[key]

module.exports = Storage