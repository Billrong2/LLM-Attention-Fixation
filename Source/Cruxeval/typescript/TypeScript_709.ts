function f(text: string): string {
    let my_list: string[] = text.split(" ");
    my_list.sort((a, b) => b.localeCompare(a));
    return my_list.join(" ");
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a loved"),"loved a");
}

test();
