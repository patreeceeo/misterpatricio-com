
window.Boggle ?= {}

class Boggle.PlayBoard
  letters = for c in [0...26]
    String.fromCharCode 97 + c
  constructor: (options) ->
    @width = options?.board?[0].length or options?.width or 5
    @height = options?.board?.length or options?.height or 5
    @frequency_table =
      e: 12.02
      t: 9.10
      a: 8.12
      o: 7.68
      i: 7.31
      n: 6.95
      s: 6.28
      r: 6.02
      h: 5.92
      d: 4.32
      l: 3.98
      u: 2.88
      c: 2.71
      m: 2.61
      f: 2.30
      y: 2.11
      w: 2.09
      g: 2.03
      p: 1.82
      b: 1.49
      v: 1.11
      k: 0.69
      x: 0.17
      q: 0.11
      j: 0.10
      z: 0.07
    @board = options?.board or
    for y in [0...@height]
      for x in [0...@width]
        @_random_letter()
  _random_letter: ->
    dart = Math.random() * 100
    total = old_total = 0
    for letter, frequency of @frequency_table
      total += frequency
      if old_total < dart < total
        return letter
      old_total = total
  square: (x, y) ->
    isAdjacentTo: (x2, y2) =>
      0 <= x <= @width and 0 <= y <= @height and
        0 <= x2 <= @width and 0 <= y2 <= @height and
        Math.abs(x - x2) <= 1 and Math.abs(y - y2) <= 1
    value: (val) => @value(x, y, val)
  value: (x, y, val) ->
    if val?
      @board[y]?[x] = val
    else
      @board[y]?[x]
  values: ->
    _.compact _.flatten(@value(x, y) for x in [0..@width] for y in [0..@height])
  toString: ->
    lines =
    for y in [0..@height]
      line =
      for x in [0..@width]
        @board[y]?[x]
      line.join('')
    lines.join('\n')
        



