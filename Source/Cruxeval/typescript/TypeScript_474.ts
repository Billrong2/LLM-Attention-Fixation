function f(txt: string, marker: number): string {
    let a: string[] = [];
    let lines: string[] = txt.split('\n');
    for (let line of lines) {
        a.push(line.padStart((marker + line.length) / 2).padEnd(marker));
    }
    return a.join('\n');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("#[)[]>[^e>\n 8", -5),"#[)[]>[^e>\n 8");
}

test();
