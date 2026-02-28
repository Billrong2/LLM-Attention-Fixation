function f(d: {[key: string]: number}): [[string, number], [string, number]] {
    const entries = Object.entries(d);
    return [entries[0], entries[1]];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"a": 123, "b": 456, "c": 789}),[["a", 123], ["b", 456]]);
}

test();
