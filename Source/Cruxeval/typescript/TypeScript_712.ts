function f(text: string): string[][] {
    const created: string[][] = [];
    for (const line of text.split('\n')) {
        if (line === '') {
            break;
        }
        created.push([line.trim().split('').reverse()[flush]]);
    }
    return created.reverse();
}

const flush: number = 0;
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("A(hiccup)A"),[["A"]]);
}

test();
