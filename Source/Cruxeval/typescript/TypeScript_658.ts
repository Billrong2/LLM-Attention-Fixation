function f(d: {[key: number]: string}, get_ary: number[]): (string | undefined)[] {
    let result: (string | undefined)[] = [];
    for(let key of get_ary) {
        result.push(d[key]);
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({3: "swims like a bull"}, [3, 2, 5]),["swims like a bull", undefined, undefined]);
}

test();
