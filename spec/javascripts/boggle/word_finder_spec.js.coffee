#= require boggle/word_bank
#= require boggle/play_board
#= require boggle/word_finder
#= require boggle/game_words
#= require moment

describe 'The Boggle Word Finder', ->
  finder = null
  word_bank = null
  play_board = null

  beforeEach ->
    word_bank = new Boggle.WordBank [
      'banana'
      'boogie'
      'noodle'
    ]
    play_board = new Boggle.PlayBoard
      # board: [
      #   ['b', 'o', 'o', 'g', 'i', 'e', ' ']
      #   [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      #   [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      #   [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      #   [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      #   [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      #   [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      #   [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      # ]
        
      board: [
        [' ', ' ', 'l', 'e', ' ', 'm', 'a']
        [' ', 'o', 'd', ' ', ' ', ' ', ' ']
        [' ', 'o', 'n', 'a', 'n', ' ', 'd']
        [' ', ' ', 'a', ' ', 'a', ' ', 'i']
        [' ', ' ', 's', ' ', 'b', 'o', ' ']
        ['e', ' ', ' ', ' ', ' ', 'o', 'g']
        [' ', 'l', ' ', ' ', ' ', 'e', 'i']
        [' ', ' ', 'd', 'o', 'o', 'n', ' ']
      ]
    finder = new Boggle.WordFinder
      play_board: play_board
      word_bank: word_bank

  it 'should find well hidden words and only one of each', ->
    # also it should not reuse squares in one word.', ->
    expect(finder.find()).toEqual [
      'boogie'
      'noodle'
      'banana'
    ]
  describe 'withEachAdjacentSquare', ->

    it 'should call the callback 3 times for a corner', ->
      count = 0
      finder.withEachAdjacentSquare 0, 0, ->
        count++
      expect(count).toBe 3

    it 'should call the callback 5 times for an edge', ->
      count = 0
      finder.withEachAdjacentSquare 0, 1, ->
        count++
      expect(count).toBe 5
      
    it 'should call the callback 8 times for any other', ->
      count = 0
      finder.withEachAdjacentSquare 1, 1, ->
        count++
      expect(count).toBe 8

  describe 'When the board is randomly generated', ->

    beforeEach ->
      word_bank = new Boggle.WordBank GAME_WORDS
      play_board = new Boggle.PlayBoard
        height: 4
        width: 4
      finder = new Boggle.WordFinder
        play_board: play_board
        word_bank: word_bank
      
    it 'should take less than 3 seconds', ->
      start = moment()
      result = finder.find()
      done = moment()
      expect(done.diff(start)).toBeLessThan 3000
      # console.debug 'found words',result
    



