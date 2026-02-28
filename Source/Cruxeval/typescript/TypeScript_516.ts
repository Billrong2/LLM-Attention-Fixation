function f(strings: string[], substr: string): string[] {
    const list = strings.filter(s => s.startsWith(substr));
    return list.sort((a, b) => a.length - b.length);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["condor", "eyes", "gay", "isa"], "d"),[]);
}

test();
