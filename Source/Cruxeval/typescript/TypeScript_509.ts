function f(value: number, width: number): string {
    if (value >= 0) {
        return value.toString().padStart(width, '0');
    }

    if (value < 0) {
        return '-' + Math.abs(value).toString().padStart(width, '0');
    }
    return '';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(5, 1),"5");
}

test();
