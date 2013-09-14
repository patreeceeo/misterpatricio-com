
window.Boggle ?= {}

directions = [
  [-1, 0]
  [0, -1]
]

class Boggle.WordFinder
  constructor: (config) ->
    @board = config.play_board
    @bank = config.word_bank
    @_byCoords = {}

  find: ->
    found = []
    for y in [0...@board.height]
      for x in [0...@board.width]
        letter = @board.value(x, y)
        if @bank.lookup(letter)
          @prefixes(x, y).push letter
        for dir in directions
          x2 = x + dir[0]
          y2 = y + dir[1]
          if @board.square(x, y).isAdjacentTo(x2, y2)
            for prefix in @prefixes(x2, y2)
              new_prefix = "#{prefix}#{letter}"
              if @bank.has new_prefix
                found.push new_prefix
              else if @bank.lookup new_prefix
                @prefixes(x, y).push new_prefix
    found
  prefixes: (x, y)->
    @_byCoords[[x, y]] ?= {}
    @_byCoords[[x, y]].prefixes ?= []
                



        

    
    

