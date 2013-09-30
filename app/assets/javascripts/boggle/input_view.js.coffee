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
  backspace: ->
    text = @text()
    @set 'text', text.substring(0, text.length-1)

class Boggle.InputView extends Backbone.View
  initialize: ->
    $(document).keypress @documentKeypress
    @model = new InputModel()
    @listenTo @model, 'change', @render
  keyboardEvents:
    'enter': (e) ->
      e.preventDefault()
      @trigger 'word:submit', @model.text()
      @model.clear()
    'backspace': (e) ->
      @model.backspace()
      e.preventDefault()
  documentKeypress: (e) =>
    if not e.ctrlKey and not e.altKey and not e.metaKey and
        65 <= e.charCode <= 122
      e.preventDefault()
      e.stopPropagation()
      @model.append String.fromCharCode e.charCode
  blinkCursor: =>
    @cursor.toggleClass 'hide'
  render: ->
    @cursor = $("<span class='mock_cursor'>_</span>")
    @$el.text @model.text()
    @$el.append @cursor
    clearInterval @cursorIntervalID
    @cursorIntervalID = 
    setInterval @blinkCursor, 500

