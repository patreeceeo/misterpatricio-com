
window.Boggle ?= {}

Boggle.wordFinder = (cofig) ->
  board = config.play_board
  bank = config.word_bank

  directions = [
    [1,  0]
    [0,  1]
    [-1, 0]
    [0, -1]
  ]

  coord_to_word_map = {}
  words = []

  for y in [0...board.height]
    for x in [0...board.width]
      for dir in directions
        x2 = x + dir[0]
        y2 = y + dir[1]
        if board.square(x, y).isAdjacentTo(x2, y2)
          word_record = coord_to_word_map[[x2, y2]]

          if bank.lookup(board.square(x, y)).length > 0
            if not word_record?
              word_record = {word: prefix}
              words.push word_record
            word_record.word += board.square(x, y).value
            coord_to_word_map[[x, y]] = word_record

  for word in words
    word.word # word, yo


        

    
    

