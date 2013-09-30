#= require backbone
#= require backbone.marionette

class ScoreModel extends Backbone.Model
  defaults:
    max_possible_score: 0
    players_score: 0
  incrementPlayersScore: (amount) ->
    @set 'players_score', (@get 'players_score') + amount

window.Boggle ?= {}
class Boggle.ScoreView extends Marionette.ItemView
  initialize: (options) ->
    @model = new ScoreModel
      max_possible_score: options.max_possible_score
  template: (data) ->
    percent = (data.players_score / data.max_possible_score) or 0
    percent = 
    if percent < 0.1
      Math.round(percent * 100 * 10) / 10
    else
      Math.round(percent * 100)
    "#{percent}%"
  incrementPlayersScore: (amount) ->
    @model.incrementPlayersScore(amount)
    @render()
