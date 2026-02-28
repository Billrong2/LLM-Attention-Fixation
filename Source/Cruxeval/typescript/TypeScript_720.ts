function f(items: string[], item: string): number {
    while (items[items.length - 1] === item) {
        items.pop();
    }
    items.push(item);
    return items.length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["bfreratrrbdbzagbretaredtroefcoiqrrneaosf"], "n"),2);
}

test();
