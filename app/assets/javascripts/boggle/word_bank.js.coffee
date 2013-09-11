
window.Boggle ?= {}

class window.Boggle.WordBank
  constructor: (@words) ->
  lookup: (needle) ->
    retval = []
    for word in @words
      retval.push word if word.indexOf(needle) is 0
    retval


