worked = require '../worked'

describe 'worked', ->

  describe 'overtime', ->

    beforeEach ->
      worked.from = new Date('2014/05/19 09:00:00').getTime()
      worked.to =  new Date('2014/05/19 21:30:00').getTime()

    it 'should return 0:00 when we worked.from = 9:00 to 16:00', ->
      worked.to = new Date('2014/05/19 16:00:00').getTime()
      worked.overtime().should.equal('0:00')

    it 'should return 0:00 when we worked.from = 9:00 to 18:00', ->
      worked.to = new Date('2014/05/19 18:00:00').getTime()
      worked.overtime().should.equal('0:00')

    it 'should return 1:00 when we worked.from = 9:00 to 19:00', ->
      worked.to = new Date('2014/05/19 19:00:00').getTime()
      worked.overtime().should.equal('1:00')

    it 'should return 2:30 when we worked.from = 9:00 to 20:30', ->
      worked.to = new Date('2014/05/19 20:30:00').getTime()
      worked.overtime().should.equal('2:30')

    it 'should return 2:42 when we worked.from = 9:00 to 20:42', ->
      worked.to = new Date('2014/05/19 20:42:00').getTime()
      worked.overtime().should.equal('2:42')

    it 'should return 3:00 when we worked.from = 9:00 to 21:00', ->
      worked.to = new Date('2014/05/19 21:00:00').getTime()
      worked.overtime().should.equal('3:00')

    it 'should return 6:00 when we worked.from = 9:00 to 24:00', ->
      worked.to = new Date('2014/05/20 00:00:00').getTime()
      worked.overtime().should.equal('6:00')

    it 'should return 3:45 when we worked.from = 8:45 to 21:30', ->
      worked.from = new Date('2014/05/19 08:45:00').getTime()
      worked.overtime().should.equal('3:45')

    it 'should return 7:30 when we worked.from = 5:00 to 21:30', ->
      worked.from = new Date('2014/05/19 05:00:00').getTime()
      worked.overtime().should.equal('7:30')


  describe 'workingtime', ->

    beforeEach ->
      worked.from = new Date('2014/05/19 09:00:00').getTime()
      worked.to = new Date('2014/05/19 21:30:00').getTime()

    it 'should return 0:00 when we worked.from = 9:00 to 9:24', ->
      worked.to = new Date('2014/05/19 09:24:00').getTime()
      worked.workingtime().should.equal('0:24')

    it 'should return 1:00 when we worked.from = 9:00 to 10:00', ->
      worked.to = new Date('2014/05/19 10:00:00').getTime()
      worked.workingtime().should.equal('1:00')

    it 'should return 6:00 when we worked.from = 9:00 to 16:00', ->
      worked.to = new Date('2014/05/19 16:00:00').getTime()
      worked.workingtime().should.equal('6:00')

    it 'should return 8:00 when we worked.from = 9:00 to 18:00', ->
      worked.to = new Date('2014/05/19 18:00:00').getTime()
      worked.workingtime().should.equal('8:00')

    it 'should return 9:00 when we worked.from = 9:00 to 19:00', ->
      worked.to = new Date('2014/05/19 19:00:00').getTime()
      worked.workingtime().should.equal('9:00')

    it 'should return 10:30 when we worked.from = 9:00 to 20:30', ->
      worked.to = new Date('2014/05/19 20:30:00').getTime()
      worked.workingtime().should.equal('10:30')

    it 'should return 10:42 when we worked.from = 9:00 to 20:42', ->
      worked.to = new Date('2014/05/19 20:42:00').getTime()
      worked.workingtime().should.equal('10:42')

    it 'should return 11:00 when we worked.from = 9:00 to 21:00', ->
      worked.to = new Date('2014/05/19 21:00:00').getTime()
      worked.workingtime().should.equal('11:00')

    it 'should return 14:00 when we worked.from = 9:00 to 24:00', ->
      worked.to = new Date('2014/05/20 00:00:00').getTime()
      worked.workingtime().should.equal('14:00')

    it 'should return 11:45 when we worked.from = 8:45 to 21:30', ->
      worked.from = new Date('2014/05/19 08:45:00').getTime()
      worked.workingtime().should.equal('11:45')

    it 'should return 15:30 when we worked.from = 5:00 to 21:30', ->
      worked.from = new Date('2014/05/19 05:00:00').getTime()
      worked.workingtime().should.equal('15:30')

