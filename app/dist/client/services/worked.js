'use strict';
app.factory('worked', function() {
  var Worked, date_format, date_to_hours, hour_to_millisec, normal_working_hours, timezone_offset_millisec, working_breaktime;
  working_breaktime = '1.0';
  normal_working_hours = '8.0';
  hour_to_millisec = function(hour) {
    return hour * 60 * 60 * 1000;
  };
  date_to_hours = function(date) {
    var hour, min;
    hour = date.getHours();
    min = date.getMinutes();
    return hour + ':' + ('0' + min).slice(-2);
  };
  date_format = function(date) {
    var day, month, year;
    year = date.getFullYear();
    month = date.getMonth() + 1;
    day = date.getDate();
    return year + ('0' + month).slice(-2) + ('0' + day).slice(-2);
  };
  timezone_offset_millisec = function() {
    return new Date().getTimezoneOffset() * 60 * 1000;
  };
  Worked = (function() {
    function Worked() {}

    Worked.prototype.from = '';

    Worked.prototype.to = '';

    Worked.prototype.workingtime = function() {
      var diff_date, diff_millisec;
      diff_date = new Date(this.to - this.from + timezone_offset_millisec());
      if (diff_date.getHours() <= 1 * working_breaktime) {
        return date_to_hours(new Date(1900, 1, 1, diff_date.getHours(), diff_date.getMinutes(), 0, 0));
      } else {
        diff_millisec = diff_date.getTime();
        diff_millisec = diff_millisec - hour_to_millisec(working_breaktime);
        return date_to_hours(new Date(diff_millisec));
      }
    };

    Worked.prototype.overtime = function() {
      var diff_date, diff_millisec;
      diff_date = new Date(this.to - this.from + timezone_offset_millisec());
      if (diff_date.getHours() < (1 * normal_working_hours) + (1 * working_breaktime)) {
        return date_to_hours(new Date(1900, 1, 1, 0, 0, 0, 0));
      } else {
        diff_millisec = diff_date.getTime();
        diff_millisec = diff_millisec - hour_to_millisec(normal_working_hours) - hour_to_millisec(working_breaktime);
        return date_to_hours(new Date(diff_millisec));
      }
    };

    Worked.prototype.date = function() {
      return date_format(new Date(this.from));
    };

    Worked.prototype.update = function(object) {
      this.to = object.to;
      return this.from = object.from;
    };

    Worked.prototype.to_object = function() {
      return {
        date: this.date(),
        from: this.from,
        to: this.to,
        workingtime: this.workingtime(),
        overtime: this.overtime()
      };
    };

    return Worked;

  })();
  return new Worked();
});
