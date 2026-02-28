function f(strings: string[]): {[key: string]: number} {
    const occurances: {[key: string]: number} = {};
    strings.forEach(string => {
        if (!occurances[string]) {
            occurances[string] = strings.filter(s => s === string).length;
        }
    });
    return occurances;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["La", "Q", "9", "La", "La"]),{"La": 3, "Q": 1, "9": 1});
}

test();
