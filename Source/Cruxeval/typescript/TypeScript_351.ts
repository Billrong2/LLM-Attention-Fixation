function f(text: string): string {
    while (text.includes('nnet lloP')) {
        text = text.replace('nnet lloP', 'nnet loLp');
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a_A_b_B3 "),"a_A_b_B3 ");
}

test();
