function f(names: string[], excluded: string): string[] {
    for (let i = 0; i < names.length; i++) {
        if (names[i].includes(excluded)) {
            names[i] = names[i].replace(excluded, "");
        }
    }
    return names;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["avc  a .d e"], ""),["avc  a .d e"]);
}

test();
