
window.Boggle ?= {}

class Boggle.PlayBoard
  letters = for c in [0...26]
    String.fromCharCode 97 + c
  constructor: (options) ->
    @width = options?.board?[0].length or options?.width or 5
    @height = options?.board?.length or options?.height or 5
    @board = options?.board or
    for y in [0...@height]
      for x in [0...@width]
        letters[Math.floor Math.random() * letters.length]
  square: (x, y) ->
    isAdjacentTo: (x2, y2) =>
      0 <= x <= @width and 0 <= y <= @height and
        0 <= x2 <= @width and 0 <= y2 <= @height and
        Math.abs(x - x2) <= 1 and Math.abs(y - y2) <= 1
    value: @value(x, y)
  value: (x, y) ->
    @board[y]?[x]
  toString: ->
    lines = 
    for y in [0..@height]
      line = 
      for x in [0..@width]
        @board[y]?[x]
      line.join('')
    lines.join('\n')
        



