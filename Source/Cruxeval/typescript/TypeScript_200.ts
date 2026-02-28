function f(text: string, value: string): string {
    let length: number = text.length;
    let index: number = 0;
    while (length > 0) {
        value = text[index] + value;
        length--;
        index++;
    }
    return value;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("jao mt", "house"),"tm oajhouse");
}

test();
