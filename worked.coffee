
worked = module.exports = do ->

  worked_from = ''
  worked_to = ''
  working_breaktime = '1.0'
  normal_working_hours = '8.0'

  hour_to_millisec = (hour) ->
    return hour*60*60*1000


  return {
    from: (datetime) ->
      worked_from = new Date(datetime)
      return this

    to: (datetime) ->
      worked_to = new Date(datetime)
      return this

    workingtime: ->
      # difference_hours = (worked_to - worked_from)/(1000*60*60)
      # return Math.round(difference_hours * 100)/100
      diff_date = new Date(worked_to - worked_from)
      if diff_date.getHours() < (1*normal_working_hours) + (1*working_breaktime)
        return new Date(1900, 1, 1, 0, 0, 0, 0)
      diff_millisec = diff_date.getTime()
      diff_millisec = diff_millisec - hour_to_millisec(normal_working_hours) - hour_to_millisec(working_breaktime)
      return new Date(diff_millisec)

    overtime: ->
      workingtime = this.workingtime()
      hour = workingtime.getHours()
      min  = workingtime.getMinutes()
      return hour+':'+('0'+min).slice(-2)
      # overtime = ((this.workingtime()*100) - (normal_working_hours*100) - (working_breaktime*100))/100
      # return if overtime < 0 then 0 else overtime
  }
