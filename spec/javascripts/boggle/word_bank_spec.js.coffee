#= require boggle/word_bank
#= require boggle/game_words
#= require moment

describe 'The Boggle Word Bank', ->

  word_bank = null

  beforeEach ->
    word_bank = new Boggle.WordBank [
      'aardvark'
      'bears'
      'beer'
      'bees'
      'carrots'
      'parrots'
      'tears'
    ]


  it 'should be able to find whole words', ->
    expect(word_bank.lookup('carrots')).toBeTruthy()

  it 'should give a list of words that begin with a given prefix', ->
    expect(word_bank.lookup('be')).toEqual [
      'bears'
      'beer'
      'bees'
    ]

  it """
        should not return a match if the word given to lookup was not
        in the list, even if a prefix of that word is
     """, ->
    expect(word_bank.lookup('tearses')).toEqual []


  it "should take less than 10 milliseconds to look up a prefix.", ->
    word_bank = new Boggle.WordBank GAME_WORDS
    start = moment()
    result = word_bank.lookup('toast')
    done = moment()
    expect(done.diff(start)).toBeLessThan 10

    


