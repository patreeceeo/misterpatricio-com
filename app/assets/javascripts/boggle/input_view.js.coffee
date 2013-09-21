
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
  documentKeypress: (e) =>
    console.debug 'charCode',e.charCode
    if e.charCode is 27
      @hasFocus = not @hasFocus
    if @hasFocus
      e.preventDefault()
      e.stopPropagation()
      switch e.charCode
        when 13
          @trigger 'word:submit', @model.text()
          @model.clear()
        when 27
          @model.clear()
        else
          @model.append String.fromCharCode e.charCode
  render: ->
    @$el.text @model.text()

