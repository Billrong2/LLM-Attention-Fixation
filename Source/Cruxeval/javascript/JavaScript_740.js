function f(plot, delin){
    if (plot.includes(delin)) {
        let split = plot.indexOf(delin);
        let first = plot.slice(0, split);
        let second = plot.slice(split + 1);
        return first.concat(second);
    } else {
        return plot;
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3, 4], 3),[1, 2, 4]);
}

test();
