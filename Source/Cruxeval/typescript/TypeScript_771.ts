function f(items: number[]): number[] {
    const oddPositioned: number[] = [];
    while (items.length > 0) {
        const position = items.indexOf(Math.min(...items));
        items.splice(position, 1);
        const item = items.splice(position, 1)[0];
        oddPositioned.push(item);
    }
    return oddPositioned;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3, 4, 5, 6, 7, 8]),[2, 4, 6, 8]);
}

test();
