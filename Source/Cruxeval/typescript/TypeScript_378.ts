function f(dic: {[key: string]: number}, key: string): string| number {
    if (!(key in dic)) {
        return 'No such key!';
    } else {
        let v = dic[key];
        delete dic[key];
        return v;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"did": 0}, "u"),"No such key!");
}

test();
