#= require mousetrap
#= require mousetrap-global-bind
#= require backbone.mousetrap

window.Boggle ?= {}

class InputModel extends Backbone.Model
  defaults:
    text: ''
  text: ->
    @get 'text'
  append: (postfix) ->
    text = @text()
    if text.length < 40
      @set 'text', "#{text}#{postfix}"
  clear: ->
    @set 'text', ''

class Boggle.InputView extends Backbone.View
  initialize: ->
    $(document).keypress @documentKeypress
    @model = new InputModel()
    @listenTo @model, 'change', @render
    @hasFocus = true
  keyboardEvents:
    'enter': ->
      @trigger 'word:submit', @model.text()
      @model.clear()
    'backspace': (e) ->
      e.preventDefault()
  documentKeypress: (e) =>
    console.debug 'event',e
    if not e.ctrlKey and not e.altKey and not e.metaKey and
        65 <= e.charCode <= 122
      e.preventDefault()
      e.stopPropagation()
      @model.append String.fromCharCode e.charCode
  render: ->
    @$el.text @model.text()

