function f(array: string[]): string[] {
    let c: string[] = array;
    let array_copy: string[] = array;

    while (true) {
        c.push('_');
        if (c === array_copy) {
            array_copy[c.indexOf('_')] = '';
            break;
        }
    }

    return array_copy;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[""]);
}

test();
