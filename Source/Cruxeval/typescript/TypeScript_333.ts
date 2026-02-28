function f(places: number[], lazy: number[]): number {
    places.sort();
    for (let l of lazy) {
        let index = places.indexOf(l);
        if (index !== -1) {
            places.splice(index, 1);
        }
    }
    if (places.length === 1) {
        return 1;
    }
    for (let i = 0; i < places.length; i++) {
        if (places.filter(p => p === places[i] + 1).length === 0) {
            return i + 1;
        }
    }
    return places.length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([375, 564, 857, 90, 728, 92], [728]),1);
}

test();
