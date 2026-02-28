function f(text: string, char: string, min_count: number): string {
    const count: number = text.split(char).length - 1;
    if (count < min_count) {
        return text.toUpperCase() !== text ? text.toUpperCase() : text.toLowerCase();
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wwwwhhhtttpp", "w", 3),"wwwwhhhtttpp");
}

test();
