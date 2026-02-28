function f(text: string, value: string): string {
    let text_list: string[] = Array.from(text);
    text_list.push(value);
    return text_list.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("bcksrut", "q"),"bcksrutq");
}

test();
