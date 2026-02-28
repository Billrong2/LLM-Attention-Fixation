function f(dictionary: {[key: string]: number}): {[key: string]: number} {
    dictionary[1049] = 55;
    const keys = Object.keys(dictionary);
    const lastKey = keys[keys.length - 1];
    const value = dictionary[lastKey];
    delete dictionary[lastKey];
    dictionary[lastKey] = value;
    return dictionary;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"noeohqhk": 623}),{"noeohqhk": 623, "1049": 55});
}

test();
