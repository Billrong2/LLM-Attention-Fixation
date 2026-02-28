function f(value: string): string {
    let ls: string[] = value.split('');
    ls.push('NHIB');
    return ls.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ruam"),"ruamNHIB");
}

test();
