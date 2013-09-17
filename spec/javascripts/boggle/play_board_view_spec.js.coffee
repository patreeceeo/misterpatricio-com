#= require boggle/play_board_view
#= require boggle/square_collection

describe 'The Boggle Play Board View', ->
  play_board_view = null

  beforeEach ->
    square_collection = new Boggle.SquareCollection(
      for l in 'qwertyuiopasdfgh'
        { value: l }
    )

    play_board_view = new Boggle.PlayBoardView
      collection: square_collection

    setFixtures "<div id='boggle-container'></div>"
    $('#boggle-container').append(play_board_view.el)
    play_board_view.render()


  it 'should be a square', ->
    expect(play_board_view.$el.height()).toEqual play_board_view.$el.width()

  it 'should have 16 squares', ->
    expect($('.square').length).toBe 16

