function f(input_string: string): string {
    let table: { [key: string]: string } = { 'a': 'i', 'i': 'o', 'o': 'u', 'e': 'a' };
    while (input_string.includes('a') || input_string.includes('A')) {
        input_string = input_string.replace(/[aioe]/gi, (match) => table[match.toLowerCase()]);
    }
    return input_string;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("biec"),"biec");
}

test();
