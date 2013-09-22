#= require boggle/play_board
#= require boggle/word_bank
#= require boggle/word_finder
#= require boggle/play_board_view
#= require boggle/square_collection
#= require boggle/game_words
#= require boggle/input_view
#= require boggle/word_list_view

Boggle.app = app = new Backbone.Marionette.Application()

app.addRegions
  play_board_region: '[data-js=play_board]'
  input_region: '[data-js=input]'
  players_answers_region: '[data-js=players_answers]'
  answers_region: '[data-js=answers]'

play_board = new Boggle.PlayBoard
  height: 4
  width: 4

square_collection = new Boggle.SquareCollection(
  {value: value} for value in play_board.values()
)

play_board_view = new Boggle.PlayBoardView
  collection: square_collection

word_bank = new Boggle.WordBank GAME_WORDS
  
word_finder = new Boggle.WordFinder
  play_board: play_board
  word_bank: word_bank

input_view = new Boggle.InputView()
window.answers = word_finder.find()

players_answers_view = new Boggle.WordListView()
answers_view = new Boggle.WordListView
  word_list: answers
  
$ ->
  app.play_board_region.show play_board_view
  app.input_region.show input_view
  # app.answers_region.show answers_view
  app.players_answers_region.show players_answers_view

  Backbone.listenTo input_view, 'word:submit', (word) ->
    window.word = word
    console.debug 'answers',answers
    if word in answers
      console.debug 'answer', word
      players_answers_view.append(word)
    else
      console.debug "'#{word}' is not an answer"



