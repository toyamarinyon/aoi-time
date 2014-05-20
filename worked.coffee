
worked = module.exports = do ->

  worked_from = ''
  worked_to = ''
  working_breaktime = '1.0'
  normal_working_hours = '8.0'

  hour_to_millisec = (hour) ->
    hour*60*60*1000

  date_to_hours = (date) ->
    hour = date.getHours()
    min  = date.getMinutes()
    hour+':'+('0'+min).slice(-2)

  public_methods =

    from: (datetime) ->
      worked_from = new Date(datetime)
      return this

    to: (datetime) ->
      worked_to = new Date(datetime)
      return this

    workingtime: ->
      diff_date = new Date(worked_to - worked_from)

      if diff_date.getHours() <= 1*working_breaktime
        date_to_hours new Date(1900, 1, 1, diff_date.getHours(), diff_date.getMinutes(), 0, 0)
      else
        diff_millisec = diff_date.getTime()
        diff_millisec = diff_millisec - hour_to_millisec(working_breaktime)
        date_to_hours new Date(diff_millisec)

    overtime: ->
      diff_date = new Date(worked_to - worked_from)
      if diff_date.getHours() < (1*normal_working_hours) + (1*working_breaktime)
        date_to_hours new Date(1900, 1, 1, 0, 0, 0, 0)
      else
        diff_millisec = diff_date.getTime()
        diff_millisec = diff_millisec - hour_to_millisec(normal_working_hours) - hour_to_millisec(working_breaktime)
        date_to_hours new Date(diff_millisec)
