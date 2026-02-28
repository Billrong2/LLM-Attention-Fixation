function f(items){
    items = Array.from(items);
    let odd_positioned = [];
    while (items.length > 0) {
        let position = items.indexOf(Math.min(...items));
        items.splice(position, 1);
        let item = items.splice(position, 1)[0];
        odd_positioned.push(item);
    }
    return odd_positioned;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3, 4, 5, 6, 7, 8]),[2, 4, 6, 8]);
}

test();
