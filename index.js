var worked = require('./worked.js');

console.log(worked);
worked
  .from('2014/05/16 08:54:52')
  .to('2014/05/16 21:24:29');

console.log(worked.overtime());
console.log(worked);
