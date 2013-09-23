#= require backbone
#= require backbone.marionette

class ScoreModel extends Backbone.Model
  defaults:
    max_possible_score: 0
    players_score: 0
  increment_players_score: (amount) ->
    @set 'players_score', (@get 'players_score') + amount

window.Boggle ?= {}
class Boggle.ScoreView extends Marionette.ItemView
  initialize: (options) ->
    @model = new ScoreModel
      max_possible_score: options.max_possible_score
  template: (data) ->
    percent = (Math.round (data.players_score / data.max_possible_score or 0) * 1000) / 10
    "#{data.players_score} / #{data.max_possible_score} (#{percent}%)"
  increment_players_score: (amount) ->
    @model.increment_players_score(amount)
    @render()
