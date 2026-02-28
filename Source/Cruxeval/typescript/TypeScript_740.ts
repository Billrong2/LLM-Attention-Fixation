function f(plot: number[], delin: number): number[] {
    if (plot.includes(delin)) {
        const split = plot.indexOf(delin);
        const first = plot.slice(0, split);
        const second = plot.slice(split + 1);
        return first.concat(second);
    } else {
        return plot;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3, 4], 3),[1, 2, 4]);
}

test();
