function f(c: {[key: string]: number}, st: number, ed: number): [string, string] {
    let d: {[key: number]: string} = {};
    let a: string = '';
    let b: string = '';

    for (const [x, y] of Object.entries(c)) {
        d[y] = x;
        if (y === st) {
            a = x;
        }
        if (y === ed) {
            b = x;
        }
    }

    const w: string = d[st];
    
    return a > b ? [w, b] : [b, w];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"TEXT": 7, "CODE": 3}, 7, 3),["TEXT", "CODE"]);
}

test();
