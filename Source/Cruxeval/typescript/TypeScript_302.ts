function f(string: string): string {
    return string.replace('needles', 'haystacks');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wdeejjjzsjsjjsxjjneddaddddddefsfd"),"wdeejjjzsjsjjsxjjneddaddddddefsfd");
}

test();
