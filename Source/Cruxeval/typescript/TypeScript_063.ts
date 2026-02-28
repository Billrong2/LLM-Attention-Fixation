function f(text: string, prefix: string): string {
    while (text.startsWith(prefix)) {
        text = text.substring(prefix.length) || text;
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ndbtdabdahesyehu", "n"),"dbtdabdahesyehu");
}

test();
