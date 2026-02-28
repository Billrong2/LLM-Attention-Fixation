function f(dict0: {[key: number]: number}): {[key: number]: number} {
    let new_dict: {[key: number]: number} = {...dict0};
    let sortedKeys = Object.keys(new_dict).sort((a, b) => Number(a) - Number(b));
    for (let i = 0; i < sortedKeys.length - 1; i++) {
        dict0[Number(sortedKeys[i])] = i;
    }
    return dict0;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({2: 5, 4: 1, 3: 5, 1: 3, 5: 1}),{2: 1, 4: 3, 3: 2, 1: 0, 5: 1});
}

test();
