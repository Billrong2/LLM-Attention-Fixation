function f(a: string, split_on: string): boolean {
    let t: string[] = a.split('');
    let arr: string[] = [];
    for (let i of t) {
        for (let j of i) {
            arr.push(j);
        }
    }
    if (arr.includes(split_on)) {
        return true;
    } else {
        return false;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("booty boot-boot bootclass", "k"),false);
}

test();
