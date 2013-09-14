#= require boggle/word_bank
#= require boggle/play_board
#= require boggle/word_finder

describe 'The Boggle Word Finder', ->
  finder = null
  word_bank = null
  play_board = null

  beforeEach ->
    word_bank = new Boggle.WordBank [
      'ABC'
      'ABA'
      'XYZ'
      'OXO'
    ]
    play_board = new Boggle.PlayBoard
      board: [
        ['A', ' ', 'O', ' ']
        ['B', 'C', 'X', 'O']
        ['A', ' ', 'Y', ' ']
        [' ', ' ', 'Z', ' ']
      ]
    finder = new Boggle.WordFinder
      play_board: play_board
      word_bank: word_bank

  it 'should find all the words in the word bank', ->
    expect(finder.find()).toEqual [
      'ABC'
      'OXO'
      'ABA'
      'XYZ'
    ]

  # describe 'When the board is randomly generated', ->

  #   beforeEach ->
  #     word_bank = new Boggle.WordBank [
  #       'ANT'
  #       'CAN'
  #       'EEL'
  #       'ZEE'
  #       'HAS'
  #       'NAN'
  #       'YOU'
  #       'WEE'
  #       'PEE'
  #       'PEA'
  #       'SEE'
  #       'SEA'
  #       'SHH'
  #       'OLE'
  #       'TOP'
  #       'JOB'
  #       'SOB'
  #       'COB'
  #       'HOB'
  #       'POP'
  #       'SOP'
  #       'SOB'
  #       'CRY'
  #       'DIE'
  #     ]
  #     play_board = new Boggle.PlayBoard
  #       height: 9
  #       width: 9
  #     finder = new Boggle.WordFinder
  #       play_board: play_board
  #       word_bank: word_bank
  #     console.debug play_board.board
      
  #   it 'should not blow up', ->
  #     r = null
  #     expect(-> r = finder.find()).not.toThrow()
  #     console.debug r
    



