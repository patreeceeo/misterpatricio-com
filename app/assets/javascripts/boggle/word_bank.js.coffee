window.Boggle ?= {}

isEmpty = (obj) ->
  for k of obj
    return false
  true
    
class window.Boggle.WordBank
  constructor: (@words) ->
    @map = {}
    i = 0
    for word in @words
      map = @map
      for j, letter of word
        map = map[letter] ?= {indexes: []}
        map.indexes.push(i)
      i++
  slow_lookup: (needle) ->
    retval = []
    for word in @words
      retval.push word if word.indexOf(needle) is 0
    retval
  lookup: (needle) ->
    map = @map
    for i, letter of needle
      map = map[letter]
      if not map?
        return []
    for i in map.indexes
      @words[i]
  has: (needle) ->
    for word in @lookup(needle)
      if word is needle
        return true
    false


