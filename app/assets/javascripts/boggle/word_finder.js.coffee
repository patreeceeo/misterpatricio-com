
window.Boggle ?= {}

class Boggle.WordFinder
  constructor: (config) ->
    @board = config.play_board
    @bank = config.word_bank
    @_byCoords = {}

  _thru: (x, y, found, momentum) ->
    letter = @board.value(x, y)
    if @bank.lookup(letter)
      @prefixes(x, y).push letter
    for vector in momentum.vectors
      x2 = x - vector[0]
      y2 = y - vector[1]
      if @board.square(x, y).isAdjacentTo(x2, y2)
        for prefix in @prefixes(x2, y2)
          new_prefix = "#{prefix}#{letter}"
          if @bank.has new_prefix
            found[new_prefix] = true
          else if @bank.lookup(new_prefix).length > 0
            @prefixes(x, y).push new_prefix

  _going: (direction, found) ->
    width = @board.width
    height = @board.height
    down = [0...height]
    right = [0...width]
    left = [width-1..0]
    up = [height-1..0]
    if direction is 'right_then_down'
      momentum =
        vectors: [[0, 1], [1, 0]]
      for y in down
        for x in right
          @_thru(x, y, found, momentum)
    if direction is 'left_then_down'
      momentum =
        vectors: [[0, 1], [-1, 0]]
      for y in down
        for x in left
          @_thru(x, y, found, momentum)
    if direction is 'right_then_up'
      momentum =
        vectors: [[0, -1], [1, 0]]
      for y in up
        for x in right
          @_thru(x, y, found, momentum)
    if direction is 'left_then_up'
      momentum =
        vectors: [[0, -1], [-1, 0]]
      for y in up
        for x in left
          @_thru(x, y, found, momentum)
    if direction is 'down_then_right'
      momentum =
        vectors: [[0, 1], [1, 0]]
      for x in right
        for y in down
          @_thru(x, y, found, momentum)
    if direction is 'down_then_left'
      momentum =
        vectors: [[0, 1], [-1, 0]]
      for x in left
        for y in down
          @_thru(x, y, found, momentum)
    if direction is 'up_then_right'
      momentum =
        vectors: [[0, -1], [1, 0]]
      for x in right
        for y in up
          @_thru(x, y, found, momentum)
    if direction is 'up_then_left'
      momentum =
        vectors: [[0, -1], [-1, 0]]
      for x in left
        for y in up
          @_thru(x, y, found, momentum)
  find: ->
    found = {}
    @_going 'right_then_down', found
    @_going 'left_then_down',  found
    @_going 'right_then_up',   found
    @_going 'left_then_up',    found
    @_going 'down_then_right', found
    @_going 'down_then_left',  found
    @_going 'up_then_right',   found
    @_going 'up_then_left',    found

    for word of found
      word
  prefixes: (x, y)->
    @_byCoords[[x, y]] ?= {}
    @_byCoords[[x, y]].prefixes ?= []
                



        

    
    

