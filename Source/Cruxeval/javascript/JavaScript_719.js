function f(code){
    let lines = code.split(']');
    let result = [];
    let level = 0;
    lines.forEach(line => {
        result.push(line[0] + ' ' + '  '.repeat(level) + line.slice(1));
        level += (line.match(/{/g) || []).length - (line.match(/}/g) || []).length;
    });
    return result.join('\n');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("if (x) {y = 1;} else {z = 1;}"),"i f (x) {y = 1;} else {z = 1;}");
}

test();
