#= require boggle/play_board

describe 'The Boggle Play Board', ->
  play_board = null
  letters = for c in [0...26]
    String.fromCharCode 97 + c

  beforeEach ->
    play_board = new Boggle.PlayBoard
      width: 5
      height: 5

  it 'should tell us if one square is adjacent to another', ->
    expect(play_board.square(1,1).isAdjacentTo(1,2)).toBeTruthy()
    expect(play_board.square(1,1).isAdjacentTo(4,4)).toBeFalsy()
    expect(play_board.square(10,10).isAdjacentTo(4,4)).toBeFalsy()

  it 'should report the correct height and width', ->
    expect(play_board.height).toBe 5
    expect(play_board.width).toBe 5
