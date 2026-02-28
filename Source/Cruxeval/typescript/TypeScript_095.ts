function f(zoo: {[key: string]: string}): {[key: string]: string} {
    return Object.fromEntries(Object.entries(zoo).map(([k, v]) => [v, k]));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"AAA": "fr"}),{"fr": "AAA"});
}

test();
