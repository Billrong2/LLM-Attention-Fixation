function f(text: string): number {
    let a: number = 0;
    if (text.slice(1).includes(text[0])) {
        a += 1;
    }

    for (let i = 0; i < text.length - 1; i++) {
        if (text.slice(i + 1).includes(text[i])) {
            a += 1;
        }
    }

    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("3eeeeeeoopppppppw14film3oee3"),18);
}

test();
