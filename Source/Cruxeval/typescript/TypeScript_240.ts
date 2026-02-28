function f(float_number: number): string {
    let number: string = float_number.toString();
    let dot: number = number.indexOf('.');
    if (dot !== -1) {
        return number.slice(0, dot) + '.' + number.slice(dot+1).padEnd(2, '0');
    }
    return number + '.00';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(3.121),"3.121");
}

test();
