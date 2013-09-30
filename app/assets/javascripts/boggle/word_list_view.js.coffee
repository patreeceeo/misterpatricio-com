#= require backbone
#= require backbone.marionette

class WordModel extends Backbone.Model
  # this guarantees that each word will be unique
  idAttribute: 'word'
  defaults:
    word: ''
    fromHuman: false
  word: ->
    @get 'word'

class WordCollection extends Backbone.Collection
  model: WordModel

class WordView extends Marionette.ItemView
  tagName: 'li'
  className: ->
    'checked' if @model.get 'fromHuman'
  template: (data) ->
    data.word

window.Boggle ?= {}
class Boggle.WordListView extends Marionette.CollectionView
  tagName: 'ul'
  itemView: WordView
  initialize: (options) ->
    @collection = new WordCollection(
      for word in options?.word_list or [] 
        {word: word}
    )
  append: (word) ->
    @collection.push word: word 
  addHumanAnswer: (word) ->
    @collection.push word: word, fromHuman: true

  

