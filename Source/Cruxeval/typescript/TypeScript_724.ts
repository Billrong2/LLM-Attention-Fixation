function f(text: string, functionName: string): number[] {
    let cites: number[] = [text.substring(text.indexOf(functionName) + functionName.length).length];
    for (let char of text) {
        if (char == functionName) {
            cites.push(text.substring(text.indexOf(functionName) + functionName.length).length);
        }
    }
    return cites;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("010100", "010"),[3]);
}

test();
