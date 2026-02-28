function f(text: string, space_symbol: string, size: number): string {
    const spaces = space_symbol.repeat(Math.max(0, size - text.length));
    return text + spaces;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("w", "))", 7),"w))))))))))))");
}

test();
