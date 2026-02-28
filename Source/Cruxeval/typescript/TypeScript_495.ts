function f(s: string): [string, string]|string {
    if (s.slice(-5).normalize('NFD').replace(/[\u0300-\u036f]/g, "").replace(/[^\x00-\x7F]/g, "") == s.slice(-5)) {
        return [s.slice(-5), s.slice(0, 3)];
    } 
    else if (s.slice(0, 5).normalize('NFD').replace(/[\u0300-\u036f]/g, "").replace(/[^\x00-\x7F]/g, "") == s.slice(0, 5)) {
        return [s.slice(0, 5), s.slice(-2)];
    } 
    else {
        return s;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a1234år"),["a1234", "år"]);
}

test();
