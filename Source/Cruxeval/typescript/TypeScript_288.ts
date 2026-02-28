function f(d: {[key: number]: number}): [number, number][] {
    let sortedPairs: [number, number][] = Object.entries(d).sort((a: [string, number], b: [string, number]) => {
        let aStr = a[0].toString() + a[1].toString();
        let bStr = b[0].toString() + b[1].toString();
        return aStr.length - bStr.length;
    }).map(pair => [Number(pair[0]), Number(pair[1])]);
    
    return sortedPairs.filter(([k, v]) => k < v);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({55: 4, 4: 555, 1: 3, 99: 21, 499: 4, 71: 7, 12: 6}),[[1, 3], [4, 555]]);
}

test();
