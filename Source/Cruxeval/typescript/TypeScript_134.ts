function f(n: number): string {
    let t: number = 0;
    let b: string = '';
    let digits: number[] = Array.from(String(n), Number);
    for (let d of digits) {
        if (d === 0) {
            t += 1;
        } else {
            break;
        }
    }
    for (let _ = 0; _ < t; _++) {
        b += '1' + '0' + '4';
    }
    b += String(n);
    return b;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(372359),"372359");
}

test();
