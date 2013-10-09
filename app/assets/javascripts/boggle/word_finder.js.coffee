
window.Boggle ?= {}

reverse = (array) ->
  _.extend([], array).reverse()

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

  _getPaths: (
    squareID,
    prefix,
    paths = @pathsForPrefix[prefix]
  ) ->
    retval = (_.filter paths,
      (path) ->
        path[path.length-1] == squareID
    )
    if retval.length is 0
      [
        [squareID]
      ]
    else
      retval

  _buildPaths: (squareID, prefix, newSquareID) ->
    paths = @_getPaths(squareID, prefix)
    for path in paths
      path.push newSquareID

    if not @pathsForPrefix[prefix]?
      @pathsForPrefix[prefix] = paths
    else for path in paths
      if not _.contains(@pathsForPrefix[prefix], path)
        @pathsForPrefix[prefix].push path

  getPaths: (prefix) ->
    @pathsForPrefix[prefix] or []

  find: ->
    isAnswer = {}
    isPrefix = {}
    visited = {}
    findAt = (x, y, dx, dy) =>
      centerSquareID = "#{x},#{y}"
      guess = @board.value(x, y)
      if @isPrefix guess
        @getPrefixes(centerSquareID).push guess
      @withEachAdjacentSquare x, y, (value, x2, y2) =>
        squareID = "#{x2},#{y2}"
        return if visited[squareID]
        visited[squareID] = true
        for prefix in @getPrefixes centerSquareID
          guess = "#{prefix}#{value}"
          if not isAnswer[guess]?
            isAnswer[guess] = @isWord guess
          if isPrefix[guess] or @isPrefix guess
            isPrefix[guess] = true
            @getPrefixes(squareID).push guess
            # @_buildPaths(centerSquareID, prefix, squareID)
        null
      null
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
          visited = {}
          findAt(x, y)
      for y in direction[1]
        for x in direction[0]
          visited = {}
          findAt(x, y)
    for word, value of isAnswer when value
      word

  withEachAdjacentSquare: (x, y, fn) ->
    for dy in [-1, 0, 1]
      for dx in [-1, 0, 1] when not (dy is 0 and dx is 0) and
          0 <= x + dx < @board.width and
          0 <= y + dy < @board.height
        fn(@board.value(x+dx, y+dy), x+dx, y+dy)





                



        

    
    

