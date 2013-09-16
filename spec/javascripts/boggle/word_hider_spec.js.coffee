#= require 'boggle/word_hider'
#= require 'boggle/word_finder'
#= require 'boggle/word_bank'
#= require 'boggle/play_board'

describe 'The Boggle word hider', ->
  word_bank = null
  play_board = null
  word_hider = null
  word_finder = null
  beforeEach ->
    word_bank = new Boggle.WordBank GAME_WORDS
    play_board = new Boggle.PlayBoard 
      height: 5
      width: 5
    word_hider = new Boggle.WordHider
      play_board: play_board
    word_finder = new Boggle.WordFinder
      word_bank: word_bank
      play_board: play_board
    word_hider.hide()
 
  it 'should hide words so that the word finder can find them', ->
    console.debug 'board:'
    console.debug play_board.toString()
    console.debug 'found words',word_finder.find()



