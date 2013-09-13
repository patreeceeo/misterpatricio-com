#= boggle/word_miner
#= boggle/word_bank
#= boggle/play_board

describe 'The Boggle Word Finder', ->
  word_miner = null
  word_bank = null
  play_board = null

  beforeEach ->
    word_bank = new Boggle.WordBank [
      'abc'
      'aba'
      'xyz'
      'oxo'
    ]
    play_board = new Boggle.PlayBoard
      board: [
        ['a', ' ', 'o', ' ']
        ['b', 'c', 'x', 'o']
        ['a', ' ', 'y', ' ']
        [' ', ' ', 'z', ' ']
      ]

    found_words = Boggle.wordFinder
      play_board: play_board
      word_bank: word_bank

  it 'should find all the words in the word bank', ->
    found_words



