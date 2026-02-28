function f(num: number, name: string): string {
    const f_str: string = 'quiz leader = {}, count = {}';
    return f_str.replace('{}', name).replace('{}', num.toString());
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(23, "Cornareti"),"quiz leader = Cornareti, count = 23");
}

test();
