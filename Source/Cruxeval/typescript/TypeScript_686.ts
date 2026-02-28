function f(d: {[key: string]: number}, l: string[]): {[key: string]: number} {
    const new_d: {[key: string]: number} = {};

    l.forEach(k => {
        if (d[k] !== undefined) {
            new_d[k] = d[k];
        }
    });

    return {...new_d};
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"lorem ipsum": 12, "dolor": 23}, ["lorem ipsum", "dolor"]),{"lorem ipsum": 12, "dolor": 23});
}

test();
