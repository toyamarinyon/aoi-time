
worked = module.exports = do ->

  worked_from = ''
  worked_to = ''
  working_breaktime = '1.0'
  normal_working_hours = '8.0'

  return {
    from: (datetime) ->
      worked_from = new Date(datetime)
      return this

    to: (datetime) ->
      worked_to = new Date(datetime)
      return this

    workingtime: ->
      difference_hours = (worked_to - worked_from)/(1000*60*60)
      return Math.round(difference_hours * 100)/100

    overtime: ->
      overtime = this.workingtime() - normal_working_hours - working_breaktime
      return if overtime < 0 then 0 else overtime
  }
