function f(values){
    let names = ['Pete', 'Linda', 'Angela'];
    names.push(...values);
    names.sort();
    return names;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["Dan", "Joe", "Dusty"]),["Angela", "Dan", "Dusty", "Joe", "Linda", "Pete"]);
}

test();
