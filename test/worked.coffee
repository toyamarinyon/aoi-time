worked = require '../worked'

describe 'worked', ->

  describe 'overtime', ->

    beforeEach ->
      worked.from '2014/05/19 09:00:00'
      worked.to '2014/05/19 21:30:00'

    it 'should return 0:00 when we worked from 9:00 to 18:00', ->
      worked.to '2014/05/19 18:00:00'
        .overtime().should.equal('0:00')

    it 'should return 1:00 when we worked from 9:00 to 19:00', ->
      worked.to '2014/05/19 19:00:00'
        .overtime().should.equal('1:00')

    it 'should return 2:30 when we worked from 9:00 to 20:30', ->
      worked.to '2014/05/19 20:30:00'
        .overtime().should.equal('2:30')

    it 'should return 2:42 when we worked from 9:00 to 20:42', ->
      worked.to '2014/05/19 20:42:00'
        .overtime().should.equal('2:42')

    it 'should return 3:00 when we worked from 9:00 to 21:00', ->
      worked.to '2014/05/19 21:00:00'
        .overtime().should.equal('3:00')

    it 'should return 6:00 when we worked from 9:00 to 24:00', ->
      worked.to '2014/05/20 00:00:00'
        .overtime().should.equal('6:00')

    it 'should return 3:45 when we worked from 8:45 to 21:30', ->
      worked.from '2014/05/19 08:45:00'
        .overtime().should.equal('3:45')

    it 'should return 7:30 when we worked from 5:00 to 21:30', ->
      worked.from '2014/05/19 05:00:00'
        .overtime().should.equal('7:30')

