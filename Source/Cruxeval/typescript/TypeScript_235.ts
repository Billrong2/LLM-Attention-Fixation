function f(array: string[], arr: string[]): string[] {
    let result: string[] = [];
    for (let s of arr) {
        result = result.concat(s.split(arr[array.indexOf(s)]).filter(l => l !== ''));
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([], []),[]);
}

test();
