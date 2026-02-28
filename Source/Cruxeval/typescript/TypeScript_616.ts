function f(body: string): string {
    let ls = body.split('');
    let dist = 0;
    for (let i = 0; i < ls.length - 1; i++) {
        if (ls[i - 2 >= 0 ? i - 2 : 0] === '\t') {
            dist += (1 + (ls[i - 1].match(/\t/g) || []).length) * 3;
        }
        ls[i] = '[' + ls[i] + ']';
    }
    return ls.join('').replace(/\t/g, ' '.repeat(4 + dist));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("\n\ny\n"),"[\n][\n][y]\n");
}

test();
