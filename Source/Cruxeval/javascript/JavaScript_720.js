function f(items, item){
    while (items[items.length - 1] === item) {
        items.pop();
    }
    items.push(item);
    return items.length;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["bfreratrrbdbzagbretaredtroefcoiqrrneaosf"], "n"),2);
}

test();
