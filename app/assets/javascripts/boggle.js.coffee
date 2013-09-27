#= require boggle/play_board
#= require boggle/word_bank
#= require boggle/word_finder
#= require boggle/play_board_view
#= require boggle/square_collection
#= require boggle/game_words
#= require boggle/input_view
#= require boggle/word_list_view
#= require boggle/score_view
#= require moment

Boggle.app = app = new Backbone.Marionette.Application()

app.addRegions
  play_board_region: '[data-js=play_board]'
  input_region: '[data-js=input]'
  players_answers_region: '[data-js=players_answers]'
  answers_region: '[data-js=answers]'
  score_region: '[data-js=score]'

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

scoreWord = (word) ->
  Math.pow(2, word.length) / 8

max_possible_score = 0
players_score = 0
for word in answers
  max_possible_score += scoreWord(word)

score_view = new Boggle.ScoreView
  max_possible_score: max_possible_score

time_limit = moment.duration(2, 'minutes')

updateTimerView = ->
  console.debug 'time_limit',time_limit
  time_limit.subtract(1, 'second')
  minutes = Math.floor time_limit.asMinutes()
  seconds = time_limit.seconds()
  if seconds > 9
    time_str = "#{minutes}:#{seconds}"
  else
    time_str = "#{minutes}:0#{seconds}"
  $('[data-js=timer]').text(time_str)
  
$ ->
  app.play_board_region.show play_board_view
  app.input_region.show input_view
  app.players_answers_region.show players_answers_view
  app.score_region.show score_view

  updateTimeInterval = setInterval updateTimerView, 1000

  gameOver = ->
    console.debug 'game over'
    app.input_region.close()
    app.answers_region.show answers_view
    updateTimerView()
    clearTimeout updateTimeInterval
  setTimeout gameOver, time_limit.asMilliseconds()

  Backbone.listenTo input_view, 'word:submit', (word) ->
    window.word = word
    if word in answers
      players_answers_view.append(word)
      score_view.increment_players_score scoreWord(word)
    else



