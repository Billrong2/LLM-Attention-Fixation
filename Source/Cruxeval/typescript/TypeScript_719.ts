function f(code: string): string {
    const lines: string[] = code.split(']');
    const result: string[] = [];
    let level: number = 0;
    for (let line of lines) {
        result.push(line[0] + ' ' + '  '.repeat(level) + line.slice(1));
        level += (line.match(/{/g) || []).length - (line.match(/}/g) || []).length;
    }
    return result.join('\n');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("if (x) {y = 1;} else {z = 1;}"),"i f (x) {y = 1;} else {z = 1;}");
}

test();
