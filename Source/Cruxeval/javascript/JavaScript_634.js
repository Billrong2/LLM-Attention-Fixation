function f(input_string){
    let table = {a:'i', i:'o', o:'u', e:'a', A:'I', I:'O', O:'U', E:'A'};
    while (input_string.includes('a') || input_string.includes('A')) {
        input_string = input_string.replace(/[aioeAIOE]/g, char => table[char]);
    }
    return input_string;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("biec"),"biec");
}

test();
