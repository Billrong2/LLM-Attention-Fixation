function f(first: number[], second: number[]): string| number[] {
    if (first.length < 10 || second.length < 10) {
        return 'no';
    }
    for (let i = 0; i < 5; i++) {
        if (first[i] !== second[i]) {
            return 'no';
        }
    }
    first.push(...second);
    return first;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 1], [1, 1, 2]),"no");
}

test();
