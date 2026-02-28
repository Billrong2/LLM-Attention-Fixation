function f(user: {[key: string]: string}): [string, string, string, string] {
    if (Object.keys(user).length > Object.values(user).length) {
        return Object.keys(user) as [string, string, string, string];
    }
    return Object.values(user) as [string, string, string, string];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"eating": "ja", "books": "nee", "piano": "coke", "excitement": "zoo"}),["ja", "nee", "coke", "zoo"]);
}

test();
