window.Boggle ?= {}

class Boggle.WordHider
  constructor: (config) ->
    @board = config.play_board
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

  random_letter: ->
    dart = Math.random() * 100
    total = old_total = 0
    for letter, frequency of @frequency_table
      total += frequency
      if old_total < dart < total
        return letter
      old_total = total
      
  hide: ->
    for x in [0...@board.width]
      for y in [0...@board.height]
        @board.value(x, y, @random_letter())

  _random: (max) ->
    Math.floor(Math.random() * max)
  hide_stupidly: ->
    for word in @words
      x = @_random @board.width
      y = @_random @board.height
      last_direction = null
      for letter in word
        console.debug 'hiding',letter,'at',x,y
        @board.value(x, y, letter)
        directions = [0, 1, 2, 3]
        if x is @board.width - 1
          delete directions[0]
        if y is @board.height - 1
          delete directions[1]
        if x is 0
          delete directions[2]
        if y is 0
          delete directions[3]
        delete directions[last_direction]
        last_direction = 
        direction = directions[@_random directions.length]

        if direction is 0
          x += 1
        if direction is 2
          x -= 1
        if direction is 1
          y += 1
        if direction is 3
          y -= 1
        
        if @board.value(x, y) in word
          console.debug 'oops'



      



