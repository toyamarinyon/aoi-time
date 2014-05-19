worked = require '../worked'

describe 'worked', ->

  describe 'overtime', ->

    before ->
      worked.from '2014/05/19 09:00:00'

    it 'should return 0.0 when we worked from 9:00 to 18:00', ->
        worked.to '2014/05/19 18:00:00'
        .overtime().should.equal(0.0)

    it 'should return 1.0 when we worked from 9:00 to 19:00', ->
      worked.to '2014/05/19 19:00:00'
        .overtime().should.equal(1.0)

    it 'should return 2.0 when we worked from 9:00 to 20:00', ->
      worked.to '2014/05/19 20:00:00'
        .overtime().should.equal(2.0)

    it 'should return 3.0 when we worked from 9:00 to 21:00', ->
      worked.to '2014/05/19 21:00:00'
        .overtime().should.equal(3.0)
