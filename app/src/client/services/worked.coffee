'use strict'

app.factory 'worked', ->
  working_breaktime = '1.0'
  normal_working_hours = '8.0'

  hour_to_millisec = (hour) ->
    hour*60*60*1000

  date_to_hours = (date) ->
    hour = date.getHours()
    min  = date.getMinutes()
    hour+':'+('0'+min).slice(-2)

  date_format = (date) ->
    year = date.getFullYear()
    month = date.getMonth()+1
    day = date.getDate()

    year + ('0'+month).slice(-2) + ('0'+day).slice(-2)

  timezone_offset_millisec = ->
    new Date().getTimezoneOffset()*60*1000


  class Worked
    constructor: ->

    from: ''

    to: ''

    workingtime: ->
      diff_date = new Date(@to - @from + timezone_offset_millisec())

      if diff_date.getHours() <= 1*working_breaktime
        date_to_hours new Date(1900, 1, 1, diff_date.getHours(), diff_date.getMinutes(), 0, 0)
      else
        diff_millisec = diff_date.getTime()
        diff_millisec = diff_millisec - hour_to_millisec(working_breaktime)
        date_to_hours new Date(diff_millisec)

    overtime: ->
      diff_date = new Date(@to - @from + timezone_offset_millisec())
      if diff_date.getHours() < (1*normal_working_hours) + (1*working_breaktime)
        date_to_hours new Date(1900, 1, 1, 0, 0, 0, 0)
      else
        diff_millisec = diff_date.getTime()
        diff_millisec = diff_millisec - hour_to_millisec(normal_working_hours) - hour_to_millisec(working_breaktime)
        date_to_hours new Date(diff_millisec)

    date: ->
      date_format new Date @from

    update: (object) ->
      @to = object.to
      @from = object.from

    to_object: ->
      date: this.date()
      from: @from
      to: @to
      workingtime: this.workingtime()
      overtime: this.overtime()

  new Worked()
