
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

  getPrefixes: (squareID) ->
    @prefixesForSquare[squareID] ?= []

  getPaths: (
    squareID,
    prefix,
    paths = @pathsForPrefix[prefix]
  ) ->
    (_.filter paths,
      (path) ->
        _.contains(path, squareID)
    ) or [
      [squareID]
    ]

  find: ->
    isAnswer = {}
    isPrefix = {}
    findAt = (x, y) =>
      centerSquareID = "#{x},#{y}"
      if @isPrefix @board.value(x, y)
        @getPrefixes(centerSquareID).push @board.value(x, y)
      @withEachAdjacentSquare x, y, (value, x2, y2) =>
        squareID = "#{x2},#{y2}"
        for prefix in @getPrefixes centerSquareID
          paths = @getPaths(centerSquareID, prefix)
          guess = "#{prefix}#{value}"
          if not isAnswer[guess]?
            isAnswer[guess] = @isWord guess
          if isPrefix[guess] or @isPrefix guess
            isPrefix[guess] = true
            @getPrefixes(squareID).push guess
            for path in paths
              path.push squareID
        null
    reverse = (array) ->
      _.extend([], array).reverse()
    ltr = [0...@board.width]
    rtl = reverse ltr
    ttb = [0...@board.height]
    btt = reverse ttb
    for direction in [
      [ltr, ttb]
      [ltr, btt]
      [rtl, ttb]
      [rtl, btt]
    ]
      for x in direction[0]
        for y in direction[1]
          findAt(x, y)
      for y in direction[1]
        for x in direction[0]
          findAt(x, y)
    for word, value of isAnswer when value
      word

  withEachAdjacentSquare: (x, y, fn) ->
    for dy in [-1, 0, 1]
      for dx in [-1, 0, 1] when not (dy is 0 and dx is 0) and
          0 <= x + dx < @board.width and
          0 <= y + dy < @board.height
        fn(@board.value(x+dx, y+dy), x+dx, y+dy)




                



        

    
    

