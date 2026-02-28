function f(sequence: string, value: string): string {
    const i: number = Math.max(sequence.indexOf(value) - Math.floor(sequence.length / 3), 0);
    let result: string = '';
    for (let j: number = 0; j < sequence.length - i; j++) {
        if (sequence[i + j] === '+') {
            result += value;
        } else {
            result += sequence[i + j];
        }
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hosu", "o"),"hosu");
}

test();
