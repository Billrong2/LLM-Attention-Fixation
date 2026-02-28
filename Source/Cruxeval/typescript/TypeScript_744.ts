function f(text: string, new_ending: string): string {
    let result: string[] = text.split('');
    result.push(...new_ending.split(''));
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("jro", "wdlp"),"jrowdlp");
}

test();
