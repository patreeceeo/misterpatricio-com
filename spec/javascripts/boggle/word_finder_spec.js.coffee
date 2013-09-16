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
      board: [
        [' ', ' ', 'l', 'e', ' ', ' ', ' ']
        [' ', 'o', 'd', ' ', ' ', ' ', ' ']
        [' ', 'o', 'n', 'a', 'n', ' ', ' ']
        [' ', ' ', 'a', ' ', 'a', ' ', ' ']
        [' ', ' ', 's', ' ', 'b', 'o', ' ']
        [' ', ' ', ' ', ' ', ' ', 'o', 'g']
        [' ', ' ', ' ', ' ', ' ', 'e', 'i']
        ['e', 'l', 'd', 'o', 'o', 'n', ' ']
      ]
    finder = new Boggle.WordFinder
      play_board: play_board
      word_bank: word_bank

  it 'should find well hidden words and only one of each', ->
    expect(finder.find()).toEqual [
      'boogie'
      'noodle'
      'banana'
    ]

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
    



