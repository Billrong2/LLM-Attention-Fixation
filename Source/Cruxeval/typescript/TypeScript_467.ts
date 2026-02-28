function f(nums: {[key: string]: string}): {[key: string]: number} {
    let copy: {[key: string]: string} = {...nums};
    let newDict: {[key: string]: number} = {};
    for(let k in copy) {
        newDict[k] = copy[k].length;
    }
    return newDict;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
