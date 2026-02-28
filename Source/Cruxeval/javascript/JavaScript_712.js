function f(text){
    let created = [];
    let flush = 0;
    let lines = text.split('\n');
    for (let i = lines.length - 1; i >= 0; i--) {
        let line = lines[i];
        if (line === '') {
            break;
        }
        created.push([...line.trim().split('').reverse()[flush]]);
    }
    return created.reverse();
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("A(hiccup)A"),[["A"]]);
}

test();
