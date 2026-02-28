function f(label1: string, char: string, label2: string, index: number): string {
    let m: number = label1.lastIndexOf(char);
    if (m >= index) {
        return label2.slice(0, m - index + 1);
    }
    return label1 + label2.slice(index - m - 1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ekwies", "s", "rpg", 1),"rpg");
}

test();
