define [
  'cs!app'
  'underscore'
  'marionette'
  'text!templates/layouts/deck.html'
  'cs!views/deck'
  'cs!views/card'
  'cs!views/card/edit'
], (app, _, Marionette, Template, DeckView, CardView, CardEditView) ->
    Marionette.Layout.extend
      template: _.template(Template)

      regions:
        deckRegion: '#deck'
        cardRegion: '#card'

      ui:
        editButton:   '#edit'
        hideCheckbox: '#hide'

      events:
        'click #next'    : 'nextCard'
        'click #answer'  : 'showAnswer'
        'click #edit'    : 'showEdit'
        'click a': (e) ->
          e.preventDefault()
          app.vent.trigger 'goto:index'
        'change #hide': (e) ->
          @hideAnswers = @ui.hideCheckbox.prop('checked')

      initialize: (options) ->
        @deck = options.deck
        @hideAnswers = true

      onRender: () ->
        @ui.editButton.hide()
        @ui.hideCheckbox.attr('checked', @hideAnswers)

      onShow: () ->
        @deckView = new DeckView model: @deck
        @deckRegion.show @deckView
        @nextCard()

      nextCard: () ->
        self = @
        promise = app.request('randomDeckCard', deck: @deck).done (card) ->
          self.cardView = new CardView model: card, deck: self.deck, hideAnswer: self.hideAnswers
          self.cardRegion.show self.cardView

        promise.done (card) ->
          self.card = card
          self.refreshEditButton()

      refreshEditButton: () ->
        self = @
        app.request('user').done (user) ->
          if user?.get('id') == self.deck.get('owner')
            self.ui.editButton.show()
          else
            self.ui.editButton.hide()

      showAnswer: () ->
        @cardView?.showBack()

      showEdit: () ->
        @cardRegion.show new CardEditView model: @card
        console.log "Show card #{@card.get('id')} edit view"