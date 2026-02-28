function f(a: any[], b: number[]): number[] {
    const d: {[key: string]: number} = {};
    a.forEach((key, index) => {
        d[key] = b[index];
    });

    a.sort((x, y) => d[y] - d[x]);

    return a.map((x) => d[x]);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["12", "ab"], [2, 2]),[2, 2]);
}

test();
