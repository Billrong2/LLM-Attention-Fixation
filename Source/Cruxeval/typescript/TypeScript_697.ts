function f(s: string, sep: string): [string, string, string] {
    let sep_index = s.indexOf(sep);
    let prefix = s.slice(0, sep_index);
    let middle = s.slice(sep_index, sep_index + sep.length);
    let right_str = s.slice(sep_index + sep.length);
    return [prefix, middle, right_str];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("not it", ""),["", "", "not it"]);
}

test();
