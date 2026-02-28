function f(stg: string, tabs: string[]): string {
    for (let tab of tabs) {
        stg = stg.replace(new RegExp(tab + "+$"), "");
    }
    return stg;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("31849 let it!31849 pass!", ["3", "1", "8", " ", "1", "9", "2", "d"]),"31849 let it!31849 pass!");
}

test();
