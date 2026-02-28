function f(text: string, suffix: string, num: number): boolean {
    const str_num: string = num.toString();
    return text.endsWith(suffix + str_num);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("friends and love", "and", 3),false);
}

test();
