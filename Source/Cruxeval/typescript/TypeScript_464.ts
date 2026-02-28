function f(ans: string): number| string {
    if (!isNaN(parseInt(ans))) {
        let total: number = parseInt(ans) * 4 - 50;
        total -= Array.from(ans).filter(c => !'02468'.includes(c)).length * 100;
        return total;
    }
    return 'NAN';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("0"),-50);
}

test();
