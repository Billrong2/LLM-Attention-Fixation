function f(ints: number[]): string {
    let counts: number[] = new Array(301).fill(0);

    for (let i of ints) {
        counts[i] += 1;
    }

    let r: string[] = [];
    for (let i = 0; i < counts.length; i++) {
        if (counts[i] >= 3) {
            r.push(i.toString());
        }
    }
    counts = [];
    return r.join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2, 3, 5, 2, 4, 5, 2, 89]),"2");
}

test();
