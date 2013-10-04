
window.Boggle ?= {}

class Boggle.WordFinder
  constructor: (config) ->
    @board = config.play_board
    @bank = config.word_bank
    @pathsForPrefix = {}
    @prefixesForSquare = {}

  isPrefix: (string) ->
    @bank.lookup(string).length > 0

  isWord: (string) ->
    @bank.has string

  onlyPathsThru: (squareID) ->
    of: (paths) ->
      for path in paths
        path if sid for sid in path when sid is squareID

  findWords: ->
    retval = []
    for y in [0..@board.height]
      for x in [0..@board.width]
        centerSquareID = "#{x},#{y}"
        @withEachAdjacentSquare (square, x2, y2) ->
          squareID = "#{x2},#{y2}"
          for prefix in @prefixesForSquare[centerSquareID]
            paths = @onlyPathsThru(centerSquareID).of(@pathsForPrefix[prefix]) or [centerSquareID]
            prefix += square.value()
            if @isWord prefix
              retval.push prefix
            if @isPrefix prefix
              @prefixesForSquare[squareID].push prefix
              for path in paths
                path.push squareID

  withEachAdjacentSquare: (x, y, fn) ->
    for dy in [-1, 0, 1]
      for dx in [-1, 0, 1] when dy isnt 0 and dx isnt 0
        fn(@board.square(x+dx, y+dy), x+dx, y+dy)




                



        

    
    

