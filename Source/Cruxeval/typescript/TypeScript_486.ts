function f(dic: {[key: number]: number}): {[key: number]: number} {
    const dic_op: {[key: number]: number} = {...dic};
    for (const key in dic) {
        if (dic.hasOwnProperty(key)) {
            dic_op[key] = dic[key] * dic[key];
        }
    }
    return dic_op;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({1: 1, 2: 2, 3: 3}),{1: 1, 2: 4, 3: 9});
}

test();
