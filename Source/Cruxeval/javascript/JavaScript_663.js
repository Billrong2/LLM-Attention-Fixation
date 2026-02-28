function f(container, cron){
if (!container.includes(cron)) {
    return container.slice();
}
let pref = container.slice(0, container.indexOf(cron));
let suff = container.slice(container.indexOf(cron) + 1);
return pref.concat(suff);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([], 2),[]);
}

test();
