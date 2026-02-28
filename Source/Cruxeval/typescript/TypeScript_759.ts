function f(text: string, sub: string): number[] {
    const index: number[] = [];
    let starting = 0;
    while (starting !== -1) {
        starting = text.indexOf(sub, starting);
        if (starting !== -1) {
            index.push(starting);
            starting += sub.length;
        }
    }
    return index;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("egmdartoa", "good"),[]);
}

test();
