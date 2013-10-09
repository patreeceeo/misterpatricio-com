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
  length: ->
    @get('text').length

class Boggle.InputView extends Backbone.View
  initialize: ->
    $(document).keypress @documentKeypress
    @input = new InputModel()
    @listenTo @input, 'change', @render
  keyboardEvents:
    'enter': (e) ->
      e.preventDefault()
      @trigger 'submit', @input.text()
      @input.clear()
    'backspace': (e) ->
      @input.backspace()
      e.preventDefault()
      @trigger 'change', @input.text()
    'ctrl+c': (e) ->
      @trigger 'game:over'
  documentKeypress: (e) =>
    _A = 'A'.charCodeAt 0
    _Z = 'Z'.charCodeAt 0
    _a = 'a'.charCodeAt 0
    _z = 'z'.charCodeAt 0
    if not e.ctrlKey and not e.altKey and not e.metaKey and
        _A <= e.charCode <= _Z or _a <= e.charCode <= _z and
        @input.length() <= 16
      e.preventDefault()
      e.stopPropagation()
      @input.append String.fromCharCode e.charCode
      @trigger 'change', @input.text()
  blinkCursor: =>
    @cursor.toggleClass 'hide'
  render: ->
    @cursor = $("<span class='mock_cursor'>_</span>")
    @$el.text @input.text()
    @$el.append @cursor
    clearInterval @cursorIntervalID
    @cursorIntervalID =
    setInterval @blinkCursor, 500

