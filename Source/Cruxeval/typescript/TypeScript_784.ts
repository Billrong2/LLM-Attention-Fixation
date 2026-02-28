function f(key: string, value: string): [string, string] {
    let dict_ = {[key]: value};
    let item = Object.entries(dict_).pop() as [string, string];
    delete dict_[item[0]];
    return item;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("read", "Is"),["read", "Is"]);
}

test();
