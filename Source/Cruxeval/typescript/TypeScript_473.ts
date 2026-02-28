function f(text: string, value: string): string {
    let indexes: number[] = [];
    for(let i = 0; i < text.length; i++) {
        if(text[i] === value) {
            indexes.push(i);
        }
    }
    let new_text: string[] = Array.from(text);
    indexes.sort((a, b) => b - a).forEach(i => new_text.splice(i, 1));
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("scedvtvotkwqfoqn", "o"),"scedvtvtkwqfqn");
}

test();
