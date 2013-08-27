
# Internal: Override Marionette's serializeData to return the view's model
#           and/or collection instead of their serialized representation.
#
# Returns an (plain) Object containing
#     :model      - The view's model
#     :collection - The view's collection
serializeData = ->
  data = {}
  if @model?
    data.model = @model
  else if @collection?
    data.collection = @collection
  data

# Internal: Get an instance of the class corresponding to an 'option' of 
#           `this`. The option value MUST be a function that returns the class
#           to be instantiated.
# 
# option_key - a key of `this`, `this.options` or etc.
# more_args  - the remaining args will be used when instantiating the instance.
#
# Returns an Object.
buildOption = (option_key, more_args...) ->
  Klass = Marionette.getOption(@, option_key)()
  new Klass more_args...


class SocialPromote.ItemView extends Marionette.ItemView
  serializeData: serializeData
  buildOption: buildOption

class SocialPromote.CollectionView extends Marionette.CollectionView
  serializeData: serializeData
  buildOption: buildOption

class SocialPromote.CompositeView extends Marionette.CompositeView
  serializeData: serializeData
  buildOption: buildOption

class SocialPromote.Layout extends Marionette.Layout
  serializeData: serializeData
  buildOption: buildOption
