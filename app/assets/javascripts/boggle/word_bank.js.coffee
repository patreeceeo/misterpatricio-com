
window.Boggle ?= {}

class window.Boggle.WordBank
  constructor: (@words) ->
  lookup: (needle) ->
    retval = []
    for word in @words
      retval.push word if word.indexOf(needle) is 0
    retval
  has: (needle) ->
    for word in @lookup(needle)
      if word is needle
        return true
    false


