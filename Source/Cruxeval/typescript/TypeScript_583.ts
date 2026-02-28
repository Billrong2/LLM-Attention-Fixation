function f(text: string, ch: string): string {
    const result: string[] = [];
    text.split('\n').forEach((line) => {
        if (line.length > 0 && line[0] === ch) {
            result.push(line.toLowerCase());
        } else {
            result.push(line.toUpperCase());
        }
    });
    return result.join('\n');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("t\nza\na", "t"),"t\nZA\nA");
}

test();
