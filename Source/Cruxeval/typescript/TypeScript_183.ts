function f(text: string): string[] {
    const ls: string[] = text.split(' ');
    const lines: string[] = ls.filter((_, index) => index % 3 === 0).join(' ').split('\n');
    const res: string[] = [];
    for (let i = 0; i < 2; i++) {
        const ln: string[] = ls.filter((_, index) => index % 3 === 1);
        if (3 * i + 1 < ln.length) {
            res.push(ln.slice(3 * i, 3 * (i + 1)).join(' '));
        }
    }
    return lines.concat(res);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("echo hello!!! nice!"),["echo"]);
}

test();
