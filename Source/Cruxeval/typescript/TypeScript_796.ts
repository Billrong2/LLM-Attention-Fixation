function f(str: string, toget: string): string {
    if (str.startsWith(toget)) {
        return str.substring(toget.length);
    } else {
        return str;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("fnuiyh", "ni"),"fnuiyh");
}

test();
