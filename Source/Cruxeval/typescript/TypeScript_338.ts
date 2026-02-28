function f(my_dict: {[key: string]: number}): {[key: number]: string} {
    const result: {[key: number]: string} = {};
    for (const key in my_dict) {
        if (my_dict.hasOwnProperty(key)) {
            result[my_dict[key]] = key;
        }
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"a": 1, "b": 2, "c": 3, "d": 2}),{1: "a", 2: "d", 3: "c"});
}

test();
