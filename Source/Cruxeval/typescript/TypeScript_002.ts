function f(text: string): string {
    let new_text: string[] = Array.from(text);
    for(let i of '+') {
        if (new_text.includes(i)) {
            new_text.splice(new_text.indexOf(i), 1);
        }
    }
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hbtofdeiequ"),"hbtofdeiequ");
}

test();
