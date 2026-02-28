function f(pattern: string, items: string[]): number[] {
    const result: number[] = [];
    items.forEach(text => {
        const pos = text.lastIndexOf(pattern);
        if (pos >= 0) {
            result.push(pos);
        }
    });

    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(" B ", [" bBb ", " BaB ", " bB", " bBbB ", " bbb"]),[]);
}

test();
