function f(text: string): string {
    const nums = text.split('').filter(char => !isNaN(parseInt(char)));
    if (nums.length > 0) {
        return nums.join('');
    } else {
        throw new Error("No numeric characters found in the text");
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("-123   	+314"),"123314");
}

test();
