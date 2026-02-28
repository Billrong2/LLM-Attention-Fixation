function f(dictionary: {[key: string]: number}, key: string): string {
    delete dictionary[key];
    let keys = Object.keys(dictionary);
    if (Math.min(...keys.map(key => parseInt(key))) === parseInt(key)) {
        key = keys[0];
    }
    return key;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"Iron Man": 4, "Captain America": 3, "Black Panther": 0, "Thor": 1, "Ant-Man": 6}, "Iron Man"),"Iron Man");
}

test();
