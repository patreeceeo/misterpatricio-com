
window.Boggle ?= {}

class Boggle.PlayBoard
  letters = for c in [0...26]
    String.fromCharCode 65 + c
  constructor: (options) ->
    @width = options?.width or 5
    @height = options?.height or 5
    @board =
      for y in [0...@height]
        for x in [0...@width]
          letters[Math.floor Math.random() * letters.length]
  square: (x, y) ->
    value = @board[y]?[x]
    isAdjacentTo: (x2, y2) =>
      0 <= x <= @width and 0 <= y <= @height and
        0 <= x2 <= @width and 0 <= y2 <= @height and
        Math.abs(x - x2) <= 1 and Math.abs(y - y2) <= 1
    value: value



