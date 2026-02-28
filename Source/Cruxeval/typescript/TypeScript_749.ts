function f(text: string, width: number): string {
    let result: string = "";
    let lines: string[] = text.split('\n');
    for (let l of lines) {
        result += l.padStart((width + l.length) / 2).padEnd(width);
        result += '\n';
    }

    // Remove the very last empty line
    result = result.slice(0, -1);
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("l\nl", 2),"l \nl ");
}

test();
