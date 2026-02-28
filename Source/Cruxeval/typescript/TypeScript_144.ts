function f(vectors: number[][]): number[][] {
    const sorted_vecs: number[][] = vectors.map(vec => {
        return vec.slice().sort((a, b) => a - b);
    });
    return sorted_vecs;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
