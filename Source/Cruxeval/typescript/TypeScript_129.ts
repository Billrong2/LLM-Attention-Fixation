function f(text: string, search_string: string): number[] {
    const indexes: number[] = [];
    while (text.includes(search_string)) {
        indexes.push(text.lastIndexOf(search_string));
        text = text.substring(0, text.lastIndexOf(search_string));
    }
    return indexes;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ONBPICJOHRHDJOSNCPNJ9ONTHBQCJ", "J"),[28, 19, 12, 6]);
}

test();
