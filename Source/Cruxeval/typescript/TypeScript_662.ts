function f(values: string[]): string[] {
    let names: string[] = ['Pete', 'Linda', 'Angela'];
    names.push(...values);
    names.sort();
    return names;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["Dan", "Joe", "Dusty"]),["Angela", "Dan", "Dusty", "Joe", "Linda", "Pete"]);
}

test();
