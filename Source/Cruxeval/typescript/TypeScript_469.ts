function f(text: string, position: number, value: string): string {
    const length = text.length;
    let index = position % length;
    if (position < 0) {
        index = Math.floor(length / 2);
    }
    const new_text = text.split("");
    new_text.splice(index, 0, value);
    new_text.splice(length - 1, 1);
    return new_text.join("");
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("sduyai", 1, "y"),"syduyi");
}

test();
