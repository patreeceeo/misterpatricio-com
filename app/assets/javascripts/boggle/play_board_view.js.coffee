#= require underscore
#= require backbone
#= require backbone.marionette

class SquareView extends Marionette.ItemView
  tagName: 'div'
  className: 'boggle square tile'
  modelEvents:
    'change:value': 'render'
  template: (data) ->
    "#{data.value}"
    
window.Boggle ?= {}
class Boggle.PlayBoardView extends Marionette.CollectionView
  itemView: SquareView
  tagName: 'div'
  attributes:
    style: 'width: 8em; height: 8em;'
  className: 'boggle board'


