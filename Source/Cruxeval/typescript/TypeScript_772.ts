function f(phrase: string): string {
    let result = '';
    for (let i of phrase) {
        if (!(i === i.toLowerCase() && i.toUpperCase() !== i.toLowerCase())) {
            result += i;
        }
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("serjgpoDFdbcA."),"DFA.");
}

test();
