function f(s: string, characters: number[]): string[] {
    return characters.map(i => s.slice(i, i+1));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("s7 6s 1ss", [1, 3, 6, 1, 2]),["7", "6", "1", "7", " "]);
}

test();
